#!/bin/bash
set -e

echo -e "\n\nWelcome to the dotfiles installer"
echo -e "\nBegin installation"

OS=$(uname -s)

echo -e "\nHello $(whoami)! Let's get you set up"

if [[ "$OS" == "Linux" ]]; then
  ./linux/setup.sh
fi

if [[ "$OS" == "Darwin" ]]; then
  ./mac/setup.sh
fi

echo -e "\n\nSetup complete"
echo -e "\n\n"