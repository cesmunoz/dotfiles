#!/bin/bash
set -e

# GitHub CLI git integration, only if already authenticated.
if command -v gh >/dev/null 2>&1 && gh auth status >/dev/null 2>&1; then
  gh auth setup-git
fi

# Tailscale is user-requested; enable it when installed.
if command -v tailscale >/dev/null 2>&1; then
  sudo systemctl enable --now tailscaled
fi

# Keep Omarchy-owned services (Hyprland, bar, PipeWire, Bluetooth, etc.) untouched.
