#!/bin/bash

# WALLPAPER
WALLPAPER_PATH="$REPO_DIR/images/wallpaper.jpg"
osascript -e "tell application \"System Events\" to set picture of every desktop to \"$WALLPAPER_PATH\""

# Dock
defaults write com.apple.dock persistent-apps -array
defaults write com.apple.dock autohide -bool true
killall Dock


# Finder
# Hide hard disks, external disks, CDs, and connected servers from desktop
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
killall Finder

# Keyboard
# Remap Caps Lock (bloq mayus) to Escape on macOS
hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x700000029}]}'
# Function keys over Function keys
defaults write -g com.apple.keyboard.fnState -bool true