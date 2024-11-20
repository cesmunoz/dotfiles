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
SELECTED_OPTIONAL_TOOLS=$(gum choose --no-limit "${OPTIONAL_TOOLS[@]}")

if [ -n "$SELECTED_OPTIONS" ]; then
  for tool in "${SELECTED_OPTIONAL_TOOLS[@]}"; do
    brew install $tool
  done
fi

echo -e "\nInstalling Kickstart Neovim"
rm -rf ~/.config/nvim
git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim

echo -e "\nStow Dependencies"
stow --adopt dotfiles -t $HOME