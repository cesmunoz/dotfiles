#!/bin/bash
set -e

echo -e "\nInstalling Terminal dependencies"

sudo pacman -S \
  zsh \
  eza \
  fzf \
  git \
  github-cli \
  lazygit \
  neovim \
  nodejs \
  otf-font-awesome \
  pnpm \
  stow \
  unzip \
  zip \
  waybar \
  woff-fira-code \
  woff2-cascadia-code \
  zoxide \
  cloudflared \

echo -e "\nInstalling AWS CLI"
cd ~./$HOME/
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install --update
rm awscliv2.zip
cd ./dev/cm/dotfiles

echo -e "\nInstalling Kickstart Neovim"
rm -rf ~/.config/nvim
git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim

echo -e "\nStow Dependencies"
stow --adopt dotfiles -t $HOME