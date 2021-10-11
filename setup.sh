#!/bin/bash
set -e

[[ "$(uname -s)" = "Darwin" ]] && current_os="Mac" || current_os="Linux"

PREFIX="@setup >"
# Colors
GREEN=$(tput setaf 2);
YELLOW=$(tput setaf 3);
RESET=$(tput sgr0);

function log() {
  echo "${GREEN}${PREFIX} $1${RESET}"
}

###############################################################################
# COMMON                                                                      #
###############################################################################

echo ""
log "Initializing Setup for a $current_os..."

echo ""
log "Hello $(whoami)! Let's get you set up"

# Repo Folder
echo ""
if [[ ! -d ${HOME}/repos ]]; then
  log "Creating Repository folder"
  mkdir -p "${HOME}/repos"
else 
  log "Repo folder found...skipping"
fi 

# Oh my zsh
echo ""
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  log "Installing oh-my-zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  log "Oh my zsh found...skipping"
fi

# N (node version installer)
echo ""
if [[ ! -d "$HOME/n" ]]; then
  log "Installing N (node version installer)"
  curl -L https://git.io/n-install | bash -s -- -y
  source $HOME/.zshrc

  # Checking Node Version
  log "node --version: $(node --version)"
  log "npm --version: $(npm --version)"
else
  log "N found...skipping"
fi

# NVM
echo ""
if [[ ! -d "$HOME/.nvm" ]]; then
  log "Installing NVM"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh | bash
  source $HOME/.zshrc
else
  log "NVM found...skipping"
fi

package="npm-quick-run"
echo ""
if [[ `npm list -g | grep -c ${package}` -eq 0 ]]; then
  log "Installing NPM global packages"
  npm install --global serve fkill-cli npm-quick-run semantic-release-cli npm-check-updates
else
  log "NPM global packages found...skipping"
fi

# Z Jump Around
echo ""
if [[ ! -f "$HOME/z.sh" ]]; then
  log "Installing Z"
  cd ~
  git clone https://github.com/rupa/z.git
  cp $HOME/z/z.sh $HOME/z.sh
  chmod +x $HOME/z.sh
  rm -rf $HOME/z
  source $HOME/.zshrc
else
  log "Z found...skipping"
fi

echo ""
if [[ ! -d "$HOME/.local/share" ]]; then
  log "Installing Vim-Plug"
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
else
  log "Vim-Plug found...skipping"
fi

# Homebrew
echo ""
if [[ ! -f "`which brew`" ]]; then
  log "Installing Homebrew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else 
  log "Homebrew found...skipping"
fi

echo ""
log "Installing Homebrew dependencies"
brew bundle

# Dotfiles
echo ""
if [[ ! -d "$HOME/repos/cm/dotfiles" ]]; then
  log "Cloning dotfiles"
  git clone https://github.com/cesmunoz/dotfiles.git "${HOME}/repos/cm/dotfiles"
  log "Symlinking files"
  ln -s "${HOME}/repos/cm/dotfiles/.zshrc" "${HOME}/.zshrc"
  ln -s "${HOME}/repos/cm/dotfiles/.gitignore_global" "${HOME}/.gitignore_global"
  ln -s "${HOME}/repos/cm/dotfiles/.gitconfig" "${HOME}/.gitconfig"
  ln -s "${HOME}/repos/cm/dotfiles/.vimrc" "${HOME}/.vimrc"
  ln -s "${HOME}/repos/cm/dotfiles/init.vim" "${HOME}/.config/nvim/init.vim"
  ln -s "${HOME}/repos/cm/dotfiles/coc-settings.json" "${HOME}/.config/nvim/coc-settings.json" 
else
  log "dotfiles folder found...skipping"
fi

###############################################################################
# MAC                                                                         #
###############################################################################
if [[ "$current_os" = "Mac" ]]; then
  echo ""
  log "Mac Customizations"
  
  sh .macos
  
  echo ""
  log "Done Mac Customizations"
fi

###############################################################################
# LINUX (Needs to be covered)                                                 #
###############################################################################
if [[ "$current_os" = "Linux" ]]; then
  echo ""
  log "Linux Customizations -> needs to be covered"
  
  sh .linux.sh
  
  echo ""
  log "Done Linux Customizations"
fi

echo ""
log "FINISHED!"
echo ""

