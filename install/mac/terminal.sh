#!/bin/bash

brew install \
  git \
  curl \
  neovim \
  eza \
  fd \
  fzf \
  zoxide \
  gh \
  lazygit \
  stow \
  mise \
  pnpm \
  cloudflared \
  mas \
  tailscale


# Oh my zsh
if [ -d "$HOME/.oh-my-zsh" ]; then
	echo "Oh My Zsh is already installed."
else
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Kickstart neovim
rm -rf ~/.config/nvim
git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
rm ~/.config/nvim/init.lua

# Starship
if ! command -v starship &> /dev/null; then
  curl -sS https://starship.rs/install.sh | sh
else
  echo "Starship is already installed"
fi

# AWS cli
if ! command -v aws &> /dev/null; then
  cd
  curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
  sudo installer -pkg AWSCLIV2.pkg -target /
  cd $REPO_DIR
  rm $HOME/AWSCLIV2.pkg
else
  echo "AWS CLI is already installed."
fi

