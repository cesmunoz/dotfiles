#!/bin/bash
set -e

sudo -v

echo -e "\nInstalling dependencies"

sudo pacman -Syu

if [[ ! -f "`which gum`" ]]; then
  echo -e "\nInstalling Gum"
  sudo pacman -S gum
fi

sudo pacman -S \
  bluez \
  bluez-deprecated-tools \
  bluez-utils \
  flatpak \