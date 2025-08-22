#!/bin/bash

rm ~/.zshrc

stow --adopt --target=$HOME --dir="$REPO_DIR/dotfiles" zsh
stow --adopt --target=$HOME --dir="$REPO_DIR/dotfiles" git
stow --adopt --target=$HOME --dir="$REPO_DIR/dotfiles" ghostty
stow --adopt --target=$HOME --dir="$REPO_DIR/dotfiles" starship
stow --adopt --target=$HOME --dir="$REPO_DIR/dotfiles" nvim

# need to stow the specific from the os
