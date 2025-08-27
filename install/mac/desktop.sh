#!/bin/bash

gum log --level info "Setup Desktop"

brew bundle --file=~/dev/cm/dotfiles/install/mac/Brewfile --verbose
