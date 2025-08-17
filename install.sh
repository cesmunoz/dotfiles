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
REPO_INSTALL_DIR="${REPO_DIR}/install"

# Guard
source $REPO_INSTALL_DIR/guard.sh

# Requirements
REPO_INSTALL_OS_DIR="${REPO_INSTALL_DIR}/os/${OS}"
source $REPO_INSTALL_OS_DIR/requirements.sh

# Start process
echo -e "$ascii_banner"
echo -e "Starting installation..."

# Setup
source $REPO_INSTALL_OS_DIR/setup.sh

echo -e "\n\n 🎉 Setup complete"
echo -e "\n\n"
