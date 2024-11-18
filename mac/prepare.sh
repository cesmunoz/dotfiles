#!/bin/bash
set -e

echo -e "\nInstalling dependencies"

if [[ ! -f "`which brew`" ]]; then
  echo -e "\nInstalling Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo >> /Users/$(whoami)/.zprofile
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/$(whoami)/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [[ ! -f "`which gum`" ]]; then
  echo -e "\nInstalling Gum"
  brew install gum
fi