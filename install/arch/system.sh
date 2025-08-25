#!/bin/bash

# Bluetooth
sudo systemctl enable --now bluetooth

# Tailscaled
sudo systemctl enable --now tailscaled

# Pipewire
systemctl --user enable --now pipewire.service
systemctl --user enable --now pipewire-pulse.service
systemctl --user enable --now wireplumber.service