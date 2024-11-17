#!/bin/bash
set -e

echo -e "\nInstalling Terminal dependencies"

brew update

brew install  \
  git \
  curl \
  neovim \
  fzf \
  zoxide \
  gh \
  eza \
  fd \
  zellij \
  lazygit \
  stow \
  mise

OPTIONAL_TOOLS=("awscli" "cloudflared")
SELECTED_OPTIONS=$(gum choose --no-limit "${OPTIONAL_TOOLS[@]}")

for tool in "${SELECTED_OPTIONS[@]}"; do
  brew install $tool
done

echo -e "\nInstalling Kickstart Neovim"
git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim