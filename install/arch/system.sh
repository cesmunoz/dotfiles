#!/bin/bash

# Bluetooth
sudo systemctl enable --now bluetooth

# Tailscaled
sudo systemctl enable --now tailscaled

# Hyprpaper
sudo systemctl enable --now hyprpaper.service
