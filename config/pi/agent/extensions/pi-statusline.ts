/** Pi status line: a width-aware footer. Load with /reload; /statusline toggles it. */
import { homedir } from "node:os";
import { basename } from "node:path";
import type { ExtensionAPI, ExtensionContext } from "@earendil-works/pi-coding-agent";
import { truncateToWidth, visibleWidth } from "@earendil-works/pi-tui";

// Prevent paths, model names and branch names from injecting terminal controls.
const plain = (text: string) => text.replace(/[\x00-\x1f\x7f-\x9f]/g, " ");
// 1000000 -> 1M, 1500000 -> 1.5M, 200000 -> 200k, 12345 -> 12.3k.
const tokens = (n: number) => n >= 1e6 ? `${+(n / 1e6).toFixed(1)}M` : n >= 1000 ? `${+(n / 1000).toFixed(1)}k` : `${n}`;

export default function (pi: ExtensionAPI) {
	let enabled = true;
	let requestRender = () => {};
	let requestGitRefresh = () => {};
	let disposeFooter = () => {};
	let statsDirty = true;
	let lastEntryCount = -1;
	let input = 0;
	let output = 0;
	let startedAt = Date.now();

	function install(ctx: ExtensionContext) {
		if (ctx.mode !== "tui") return;
		disposeFooter();
		ctx.ui.setFooter((tui, theme, footerData) => {
			let disposed = false;
			let pending = false;
			let rerun = false;
			let git: { staged: number; modified: number; untracked: number } | undefined;
			const controller = new AbortController();
			requestRender = () => { if (!disposed) tui.requestRender(); };

			// Async and bounded: never run subprocesses in render(), nor change the index.
			async function refreshGit() {
				if (disposed) return;
				if (pending) { rerun = true; return; } // Don't lose a request made while git is running.
				pending = true;
				try {
					const result = await pi.exec("git", ["--no-optional-locks", "status", "--porcelain=v1", "-z", "--untracked-files=normal"], {
						cwd: ctx.cwd, timeout: 2000, maxBuffer: 1024 * 1024, signal: controller.signal,
					});
					if (disposed) return;
					git = undefined;
					if (result.code === 0 && !result.truncated) {
						git = { staged: 0, modified: 0, untracked: 0 };
						const records = result.stdout.split("\0");
						for (let i = 0; i < records.length; i++) {
							const record = records[i];
							if (record.length < 3) continue;
							const x = record[0], y = record[1];
							if (x === "?" && y === "?") git.untracked++;
							else if (x !== "!" || y !== "!") {
								if (x !== " ") git.staged++;
								if (y !== " ") git.modified++;
							}
							if (x === "R" || x === "C" || y === "R" || y === "C") i++;
						}
					}
				} catch {
					if (!disposed) git = undefined;
				} finally {
					pending = false;
					if (!disposed) tui.requestRender();
					if (rerun && !disposed) { rerun = false; void refreshGit(); }
				}
			}
			requestGitRefresh = () => void refreshGit();

			// Git refreshes on events (tools, end of run, input, branch change). The slow tick updates
			// the minute counter and catches edits made outside Pi.
			const unsubscribe = footerData.onBranchChange(() => { tui.requestRender(); void refreshGit(); });
			const timer = setInterval(() => { tui.requestRender(); void refreshGit(); }, 60_000);
			timer.unref();
			void refreshGit();
			const dispose = () => {
				if (disposed) return;
				disposed = true;
				requestGitRefresh = () => {};
				clearInterval(timer);
				controller.abort();
				unsubscribe();
			};
			disposeFooter = dispose;

			return {
				dispose,
				invalidate() { statsDirty = true; },
				render(width: number): string[] {
					const entries = ctx.sessionManager.getEntries();
					if (statsDirty || entries.length !== lastEntryCount) {
						input = output = 0;
						// Same accounting as Pi: include compactions, nested tool usage and abandoned branches.
						for (const entry of entries) {
							const usage = entry.type === "message"
								? (entry.message.role === "assistant" || entry.message.role === "toolResult" ? entry.message.usage : undefined)
								: (entry.type === "usage" || entry.type === "compaction" || entry.type === "branch_summary" ? entry.usage : undefined);
							if (!usage) continue;
							input += usage.input + usage.cacheRead + usage.cacheWrite;
							output += usage.output;
						}
						statsDirty = false;
						lastEntryCount = entries.length;
					}
					// One line in every tier: full (>= 100), compact (60-99), narrow (< 60, e.g. phones).
					const compact = width < 100;
					const narrow = width < 60;
					const sep = theme.fg("dim", " | ");
					let name = plain(ctx.model?.name || ctx.model?.id || "no model");
					if (compact) name = name.replace(/^Claude\s+/i, "");
					const modelLimit = Math.max(8, Math.floor(width / (compact ? 3 : 4)));
					const model = truncateToWidth(theme.fg("accent", theme.bold(`[${name}]`)), modelLimit);
					const directory = ctx.cwd === homedir() ? "~" : basename(ctx.cwd);
					const branch = footerData.getGitBranch();
					// folder (branch); an item may list alternatives, longest first, and the first that fits is used.
					const folder = theme.fg("muted", plain(directory));
					const top: (string | string[])[] = [model, branch
						? [`${folder} ${theme.fg("dim", "(")}${theme.fg("accent", plain(branch))}${theme.fg("dim", ")")}`, folder]
						: folder];
					if (git) {
						// +staged ~changed ?untracked, joined without spaces, e.g. +2~4?6.
						const changes = [
							git.staged ? theme.fg("success", `+${git.staged}`) : "",
							git.modified ? theme.fg("warning", `~${git.modified}`) : "",
							git.untracked ? theme.fg("muted", `?${git.untracked}`) : "",
						].join("");
						if (changes) top.push(changes);
					}
					if (!compact && ctx.thinkingLevel !== "off") top.push(theme.fg("dim", `thinking:${ctx.thinkingLevel}`));

					const usage = ctx.getContextUsage();
					const percent = usage?.percent;
					const known = percent != null && Number.isFinite(percent);
					const pct = known ? Math.max(0, Math.min(100, percent)) : 0;
					const color = pct >= 90 ? "error" : pct >= 70 ? "warning" : "success";
					const windowSize = usage?.contextWindow || ctx.model?.contextWindow;
					const size = windowSize ? theme.fg("dim", `/${tokens(windowSize)}`) : "";
					const context = `${theme.fg(known ? color : "dim", known ? `${Math.floor(pct)}%` : "—%")}${size}`;
					const seconds = Math.max(0, Math.floor((Date.now() - startedAt) / 1000));
					// Minute precision is enough and matches the 60 s refresh tick.
					const elapsed = seconds < 60 ? "<1m" : seconds >= 3600 ? `${Math.floor(seconds / 3600)}h ${Math.floor(seconds % 3600 / 60)}m` : `${Math.floor(seconds / 60)}m`;
					const bottom = [context];
					if (!narrow) bottom.push(theme.fg("muted", elapsed)); // Hidden on phones.
					if (!compact) bottom.push(theme.fg("dim", `↑${tokens(input)} ↓${tokens(output)}`));
					const fits = (items: string[]) => visibleWidth(items.join(sep)) + 1 <= width;
					// Extension statuses stay inline, never adding another footer row.
					const statuses = [...footerData.getExtensionStatuses().values()].map(text => text.replace(/[\r\n]+/g, " "));
					// Keep the model and context visible; add secondary fields only if they fit.
					const parts = [model, context];
					for (const item of top.slice(1)) {
						const text = (typeof item === "string" ? [item] : item)
							.find(t => fits([...parts.slice(0, -1), t, parts[parts.length - 1]]));
						if (text) parts.splice(parts.length - 1, 0, text);
					}
					for (const item of [...statuses, ...bottom.slice(1)]) {
						if (fits([...parts, item])) parts.push(item);
					}
					return [truncateToWidth(` ${parts.join(sep)}`, Math.max(0, width))];
				},
			};
		});
	}

	pi.on("session_start", (_event, ctx) => {
		startedAt = Date.now(); // Time in this running session, excluding time closed.
		statsDirty = true;
		if (enabled) install(ctx);
	});
	pi.on("message_end", () => { statsDirty = true; requestRender(); });
	pi.on("session_compact", () => { statsDirty = true; requestRender(); });
	pi.on("session_tree", () => { statsDirty = true; requestRender(); });
	pi.on("model_select", () => requestRender());
	pi.on("thinking_level_select", () => requestRender());
	pi.on("agent_settled", () => { requestRender(); requestGitRefresh(); });
	pi.on("tool_execution_end", () => requestGitRefresh()); // Edits, writes and bash may change files.
	pi.on("input", () => { requestGitRefresh(); }); // Catch edits made outside Pi before a new message.
	pi.on("session_shutdown", () => { disposeFooter(); requestRender = () => {}; });
	pi.registerCommand("statusline", {
		description: "Toggle Pi status line / default Pi footer",
		handler: async (_args, ctx) => {
			if (ctx.mode !== "tui") return;
			enabled = !enabled;
			if (enabled) install(ctx);
			else { disposeFooter(); ctx.ui.setFooter(undefined); }
		},
	});
}
