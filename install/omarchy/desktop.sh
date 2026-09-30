#!/bin/bash
set -e

# Keep Omarchy's desktop stack intact. Do not install or overwrite Waybar,
# Hyprland, Hyprpaper, PipeWire, Walker, Wlogout, Wofi, Hyprshot, fonts, or Nautilus.

install_browser() {
  local browser="$1"
  if command -v "omarchy-install-browser" >/dev/null 2>&1; then
    omarchy-install-browser "$browser"
  else
    case "$browser" in
      chrome) yay -S --noconfirm --needed google-chrome ;;
      brave) yay -S --noconfirm --needed brave-bin ;;
    esac
  fi
}

install_editor() {
  local editor="$1"
  if command -v "omarchy-install-editor-$editor" >/dev/null 2>&1; then
    "omarchy-install-editor-$editor"
  else
    case "$editor" in
      vscode) yay -S --noconfirm --needed visual-studio-code-bin ;;
      zed) omarchy-pkg-add zed || yay -S --noconfirm --needed zed ;;
    esac
  fi
}

# Terminal
if ! command -v ghostty >/dev/null 2>&1; then
  omarchy-install-terminal ghostty || omarchy-pkg-add ghostty || yay -S --noconfirm --needed ghostty
fi

# Browsers
command -v google-chrome >/dev/null 2>&1 || command -v google-chrome-stable >/dev/null 2>&1 || install_browser chrome
command -v brave >/dev/null 2>&1 || install_browser brave

# Apps/services
command -v spotify >/dev/null 2>&1 || omarchy-install-service-spotify || omarchy-pkg-add spotify
command -v code >/dev/null 2>&1 || install_editor vscode
command -v zed >/dev/null 2>&1 || install_editor zed

# Slack as an Omarchy web app, not a native desktop package.
if command -v omarchy-webapp-install >/dev/null 2>&1 && [ ! -f "$HOME/.local/share/applications/Slack.desktop" ]; then
  omarchy-webapp-install "Slack" "https://app.slack.com/client" ""
fi
