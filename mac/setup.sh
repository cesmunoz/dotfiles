#!/bin/bash
set -e

./mac/prepare.sh
./mac/terminal.sh
./mac/desktop.sh
./mac/default.sh

stow nvim -t $HOME
stow git -t $HOME