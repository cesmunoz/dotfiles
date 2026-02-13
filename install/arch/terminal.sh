#!/bin/bash

sudo pacman -S --noconfirm --needed \
  curl \
  neovim \
  eza \
  fd \
  wget \
  zip \
  unzip \
  fzf \
  zoxide \
  github-cli \
  lazygit \
  mise \
  cloudflared \
  zsh \
  starship \
  tailscale \
  docker \
  docker-compose \
  bluez \
  bluez-utils \
  bluez-deprecated-tools \
  bluetui \
  impala

yay -S --noconfirm --needed \
  lazydocker-bin

# Oh my zsh
if [ -d "$HOME/.oh-my-zsh" ]; then
	echo "Oh My Zsh is already installed."
else
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Switch to Zsh
if [ "$SHELL" != "$(which zsh)" ]; then
	echo "Switching to Zsh..."
	chsh -s "$(which zsh)"
	echo "Please log out and log back in to apply the changes."
else
	echo "You are already using Zsh."
fi

# Kickstart Neovim
if [ -d "$HOME/.config/nvim" ]; then
  echo "Oh My Zsh is already installed."
else
  git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
fi

# AWS cli
if ! command -v aws &> /dev/null; then
  cd
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  sudo ./aws/install
  cd $REPO_DIR
  rm ~/awscliv2.zip
else
  echo "AWS CLI is already installed."
fi





