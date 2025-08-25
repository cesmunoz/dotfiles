#!/bin/bash

# ------------------------------------------------------------------------------
# Requirements
# - Check brew is installed
# - Check gum is installed
# ------------------------------------------------------------------------------

# Ensure Homebrew is installed
if ! command -v brew &> /dev/null; then
  echo "Homebrew is not installed. Installing..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo "Homebrew installed successfully."
else
  echo "Homebrew is already installed."
fi

# Ensure gum is installed
if ! command -v gum &> /dev/null; then
  echo "gum is not installed. Installing..."
  brew install gum
  echo "gum installed successfully."
else
  echo "gum is already installed."
fi

if pkgutil --pkg-info=com.apple.pkg.RosettaUpdateAuto &> /dev/null; then
  echo "Rosetta 2 is installed"
else
  sudo softwareupdate --install-rosetta
fi