#!/bin/bash

copy_and_replace() {
  local name="$1"
  local src="$HOME/dev/cm/dotfiles/config/$name"
  local dest="$HOME/.config/$name"

  mkdir -p "$dest"

  cp -R "$src/"* "$dest"
}

gum log --level info "Setup Configurations"

mkdir -p ~/.config
copy_and_replace ghostty
copy_and_replace hypr
copy_and_replace mise
copy_and_replace waybar
copy_and_replace wlogout
copy_and_replace nvim
copy_and_replace zsh

cp -R ~/dev/cm/dotfiles/config/starship.toml ~/.config/starship.toml
cp -R ~/dev/cm/dotfiles/config/.gitconfig ~/.gitconfig
cp -R ~/dev/cm/dotfiles/config/.gitignore ~/.gitignore
cp -R ~/dev/cm/dotfiles/config/.zshrc ~/.zshrc