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