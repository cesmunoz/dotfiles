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
rm -rf ~/.config/nvim
git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim

echo -e "\nStow Dependencies"
stow --adopt zsh -t $HOME
stow --adopt git -t $HOME
stow --adopt nvim -t $HOME
stow --adopt alacritty -t $HOME