#!/bin/bash
set -e

[ "$(uname -s)" = "Linux" ] && current_os="Linux" || current_os="MINGW64"

echo "Initializing dotfiles for a $current_os setup..."
echo "";

if [ $current_os="Linux" ]; then
    echo "Update..."
    apt-get update
fi

if [ ! -d "$HOME/dotfiles" ]; then
    echo "Cloning dotfiles to $HOME/dotfiles"
    #git clone https://https://github.com/cesmunoz/dotfiles.git $HOME/dotfiles
else
    echo "$HOME/dotfiles found - Skipping clone repository"
fi

echo "";
echo "Checking ZSH..."
if [ ! -f "$HOME/.zshrc" && $current_os="Linux" ]; then
    apt-get install zsh -y
fi

#cd "$HOME/dotfiles"

dotfiles=(".zshrc" ".bashrc" ".vimrc")
if [ $current_os == "MINGW64" ]; then
    dotfiles=( ".bashrc-git" ".vimrc" )
fi

echo "";
echo "Symlink default dotfiles with backups..."
for file in ${dotfiles[@]} do
    if [ -h $HOME/$file ]; then
        echo "Skipping $HOME/$file since it is already a symlink..." 
    else
        if [ -f "$HOME/$file" ]; then
            mv -v "$HOME/$file" "$HOME/$file.bak"
        fi

        if [ $file == ".bashrc-git" ]; then
            ln -s "$HOME/dotfiles/$file" "$HOME/.bashrc"
        else 
            ln -s "$HOME/dotfiles/$file" "$HOME/$file"
        fi        
    fi  
done

echo "";
echo "Checking oh-my-zsh..."
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  echo "Installing oh-my-zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended  
fi

echo ""
if [[ ! -d "$HOME/.nvm" ]]; then 
  echo "Installing nvm..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh | bash

  source "$HOME/.zshrc"
else
  echo "nvm installation found. Skipping..."
fi