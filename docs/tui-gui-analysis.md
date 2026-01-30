# TUI & GUI Approaches Analysis

> Analysis of current dotfiles setup, gaps, and recommended improvements for both **macOS** and **Arch Linux**.

---

## Current Setup Summary

| Category | Current Tool | Platform |
|----------|-------------|----------|
| Terminal Emulator | Ghostty (Dracula+ theme) | Both |
| Shell | Zsh + Oh-My-Zsh | Both |
| Prompt | Starship | Both |
| Editor | Neovim (Kickstart.nvim) + VS Code | Both |
| File Manager | Nautilus (GUI) | Linux |
| Git TUI | Lazygit | Both |
| Docker TUI | Lazydocker | Both |
| Fuzzy Finder | fzf | Both |
| Directory Nav | zoxide | Both |
| `ls` replacement | eza | Both |
| App Launcher | walker | Linux |
| Window Manager | Hyprland (Wayland) | Linux |
| Status Bar | Waybar | Linux |
| TUI Styling | gum | Both |
| Wifi TUI | impala | Linux |
| Audio TUI | wiremix | Linux |
| Multiplexer | **None** | -- |
| TUI File Manager | **None** | -- |
| System Monitor | **None** | -- |
| Shell History | **None (default)** | -- |
| `cat` replacement | **None** | -- |
| `grep` replacement | **None** | -- |
| `diff` replacement | **None** | -- |

---

## Gap Analysis & Recommendations

### 1. Terminal Multiplexer (HIGH priority)

**Gap:** No multiplexer configured. Relying solely on Ghostty's quick terminal.

**Why it matters:** A multiplexer provides persistent sessions (survive SSH disconnects), window/pane layouts, session management, and workflows like "dev", "logs", "db" in separate panels.

| Tool | Language | Learning Curve | Key Advantage |
|------|---------|----------------|---------------|
| **Zellij** | Rust | Low | Built-in keybinding hints, floating panes, no prefix key needed, WebAssembly plugins |
| **tmux** | C | High | Massive ecosystem (TPM + hundreds of plugins), universal on servers |

**Recommendation:**
- **New users / modern UX:** Zellij -- contextual hints mean zero memorization, `Alt+H/J/K/L` navigation without prefix key
- **Server/SSH heavy:** tmux -- universally available, session persistence is battle-tested

**Installation:**

```bash
# Arch Linux
sudo pacman -S zellij   # or: sudo pacman -S tmux

# macOS
brew install zellij     # or: brew install tmux
```

---

### 2. TUI File Manager (HIGH priority)

**Gap:** Using Nautilus (GUI) as the only file manager. No terminal-native option.

| Tool | Language | Memory | Async I/O | Image Preview | Out-of-box Experience |
|------|---------|--------|-----------|---------------|----------------------|
| **Yazi** | Rust | ~38MB | Full | Built-in (Kitty/iTerm2/Sixel) | Excellent |
| **lf** | Go | ~12MB | Partial | Via scripts | Minimal |
| **nnn** | C | ~3.4MB | No | Via plugins | Minimal |
| **Superfile** | Go | <10MB | Partial | Limited | Good |
| Ranger | Python | ~28MB | No | Manual setup | Good (legacy) |

**Recommendation:** **Yazi** -- async I/O never blocks the UI, native image previews in Ghostty/Kitty, Lua plugin system, integrates with zoxide and ripgrep, tab support.

**Installation:**

```bash
# Arch Linux
sudo pacman -S yazi

# macOS
brew install yazi
```

**Suggested alias:**
```bash
alias y="yazi"
```

---

### 3. Modern CLI Replacements (MEDIUM priority)

**Gap:** Missing `bat` (cat), `ripgrep` (grep), `delta` (diff), `dust` (du), `procs` (ps), `sd` (sed).

Already have: `eza` (ls), `fd` (find), `fzf`.

| Modern Tool | Replaces | Key Advantage |
|-------------|----------|---------------|
| **bat** | `cat` | Syntax highlighting, line numbers, Git integration |
| **ripgrep (rg)** | `grep` | 10-100x faster, smart case, respects `.gitignore` |
| **delta** | `git diff` | Syntax-highlighted diffs, word-level changes, side-by-side |
| **dust** | `du` | Visual disk usage tree, human-readable |
| **procs** | `ps` | Color-coded process list, structured output |
| **sd** | `sed` | Simple regex replace: `sd 'old' 'new'` |
| **tokei** | `cloc` | Fast code statistics by language |
| **hyperfine** | `time` | Statistical benchmarking |

