#!/bin/bash

# Check if Oh My Zsh is installed
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