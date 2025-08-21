#!/bin/bash

rm -rf ~/.config/nvim
git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim

rm ~/.config/nvim/init.lua