**Installation:**

```bash
# Arch Linux
sudo pacman -S bat ripgrep git-delta dust procs sd tokei hyperfine

# macOS
brew install bat ripgrep git-delta dust procs sd tokei hyperfine
```

**Suggested aliases:**
```bash
alias cat='bat'
alias grep='rg'
alias du='dust'
alias ps='procs'
alias diff='delta'
```

**Git delta config** (add to `.gitconfig`):
```ini
[core]
    pager = delta

[interactive]
    diffFilter = delta --color-only

[delta]
    navigate = true
    side-by-side = true
    line-numbers = true
    syntax-theme = Dracula

[merge]
    conflictstyle = diff3
```

---

### 4. System Monitor TUI (MEDIUM priority)

**Gap:** No TUI system monitor installed.

| Tool | Language | CPU Usage | Visual Richness | Remote/Web UI |
|------|---------|-----------|-----------------|---------------|
| **btop** | C++ | 1-3% | Excellent (graphs, per-core, disk, net) | No |
| **bottom (btm)** | Rust | <1% | Good | No |
| htop | C | ~13% | Basic (bars + processes) | No |
| Glances | Python | ~20% | Good | Yes (web + REST API) |

**Recommendation:**
- **Local monitoring:** **btop** -- rich dashboard with time-series graphs, mouse support, low CPU
- **Remote/server monitoring:** **Glances** -- built-in web UI (`glances -w`), exports to Prometheus/Grafana

**Installation:**

```bash
# Arch Linux
sudo pacman -S btop

# macOS
brew install btop
```

---

### 5. Shell History Management (MEDIUM priority)

**Gap:** Using default Zsh history (no context, no sync, no search UI).

| Tool | Key Feature |
|------|------------|
| **Atuin** | Records context (directory, duration, exit code), encrypted cloud sync, SQLite-backed, TUI search |
| **fzf Ctrl+R** | Already available via fzf -- basic but functional |

**Recommendation:** **Atuin** -- records every command with context, searchable TUI, optional encrypted sync across machines.

**Installation:**

```bash
# Arch Linux
sudo pacman -S atuin

# macOS
brew install atuin
```

**Init (add to zsh/init):**
```bash
if command -v atuin &> /dev/null; then
  eval "$(atuin init zsh)"
fi
```

---

### 6. Shell Framework Optimization (LOW priority)

**Gap:** Oh-My-Zsh accounts for ~55% of shell startup time. Profiling shows:
- OMZ source: ~55.73%
- compinit: ~30.76%
- syntax highlighting: ~14.63%

| Framework | Startup Speed | Ease of Use |
|-----------|--------------|-------------|
| Oh-My-Zsh | ~200ms+ | Very easy |
| **Zinit** | ~40ms (Turbo mode) | Steep learning curve |
| **Zim** | ~50ms | Moderate |
| Antidote | Fast | Easy |

**Recommendation:** If startup speed matters, migrate from Oh-My-Zsh to **Zinit** with Turbo mode for 50-80% faster startup. If current speed is acceptable, Oh-My-Zsh is fine -- it's the most well-documented option.

---

### 7. Ghostty Configuration Enhancements (LOW priority)

**Gap:** Minimal Ghostty config (only theme, quick terminal, one keybind).

**Recommended additions:**

```ini
# ─── Font ──────────────────────────────────────────────
font-family = "CaskaydiaCove Nerd Font"
font-size = 14

# ─── Window ────────────────────────────────────────────
window-padding-x = 10
window-padding-y = 5
window-decoration = false
confirm-close-surface = false

# ─── Cursor ────────────────────────────────────────────
cursor-style = block
cursor-style-blink = false

# ─── Clipboard ─────────────────────────────────────────
copy-on-select = clipboard
clipboard-paste-protection = false

# ─── Shell Integration ─────────────────────────────────
shell-integration = zsh
```

---

## Platform-Specific Approaches

### macOS-Specific

| Category | Recommended | Why |
|----------|------------|-----|
| Terminal | **Ghostty** (already using) | Native Metal rendering, macOS-specific features (Quick Look, proxy icon) |
| Window Tiling | **Aerospace** or **yabai** | Tiling WM for macOS (Aerospace is newer, simpler; yabai is more powerful) |
| App Launcher | **Raycast** (already using) | Superior to Spotlight, extensible |
| Hotkey Daemon | Built-in or **skhd** | Keyboard shortcuts for window management |
| Clipboard Manager | **Maccy** | Lightweight, open source clipboard history |
| Quick Look | Built-in + plugins | Preview files without opening (Ghostty supports this) |

**macOS TUI/GUI considerations:**
- No Wayland/X11 -- uses Quartz/Metal natively
- Ghostty uses Metal renderer (best macOS performance)
- WezTerm is the alternative if you need cross-platform consistency with Windows
- iTerm2 remains viable for its Python API and tmux integration mode

### Linux (Arch + Hyprland) Specific

| Category | Recommended | Why |
|----------|------------|-----|
| Terminal | **Ghostty** (already using) | Good Wayland support. Alternative: **Foot** for ultra-lightweight secondary terminal |
| Compositor | **Hyprland** (already using) | Best Wayland compositor for tiling + animations |
| Status Bar | **Waybar** (already using) | Most customizable Wayland bar |
| App Launcher | **walker** (already using) | Good dmenu replacement. Alternative: **fuzzel** (simpler) or **rofi-wayland** |
| Notification | **dunst** or **mako** | Wayland-native notification daemon |
| Clipboard | **wl-clip-persist** (already using) + **cliphist** | Add clipboard history TUI |
| Screen Lock | **hyprlock** | Hyprland-native lock screen |
| Idle Daemon | **hypridle** | Hyprland-native idle management |
| Screenshot | **hyprshot** (already using) | Alternative: **grim + slurp** for more control |

**Wayland-specific notes:**
- Avoid X11-only tools (xclip, xdotool, xrandr) -- use Wayland equivalents (wl-copy, wtype, wlr-randr)
- Ghostty + Kitty have the best Wayland support among GPU-accelerated terminals
- Foot is the lightest Wayland terminal if you need a secondary option

---

## Recommended "Modern TUI Stack"

### Tier 1 -- Install Now (High Impact)

| Tool | Category | Install (Arch) | Install (macOS) |
|------|----------|----------------|-----------------|
| **Zellij** | Multiplexer | `pacman -S zellij` | `brew install zellij` |
| **Yazi** | File Manager | `pacman -S yazi` | `brew install yazi` |
| **btop** | System Monitor | `pacman -S btop` | `brew install btop` |
| **bat** | cat replacement | `pacman -S bat` | `brew install bat` |
| **ripgrep** | grep replacement | `pacman -S ripgrep` | `brew install ripgrep` |
| **delta** | diff replacement | `pacman -S git-delta` | `brew install git-delta` |

### Tier 2 -- Nice to Have (Medium Impact)

| Tool | Category | Install (Arch) | Install (macOS) |
|------|----------|----------------|-----------------|
| **Atuin** | Shell history | `pacman -S atuin` | `brew install atuin` |
| **dust** | du replacement | `pacman -S dust` | `brew install dust` |
| **procs** | ps replacement | `pacman -S procs` | `brew install procs` |
| **sd** | sed replacement | `pacman -S sd` | `brew install sd` |
| **tokei** | Code stats | `pacman -S tokei` | `brew install tokei` |
| **hyperfine** | Benchmarking | `pacman -S hyperfine` | `brew install hyperfine` |

### Tier 3 -- Optional Enhancements

| Tool | Category | Notes |
|------|----------|-------|
| **Zinit** | Zsh framework | Replace Oh-My-Zsh for faster startup |
| **K9s** | Kubernetes TUI | Only if using Kubernetes |
| **Foot** | Secondary terminal | Ultra-light Wayland terminal for Linux |
| **Nushell** | Alternative shell | Structured data shell -- steep learning curve |

---

## Quick Start: One-Line Install

```bash
# Arch Linux -- Tier 1
sudo pacman -S --noconfirm --needed zellij yazi btop bat ripgrep git-delta

# Arch Linux -- Tier 2
sudo pacman -S --noconfirm --needed atuin dust procs sd tokei hyperfine

# macOS -- Tier 1
brew install zellij yazi btop bat ripgrep git-delta

# macOS -- Tier 2
brew install atuin dust procs sd tokei hyperfine
```

---

## Summary

Your current setup is solid -- Ghostty, Zsh+Starship, lazygit, eza, fzf, and zoxide form a good foundation. The biggest gaps are:

1. **No multiplexer** -- Zellij gives you persistent sessions, pane layouts, and floating windows
2. **No TUI file manager** -- Yazi replaces Nautilus for terminal-first workflows with async I/O and image previews
3. **Missing CLI replacements** -- bat, ripgrep, and delta are the highest-impact additions
4. **No system monitor** -- btop provides a rich dashboard at minimal CPU cost
5. **Default shell history** -- Atuin adds context-aware, searchable, optionally synced history
