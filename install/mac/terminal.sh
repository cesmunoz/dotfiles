#!/bin/bash

gum log --level info "Setup Terminal"

# Oh my zsh
if [ -d "$HOME/.oh-my-zsh" ]; then
	echo "Oh My Zsh is already installed."
else
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Kickstart neovim
if [ -d "$HOME/.config/nvim" ]; then
  echo "Oh My Zsh is already installed."
else
  git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
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

