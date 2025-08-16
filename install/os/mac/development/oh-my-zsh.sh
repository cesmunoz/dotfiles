#!/bin/bash

# Check if Oh My Zsh is installed
if [ -d "$HOME/.oh-my-zsh" ]; then
	echo "Oh My Zsh is already installed."
else
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi