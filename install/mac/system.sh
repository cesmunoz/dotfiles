#!/bin/bash

# Git
git config --global credential.helper "/opt/homebrew/bin/gh auth git-credential"

# WALLPAPER
WALLPAPER_PATH="$REPO_DIR/images/wallpaper.jpeg"
osascript -e "tell application \"System Events\" to set picture of every desktop to \"$WALLPAPER_PATH\""

# Dock
defaults write com.apple.dock persistent-apps -array
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock tilesize -int 30
killall Dock

# Finder
# Hide hard disks, external disks, CDs, and connected servers from desktop
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false

# Allow finder to quit
defaults write com.apple.finder QuitMenuItem -bool true

# New Finder windows open with the Desktop as the target
defaults write com.apple.finder NewWindowTarget -string "PfDe"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop/"

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Show path
defaults write com.apple.finder ShowPathbar -bool true
# Check if Finder process exists
if pgrep -x "Finder" > /dev/null; then
    echo "Finder is running. Restarting Finder..."
    killall Finder
    sleep 2
else
    echo "Finder is not running. Attempting to start Finder..."
fi

# Keyboard
# Remap Caps Lock (bloq mayus) to Escape on macOS
hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x700000029}]}'
# Function keys over Function keys
defaults write -g com.apple.keyboard.fnState -bool true