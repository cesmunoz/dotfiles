#!/bin/bash

if ! command -v starship &> /dev/null; then
  curl -sS https://starship.rs/install.sh | sh
else
  echo "Starship is already installed"
fi