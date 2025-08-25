#!/bin/bash
set -e

# ------------------------------------------------------------------------------
# Dotfiles installer
# - Detects OS (macOS vs Arch Linux)
# - Ensures gum + stow + core CLI tools
# - Stows common + OS-specific dotfiles
# - Applies per-OS steps (brew defaults on mac, yay + chsh on Arch)
# ------------------------------------------------------------------------------

ascii_banner='
░███████                 ░██        ░████ ░██░██
░██   ░██                ░██       ░██       ░██
░██    ░██  ░███████  ░████████ ░████████ ░██░██  ░███████   ░███████
░██    ░██ ░██    ░██    ░██       ░██    ░██░██ ░██    ░██ ░██
░██    ░██ ░██    ░██    ░██       ░██    ░██░██ ░█████████  ░███████
░██   ░██  ░██    ░██    ░██       ░██    ░██░██ ░██               ░██
░███████    ░███████      ░████    ░██    ░██░██  ░███████   ░███████

🚀 Cross-platform Dotfiles Setup 🚀
'

# Values for the installation
OS=$(uname -s)
REPO_DIR="${HOME}/dev/cm/dotfiles"
INSTALL_DIR="${REPO_DIR}/install"
DOTFILES_DIR="${REPO_DIR}/dotfiles"

# Guard
source $INSTALL_DIR/guard.sh

# Start process
echo -e "$ascii_banner"
echo -e "Starting installation..."

# Terminal
INSTALLATION_OS="${INSTALL_DIR}/${OS}"

source $INSTALLATION_OS/requirements.sh

gum confirm "🖥️  Welcome to the ${OS} installer. Press any key to continue." || exit 1

source $INSTALLATION_OS/terminal.sh
source $INSTALLATION_OS/desktop.sh
source $INSTALLATION_OS/stow.sh
source $INSTALLATION_OS/system.sh
source $INSTALLATION_OS/extra.sh

echo -e "\n\n 🎉 Setup complete"
echo -e "\n\n"
