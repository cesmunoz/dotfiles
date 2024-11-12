#!/bin/bash
set -e

CM_PREFIX="@setup >"
# Colors
GREEN=$(tput setaf 2);
YELLOW=$(tput setaf 3);
RESET=$(tput sgr0);

FOLDER_REPO="$HOME/repos/personal"

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
brew bundle --file=$FOLDER_REPO/dotfiles/Brewfile

# SymLinkFiles
dotfiles=(".gitconfig" ".gitignore_global" ".vimrc" ".zshrc")

echo ""
log "Symlinking default dotfiles with backups"
for file in "${dotfiles[@]}"; do
  if [ -h "$HOME/$file" ]; then
    echo "Skipping \"$HOME/$file\" since it is already a symlink..."
  else
    if [ -f "$HOME/$file" ]; then
      mv -v "$HOME/$file" "$HOME/$file.bak"
    fi

    ln -s "$HOME/repos/personal/dotfiles/$file" "$HOME/$file"
  fi
done

echo ""
log "Done Mac Customizations"