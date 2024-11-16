#!/bin/bash
set -e

echo -e "\nInstalling dependencies"

if [[ ! -f "`which brew`" ]]; then
  echo -e "\nInstalling Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [[ ! -f "`which gum`" ]]; then
  echo -e "\nInstalling Gum"
  brew install gum
fi