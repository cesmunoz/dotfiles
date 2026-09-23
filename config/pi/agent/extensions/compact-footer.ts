import type { AssistantMessage } from "@earendil-works/pi-ai";
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { truncateToWidth, visibleWidth } from "@earendil-works/pi-tui";

function folderName(path: string): string {
	const parts = path.split(/[\\/]/).filter(Boolean);
	return parts.at(-1) || path || "~";
}

function compactBranch(branch: string): string {
	return branch
		.replace(/^feature\//, "feat/")
		.replace(/^feat\//, "")
		.replace(/^chore\//, "")
		.replace(/^fix\//, "")
		.replace(/^bugfix\//, "")
		.slice(0, 24);
}

function compactNumber(n: number): string {
	if (!Number.isFinite(n) || n <= 0) return "0";
	if (n < 1000) return String(Math.round(n));
	if (n < 1_000_000) return `${(n / 1000).toFixed(n < 10_000 ? 1 : 0)}k`;
	return `${(n / 1_000_000).toFixed(1)}m`;
}

function contextGauge(ctx: any, theme: any): string {
	const usage = ctx.getContextUsage?.();
	const percent = typeof usage?.percent === "number" ? usage.percent : null;
	const tokens = typeof usage?.tokens === "number" ? usage.tokens : 0;
	const contextWindow = usage?.contextWindow ?? ctx.model?.contextWindow ?? 0;
	const cells = 10;
	const used = Math.max(0, Math.min(100, percent ?? 0));
	let filled = Math.round((used / 100) * cells);
	if (used > 0 && filled === 0) filled = 1;
	if (used < 100 && filled === cells) filled = cells - 1;

	const color = percent == null ? "dim" : percent >= 90 ? "error" : percent >= 70 ? "warning" : "accent";
	const bar = theme.fg(color, "█".repeat(filled)) + theme.fg("dim", "░".repeat(cells - filled));
	const label = percent == null ? "?%" : `${percent.toFixed(percent >= 10 ? 0 : 1)}%`;
	const tokenLabel = contextWindow > 0
		? `${compactNumber(tokens)}/${compactNumber(contextWindow)}`
		: compactNumber(tokens);
	return `${theme.fg("dim", `🔋 ${tokenLabel} `)}${bar} ${theme.fg(color, label)}`;
}

function extensionStatusText(footerData: any): string {
	const statuses = footerData.getExtensionStatuses?.();
	if (!statuses) return "";
	if (statuses instanceof Map) return Array.from(statuses.values()).join(" · ");
	if (Array.isArray(statuses)) return statuses.join(" · ");
	return "";
}

function effortLabel(ctx: any): string {
	return ctx.thinkingLevel || "off";
}

function sessionUsage(ctx: any): {
	input: number;
	output: number;
	cacheRead: number;
	cacheWrite: number;
	cacheHitRate?: number;
	cost: number;
} {
	let input = 0;
	let output = 0;
	let cacheRead = 0;
	let cacheWrite = 0;
	let cost = 0;
	let cacheHitRate: number | undefined;

	for (const entry of ctx.sessionManager.getBranch()) {
		if (entry.type !== "message" || entry.message?.role !== "assistant") continue;
		const message = entry.message as AssistantMessage;
		const usage = message.usage;
		if (!usage) continue;
		input += usage.input ?? 0;
		output += usage.output ?? 0;
		cacheRead += usage.cacheRead ?? 0;
		cacheWrite += usage.cacheWrite ?? 0;
		cost += usage.cost?.total ?? 0;

		const promptTokens = (usage.input ?? 0) + (usage.cacheRead ?? 0) + (usage.cacheWrite ?? 0);
		if (promptTokens > 0) cacheHitRate = ((usage.cacheRead ?? 0) / promptTokens) * 100;
	}

	return { input, output, cacheRead, cacheWrite, cacheHitRate, cost };
}

function installFooter(ctx: any): void {
	if (!ctx.hasUI || ctx.mode !== "tui") return;

	ctx.ui.setFooter((tui: any, theme: any, footerData: any) => {
		const unsubBranch = footerData.onBranchChange?.(() => tui.requestRender()) ?? (() => {});

		return {
			dispose: unsubBranch,
			invalidate() {},
			render(width: number): string[] {
				const cwd = folderName(process.cwd());
				const branch = footerData.getGitBranch?.();
				const statusText = extensionStatusText(footerData);
				const { input, output, cost } = sessionUsage(ctx);

				const model = ctx.model?.id || "no-model";
				const location = branch
					? `${theme.fg("text", `📁 ${cwd}`)} ${theme.fg("muted", `🌿 ${compactBranch(branch)}`)}`
					: theme.fg("text", `📁 ${cwd}`);
				const modelPart = theme.fg("dim", `🤖 ${model}  🧠 ${effortLabel(ctx)}`);
				const contextPart = contextGauge(ctx, theme);
				const usagePart = theme.fg("dim", `↑${compactNumber(input)} ↓${compactNumber(output)}${cost > 0 ? `  💵 $${cost.toFixed(3)}` : ""}`);
				const status = statusText && width >= 120 ? ` ${theme.fg("dim", `│ ${statusText}`)}` : "";
				const sep = theme.fg("dim", " │ ");
				const line = `${modelPart}${sep}${location}${sep}${contextPart}${sep}${usagePart}${status}`;

				if (visibleWidth(line) <= width) return [line];
				return [truncateToWidth(line, width, theme.fg("dim", "…"))];
			},
		};
	});
}

export default function (pi: ExtensionAPI): void {
	let enabled = true;

	pi.on("session_start", (_event, ctx) => {
		if (enabled) installFooter(ctx);
	});

	pi.registerCommand("compact-footer", {
		description: "Toggle the compact one-line footer",
		handler: async (_args, ctx) => {
			enabled = !enabled;
			if (enabled) {
				installFooter(ctx);
				ctx.ui.notify("Compact footer enabled", "info");
			} else {
				ctx.ui.setFooter(undefined);
				ctx.ui.notify("Default footer restored", "info");
			}
		},
	});
}
