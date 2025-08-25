#!/bin/bash

sudo pacman -S --noconfirm --needed \
  obs-studio \
  hyprpaper \
  xdg-desktop-portal-hyprland \
  pipewire \
  pipewire-audio \
  pipewire-pulse \
  pipewire-alsa \
  wireplumber

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
  walker-bin \
  ttf-cascadia-code \
  ttf-cascadia-code-nerd \
  ttf-font-awesome \
  ttf-cascadia-mono-nerd \
  ttf-ia-writer \
  noto-fonts \
  noto-fonts-emoji \
  ttf-jetbrains-mono \
  noto-fonts-cjk \
  noto-fonts-extra \
  wireplumber \
  wl-clip-persist \
  nautilus \
  sushi \
  wlogout \
  waybar

if [ -d ./config/wofi ]; then
  echo "Directory ./config/wofi exists. Removing..."
  yay -Rns --noconfirm wofi
  rm -rf ~/.config/wofi
else
  echo "Directory ./config/wofi does not exist."
fi
