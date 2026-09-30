# Dotfiles

Personal dotfiles for macOS and Omarchy.

The Linux profile now targets **Omarchy**, not a generic Arch Linux install. Omarchy owns the desktop stack, so this repo avoids installing or overwriting Waybar, Hyprland base files, Hyprpaper, PipeWire, Walker, Wlogout, Wofi, Hyprshot, fonts, and Nautilus.

## Structure

```text
install/
  mac/
  omarchy/
config/
  ghostty/
  hypr/        # Omarchy-compatible personal overrides
  mise/
  nvim/
  pi/
  zsh/
```

## Install

Clone the repo into the expected path:

```bash
mkdir -p ~/dev/cm
git clone https://github.com/cesmunoz/dotfiles.git ~/dev/cm/dotfiles
cd ~/dev/cm/dotfiles
./install.sh
```

Do **not** run the installer with `sudo`; scripts call `sudo` only where needed.

## Omarchy profile

The Omarchy installer keeps the system close to Omarchy defaults and only adds personal preferences.

Installs/configures:

- Ghostty
- Chrome
- Brave
- Spotify
- VS Code
- Zed
- Slack as an Omarchy web app
- Git/GitHub CLI integration when authenticated
- Tailscale when installed
- personal configs: Git, Starship, Ghostty, Mise, Zsh files, Pi agent config

Avoids:

- Waybar config
- Wlogout config
- generic Arch desktop bootstrap
- Wofi
- Hyprpaper
- PipeWire/WirePlumber setup
- Walker
- Hyprshot
- font packages
- Nautilus/Sushi install
- Thunderbird
- native Slack desktop package

## Omarchy Hyprland customization

`config/hypr/` contains Omarchy-style Lua overrides. It keeps Omarchy defaults and applies only personal tweaks for:

- gaps/borders/rounding/blur
- keyboard/input basics
- three-finger workspace gesture
- small custom keybinding overrides

