#!/bin/bash

stow --adopt --target=$HOME --dir="$REPO_DIR/dotfiles" zsh
stow --adopt --target=$HOME --dir="$REPO_DIR/dotfiles" git

# need to stow the specific from the os