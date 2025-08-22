#!/bin/bash

rm -f ~/.zshrc
rm -f ~/.config/hypr/hyprland.conf

stow --adopt --target=$HOME --dir=$DOTFILES_DIR zsh
stow --adopt --target=$HOME --dir=$DOTFILES_DIR git
stow --adopt --target=$HOME --dir=$DOTFILES_DIR ghostty
stow --adopt --target=$HOME --dir=$DOTFILES_DIR starship
stow --adopt --target=$HOME --dir=$DOTFILES_DIR nvim
stow --adopt --target=$HOME --dir=$DOTFILES_DIR hypr