#!/bin/bash
set -e

# ------------------------------------------------------------------------------
# Omarchy requirements
# Omarchy already ships with pacman, yay, gum, git, and the Omarchy CLI.
# Keep this script as a guard only; do not bootstrap Arch from scratch here.
# ------------------------------------------------------------------------------

require_command() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Missing required command: $1" >&2
    exit 1
  fi
}

require_command pacman
require_command omarchy
require_command git
require_command yay
