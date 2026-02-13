#!/bin/bash

sudo pacman -S --noconfirm --needed \
  obs-studio \
  hyprpaper \
  xdg-desktop-portal-hyprland \
  pipewire \
  pipewire-audio \
  pipewire-pulse \
  pipewire-alsa \
  wireplumber \
  gnupg

yay -S --noconfirm --needed \
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
  wl-clip-persist \
  nautilus \
  sushi \
  wlogout \
  waybar \
  hyprshot \

# FONTS
yay -S --noconfirm --needed \
  ttf-cascadia-code \
  ttf-cascadia-code-nerd \
  ttf-font-awesome \
  ttf-cascadia-mono-nerd \
  ttf-ia-writer \
  noto-fonts \
  noto-fonts-emoji \
  ttf-jetbrains-mono \
  noto-fonts-cjk \
  noto-fonts-extra


# Wofi
if [ -d ./config/wofi ]; then
  echo "Directory ./config/wofi exists. Removing..."
  yay -Rns --noconfirm wofi
  rm -rf ~/.config/wofi
else
  echo "Directory ./config/wofi does not exist."
fi
