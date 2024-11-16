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
  rectangle \
  spotify \
  discord \
  alacritty

OPTIONAL_TOOLS=("slack" "studio-3t" "loom" "mongodb-compass")
SELECTED_OPTIONS=$(gum choose --no-limit "${OPTIONAL_TOOLS[@]}")

for tool in "${SELECTED_OPTIONS[@]}"; do
  brew install --cask $tool
done