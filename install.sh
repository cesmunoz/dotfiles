#!/bin/bash
set -e

# ------------------------------------------------------------------------------
# Dotfiles installer
# - Detects OS (macOS vs Omarchy)
# - Copies config files + OS-specific dotfiles
# - Applies per-OS steps (brew defaults on mac, Omarchy helpers on Linux)
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
echo "$ascii_banner"
echo "Starting installation..."

# Installation
INSTALLATION_OS="${INSTALL_DIR}/${OS}"
source $INSTALLATION_OS/requirements.sh

echo "🖥️  Welcome to the ${OS} installer."

source $INSTALLATION_OS/terminal.sh
source $INSTALLATION_OS/desktop.sh
source $INSTALLATION_OS/config.sh
source $INSTALLATION_OS/system.sh
source $INSTALLATION_OS/extra.sh

echo "\n\n 🎉 Setup complete"
echo "\n\n"
