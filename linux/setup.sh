#!/bin/bash
set -e

echo -e "\n\nWelcome to the Linux os installer"

./linux/prepare.sh
./linux/terminal.sh
./linux/desktop.sh

echo -e "\n\nInstallation complete!"

echo -e "Signup on:" \
  "\n- GitHub cli" \
  "\n- AWS cli" \
  "\n- Slack" \
  "\n- Spotify" \
  "\n- MongoDB Compass" \
  "\n- Visual Studio Code" \
  "\n- Google Chrome" \