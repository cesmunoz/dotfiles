#!/bin/bash

# ------------------------------------------------------------------------------
# Setup Mac
# - Configuration of the OS
# - Development tools
# - Desktop Apps
# ------------------------------------------------------------------------------

echo -e
gum confirm "🖥️  Welcome to the Mac OS installer. Press any key to continue." || exit 1

# Configuration

# Development
source $REPO_INSTALL_OS_DIR/development/terminal.sh
source $REPO_INSTALL_OS_DIR/development/oh-my-zsh.sh
source $REPO_INSTALL_OS_DIR/development/neovim.sh
source $REPO_INSTALL_OS_DIR/development/stow.sh
source $REPO_INSTALL_OS_DIR/development/awscli.sh

# Desktop
source $REPO_INSTALL_OS_DIR/desktop/apps.sh
source $REPO_INSTALL_OS_DIR/desktop/mas.sh
source $REPO_INSTALL_OS_DIR/desktop/manual.sh
source $REPO_INSTALL_OS_DIR/desktop/wallpaper.sh
source $REPO_INSTALL_OS_DIR/desktop/dock.sh
source $REPO_INSTALL_OS_DIR/desktop/keyboard.sh


