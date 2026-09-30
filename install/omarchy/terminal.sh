#!/bin/bash
set -e

# Omarchy already includes the core shell/dev tools this repo used to install:
# git, curl, neovim/LazyVim, eza, fd, fzf, zoxide, ripgrep, bat, mise, starship,
# lazygit, lazydocker, docker, docker-compose, and yay.
# Do not install zsh/oh-my-zsh or replace Omarchy's shell defaults.

if command -v gh >/dev/null 2>&1; then
  echo "GitHub CLI already available."
else
  echo "Installing GitHub CLI through mise stub..."
  omarchy-mise-install gh || true
fi

if command -v cloudflared >/dev/null 2>&1; then
  echo "cloudflared already installed."
else
  omarchy-pkg-add cloudflared || yay -S --noconfirm --needed cloudflared
fi

if command -v aws >/dev/null 2>&1; then
  echo "AWS CLI already installed."
else
  yay -S --noconfirm --needed aws-cli-v2
fi

if command -v tailscale >/dev/null 2>&1; then
  echo "Tailscale already installed."
else
  omarchy-install-service-tailscale || omarchy-pkg-add tailscale
fi
