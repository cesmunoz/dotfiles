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
  alacritty \
  sf-symbols


OPTIONAL_APPS=("slack" "studio-3t" "loom" "mongodb-compass")
SELECTED_OPTIONAL_APPS=$(gum choose --no-limit "${OPTIONAL_APPS[@]}")

if [ -n "$OPTIONAL_APPS" ]; then
  for tool in "${SELECTED_OPTIONAL_APPS[@]}"; do
    brew install --cask $tool
  done
fi

# Aerospace configuration
brew install --cask nikitabobko/tap/aerospace

## Junkyborders
brew tap FelixKratz/formulae
brew install borders

## Sketchybar
brew tap FelixKratz/formulae
brew install sketchybar

mkdir -p ~/.config/sketchybar/plugins
cp $(brew --prefix)/share/sketchybar/examples/sketchybarrc ~/.config/sketchybar/sketchybarrc
cp -r $(brew --prefix)/share/sketchybar/examples/plugins/ ~/.config/sketchybar/plugins/

brew install --cask font-hack-nerd-font

brew services start sketchybar
brew services start borders

# Warp
defaults write dev.warp.Warp-Stable AltScreenPaddingOverride true
