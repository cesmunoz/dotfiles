#!/bin/bash

if [[ ! -d "$HOME/.config/zsh" ]]; then
    echo "Zsh is already with stow"
else 
    rm ~/.zshrc
fi

stow -v -t $HOME -d $DOTFILES_DIR zsh
stow -v -t $HOME -d $DOTFILES_DIR git
stow -v -t $HOME -d $DOTFILES_DIR ghostty
stow -v -t $HOME -d $DOTFILES_DIR starship
stow -v -t $HOME -d $DOTFILES_DIR nvim
stow -v -t $HOME -d $DOTFILES_DIR mise
