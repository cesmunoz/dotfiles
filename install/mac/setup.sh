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
source $REPO_INSTALL_OS_DIR/development/stow.sh


# Desktop
source $REPO_INSTALL_OS_DIR/desktop/apps.sh
source $REPO_INSTALL_OS_DIR/desktop/mas.sh
source $REPO_INSTALL_OS_DIR/desktop/wallpaper.sh
source $REPO_INSTALL_OS_DIR/desktop/dock.sh
source $REPO_INSTALL_OS_DIR/desktop/keyboard.sh
source $REPO_INSTALL_OS_DIR/desktop/finder.sh
source $REPO_INSTALL_OS_DIR/desktop/manual.sh


