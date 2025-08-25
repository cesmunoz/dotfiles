#!/bin/bash

brew install --force --cask\
  raycast \
  google-chrome \
  brave-browser \
  1password \
  ghostty \
  visual-studio-code \
  postman \
  spotify \
  discord \
  obs \
  visual-studio-code@insiders \
  slack \
  docker

cd $HOME

brew install --force --cask logi-options+

cd $HOME/dev/cm/dotfiles

# App store
AMPHETAMINE=937984704
mas install $AMPHETAMINE