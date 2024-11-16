#!/bin/bash
set -e

./mac/prepare.sh
./mac/terminal.sh
./mac/desktop.sh
./mac/default.sh

stow nvim