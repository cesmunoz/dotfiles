#!/bin/bash
set -e

echo -e "\nInstalling Desktop dependencies"

brew install --cask\
  raycast \
  google-chrome \
  brave-browser \
  1password \
  warp \
  visual-studio-code \
  zed \
  postman \
  spotify \
  discord \


OPTIONAL_APPS=("slack" "studio-3t" "loom" "mongodb-compass")
SELECTED_OPTIONAL_APPS=$(gum choose --no-limit "${OPTIONAL_APPS[@]}")

if [ -n "$OPTIONAL_APPS" ]; then
  for tool in "${SELECTED_OPTIONAL_APPS[@]}"; do
    brew install --cask $tool
  done
fi

# Warp
defaults write dev.warp.Warp-Stable AltScreenPaddingOverride true
