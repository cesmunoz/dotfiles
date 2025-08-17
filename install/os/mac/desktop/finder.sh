#!/bin/bash

# Hide hard disks, external disks, CDs, and connected servers from desktop
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false

# Show hidden files (dotfiles) in Finder
defaults write com.apple.finder AppleShowAllFiles -bool true

# Restart Finder to apply changes
killall Finder