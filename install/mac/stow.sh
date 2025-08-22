# Common stow
source $REPO_INSTALL_DIR/stow.sh

stow --adopt --target=$HOME --dir="$REPO_DIR/dotfiles" zsh
stow --adopt --target=$HOME --dir="$REPO_DIR/dotfiles" git
stow --adopt --target=$HOME --dir="$REPO_DIR/dotfiles" ghostty
stow --adopt --target=$HOME --dir="$REPO_DIR/dotfiles" starship
stow --adopt --target=$HOME --dir="$REPO_DIR/dotfiles" nvim
