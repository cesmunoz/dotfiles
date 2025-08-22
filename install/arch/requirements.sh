#!/bin/bash

# ------------------------------------------------------------------------------
# Requirements
# - Check yay is installed
# - Check gum is installed
# ------------------------------------------------------------------------------

# Ensure yay is installed
if ! command -v yay &>/dev/null; then
  sudo pacman -Sy --needed --noconfirm base-devel
  cd /tmp
  rm -rf yay-bin
  git clone https://aur.archlinux.org/yay-bin.git
  cd yay-bin
  makepkg -si --noconfirm
  cd -
  rm -rf yay-bin
  cd ~
fi

# Ensure gum is installed
if ! command -v gum &> /dev/null; then
  echo "gum is not installed. Installing..."
  yay -S --noconfirm --needed gum
  echo "gum installed successfully."
else
  echo "gum is already installed."
fi