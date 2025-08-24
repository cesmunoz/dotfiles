#!/bin/bash

sudo pacman -S --noconfirm --needed \
  obs-studio

yay -S --noconfirm --needed \
  blueberry \
  ghostty \
  google-chrome \
  slack-desktop \
  spotify \
  brave-bin \
  visual-studio-code-bin \
  thunderbird \
  discord \
  otf-font-awesome \
  wiremix \
  pamixer \
  walker-bin

if [ -d ./config/wofi ]; then
  echo "Directory ./config/wofi exists. Removing..."
  yay -Rns --noconfirm wofi
  rm -rf ~/.config/wofi
else
  echo "Directory ./config/wofi does not exist."
fi
