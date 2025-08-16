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

echo -e "\n\nSetup complete"
echo -e "\n\n"


# FOR MAC We need to create a later installation for later setup
# awscli later
# cloudflared later
# mongodb-compass
# slack
# logi options +
# Amphetamine
# Docker
# Autofirma
# wazuh

# FOR Linux
#zsh, oh my zsh and adjust .zshrc, eza, fzf, git, curl, neovim, fd, fzf, zoxide
#gh, lazygit, stow, mise, ffmpeg, pnpm
#unzip, zip, waybar, cloudflared, aws cli, mongodb-compass, slack, dunst,
# firefox, obs-studio, spotify, chrome, brave, 1password, ghostty, vscode,
# vscode-insiders, postman, discord, screen shots

# -STOW
#- Requirements
