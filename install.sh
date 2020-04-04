#!/bin/bash
set -e

[ "$(uname -s)" = "Linux" ] && current_os="Linux" || current_os="MINGW64"

echo "Initializing dotfiles for a $current_os setup..."
echo "";


if [ ! -d "$HOME/dotfiles" ]; then
    echo "Cloning dotfiles to $HOME/dotfiles"
    git clone https://github.com/cesmunoz/dotfiles.git $HOME/dotfiles
else
    echo "$HOME/dotfiles found - Skipping clone repository"
fi

cd "$HOME/dotfiles"

dotfiles=(".zshrc" ".bashrc" ".vimrc" ".gitconfig")
if [ $current_os == "MINGW64" ]; then
    dotfiles=( ".bashrc-git" ".vimrc" ".gitconfig" )
fi

echo "";
echo "Symlink default dotfiles with backups..."
for file in ${dotfiles[@]}; do
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

echo ""
echo "Adding $current_os specific functionality..."
if [ $current_os="Linux" ]; then
    echo "Update Libraries..."
    sudo apt-get update

    echo "";
    echo "Checking ZSH..."
    if [ $current_os="Linux" ]; then
        echo "Install ZSH..."
        sudo apt-get install zsh -y

        echo "Setting Up ZSH as default shell"
        chsh -s $(which zsh)
    fi
    
    echo "";
    echo "Checking oh-my-zsh..."
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo "Installing oh-my-zsh"
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended  
    fi

    echo "";
    echo "Checking NVM..."
    if [ ! -d "$HOME/.nvm" ]; then 
        echo "Installing nvm..."
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh | bash
  
        source $HOME/.nvm/nvm.sh
    else
        echo "nvm installation found. Skipping..."
    fi

    echo "";
    echo "Checking Node..."
    if [ ! -x "$(command -v node)" ]; then
        source $HOME/.nvm/nvm.sh
        
        echo "Installing node..."
        
        nvm install stable
        nvm alias default stable
        nvm use default

        source $HOME/.bashrc
    else
        echo "node found... skipping installation"
    fi

    echo "";
    echo "Checking Z..."
    if [ ! -d "$HOME/z" ]; then 
        echo "Installing Z..."
        cd
        git clone https://github.com/rupa/z.git
        chmod +x ~/z/z.sh

        source $HOME/.bashrc
    else
        echo "Z found... skipping installation"
    fi
    
fi

echo ""
echo "Initial setup complete!"
echo "run vim +PackUpdate"
echo "restart console"