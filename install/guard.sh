#!/bin/bash

# ------------------------------------------------------------------------------
# Guard
# - Detecting OS
# ------------------------------------------------------------------------------

if [[ "$OS" == "Darwin" ]]; then
  OS="mac"
elif [[ "$OS" == "Linux" ]]; then
  if command -v omarchy >/dev/null 2>&1 || [[ -d /usr/share/omarchy ]]; then
    OS="omarchy"
  else
    echo "Unsupported Linux install: this dotfiles profile now targets Omarchy only." >&2
    exit 1
  fi
else
  echo "Unsupported operating system: $OS" >&2
  exit 1
fi

echo -e "Guard clauses passed"
