#!/bin/bash
set -e

[[ "$(uname -s)" = "Darwin" ]] && current_os="Mac" || current_os="Linux"

CM_PREFIX="@setup >"
# Colors
GREEN=$(tput setaf 2);
YELLOW=$(tput setaf 3);
RESET=$(tput sgr0);

function log() {
  echo "${GREEN}${CM_PREFIX} $1${RESET}"
}

###############################################################################
# COMMON                                                                      #
###############################################################################

echo ""
log "Initializing Setup for a $current_os..."

echo ""
log "Hello $(whoami)! Let's get you set up"

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
brew bundle --file=$HOME/repos/cm/dotfiles/Brewfile

# Z Jump Around
echo ""
if [[ ! -f "$HOME/z.sh" ]]; then
  log "Installing Z"
  cd ~
  git clone https://github.com/rupa/z.git
  cp $HOME/z/z.sh $HOME/z.sh
  chmod +x $HOME/z.sh
  rm -rf $HOME/z
else
  log "Z found...skipping"
fi

# N (node version installer)
echo ""
if [[ ! -d "$HOME/n" ]]; then
  log "Installing N (node version installer)"
  curl -L https://git.io/n-install | bash -s -- -y

  # Checking Node Version
  echo "node --version: $(node --version)"
  echo "npm --version: $(npm --version)"
else
  log "N found...skipping"
fi

# NVM
echo ""
if [[ ! -d "$HOME/.nvm" ]]; then
  log "Installing NVM"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh | bash
else
  log "NVM found...skipping"
fi

if [ ! -x "$(command -v node)" ]; then
  source "$HOME/.zshrc"

  log "Installing node nvm..."
  nvm install stable
  nvm alias default stable
  nvm use default

  log "Installing node n..."
  n latest

  source "$HOME/.zshrc"
else
  echo "node found... skipping installation"
fi

package="npm-quick-run"
echo ""
if [[ `npm list -g | grep -c ${package}` -eq 0 ]]; then
  log "Installing NPM global packages"
  npm install --global serve fkill-cli npm-quick-run semantic-release-cli npm-check-updates
else
  log "NPM global packages found...skipping"
fi

echo ""
if [[ ! -d "$HOME/.local/share" ]]; then
  log "Installing Vim-Plug"
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
else
  log "Vim-Plug found...skipping"
fi

# SymLinkFiles
dotfiles=( ".zshrc" ".gitconfig" ".gitignore_global" ".vimrc")

echo ""
log "Symlinking default dotfiles with backups"
for file in "${dotfiles[@]}"; do
  if [ -h "$HOME/$file" ]; then
    echo "Skipping \"$HOME/$file\" since it is already a symlink..."
  else
    if [ -f "$HOME/$file" ]; then
      mv -v "$HOME/$file" "$HOME/$file.bak"
    fi

    ln -s "$HOME/repos/cm/dotfiles/$file" "$HOME/$file"
  fi
done

dotfileVim=( "init.vim" )
echo ""
log "Symlinking default dotfiles with backups"
for file in "${dotfiles[@]}"; do
  if [ -h "$HOME/$file" ]; then
    echo "Skipping \"$HOME/$file\" since it is already a symlink..."
  else
    if [ -f "$HOME/$file" ]; then
      mv -v "$HOME/$file" "$HOME/$file.bak"
    fi

    ln -s "$HOME/repos/cm/dotfiles/$file" "$HOME/$file"
  fi
done

###############################################################################
# MAC                                                                         #
###############################################################################
if [[ "$current_os" = "Mac" ]]; then
  echo ""
  log "Mac Customizations"
  
  sh "${HOME}/repos/cm/dotfiles/.macos"
  
  echo ""
  log "Done Mac Customizations"
fi