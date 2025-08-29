#!/bin/bash

# Git
if gh auth status > /dev/null 2>&1; then
  echo "Authenticated"
  gh auth setup-git
else
  echo "Not authenticated or error"
fi

# Bluetooth
sudo systemctl enable --now bluetooth

# Tailscaled
sudo systemctl enable --now tailscaled

# Pipewire
systemctl --user enable --now pipewire.service
systemctl --user enable --now pipewire-pulse.service
systemctl --user enable --now wireplumber.service