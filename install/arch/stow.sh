#!/bin/bash

cp $DOTFILES_DIR/zsh/.zshrc $HOME/.zshrc
cp $DOTFILES_DIR/hypr/.config $HOME/.config/hypr/hyprland.conf

stow --adopt -v -t $HOME -d $DOTFILES_DIR zsh

stow --adopt --target=$HOME --dir=$DOTFILES_DIR git
stow --adopt --target=$HOME --dir=$DOTFILES_DIR ghostty
stow --adopt --target=$HOME --dir=$DOTFILES_DIR starship
stow --adopt --target=$HOME --dir=$DOTFILES_DIR nvim

stow --adopt -R -v -t $HOME -d $DOTFILES_DIR hypr
