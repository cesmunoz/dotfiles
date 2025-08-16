#!/bin/bash

# ------------------------------------------------------------------------------
# Setup Mac
# - Configuration of the OS
# - Development tools
# - Desktop Apps
# ------------------------------------------------------------------------------

echo -e "🖥️ Welcome to the Mac os installer"

# Configuration

# Development
source $REPO_INSTALL_OS_DIR/development/terminal.sh
source $REPO_INSTALL_OS_DIR/development/oh-my-zsh.sh
source $REPO_INSTALL_OS_DIR/development/neovim.sh
source $REPO_INSTALL_OS_DIR/development/stow.sh

# Desktop
source $REPO_INSTALL_OS_DIR/desktop/apps.sh

