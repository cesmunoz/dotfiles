#!/bin/bash
set -e

[ "$(uname -s)" = "Linux" ] && current_os="Linux" || [ "$(uname -s)" = "MINGW64" ] && current_os="MINGW64" || [ "$(uname -s)" = "Darwin" ] && current_os="Darwin"

echo "Initializing dotfiles for a $current_os setup..."
echo "";

echo ""
echo "Adding $current_os specific functionality..."
if [ "$current_os" = "Darwin" ]; then
    echo "";
    echo "Install homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

    echo "";
    echo "Checking Z..."
    if [ ! -d "$HOME/z" ]; then 
        echo "Installing Z..."
        cd
        git clone https://github.com/rupa/z.git
        cp $HOME/z/z.sh $HOME/z.sh
        chmod +x $HOME/z.sh
        
        rm -rf $HOME/z
    else
        echo "Z found... skipping installation"
    fi

    echo "";
    echo "Checking ZSH..."
    if [ ! -f "$HOME/.zshrc"  ]; then
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
fi


if [ "$current_os" = "Linux" ]; then
    echo "";
    echo "Update Libraries y Git Version..."
    sudo add-apt-repository -y ppa:git-core/ppa
    sudo apt-get update
    sudo apt-get install git -y
    sudo apt-get install awscli -y

    echo "";
    echo "Checking Z..."
    if [ ! -d "$HOME/z" ]; then 
        echo "Installing Z..."
        cd
        git clone https://github.com/rupa/z.git
        cp $HOME/z/z.sh $HOME/z.sh
        chmod +x $HOME/z.sh
        
        rm -rf $HOME/z

        source $HOME/.bashrc
    else
        echo "Z found... skipping installation"
    fi

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
    echo "Modification on mount C drive..."    
    sudo umount /mnt/c
    sudo mount -t drvfs C: /mnt/c -o metadata  
fi

echo ""
echo "Adding dotfiles..."
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
echo "Initial setup complete!"
echo "run vim +PackUpdate"
echo "restart console"
