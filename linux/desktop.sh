#!/bin/bash
set -e

echo -e "\nInstalling Desktop dependencies - pacman"

sudo pacman -S \
  dunst \
  firefox \
  obs-studio  \
  spotify-launcher \

echo -e "\nInstalling Desktop dependencies - yay"

yay -s \
  google-chrome \
  hyprshot \
  mongodb-compass \
  visual-studio-code-bin \
  slack-desktop \


