#!/bin/bash

gum style \
    --foreground 212 --border-foreground 212 --border double \
    --align center --width 50 --margin "0 0" --padding "1 4" \
    'Manual Installation'

gum confirm "Install MongoDB Compass"
gum confirm "Install Autofirma"

gum style \
    --foreground 212 --border-foreground 212 --border double \
    --align left --width 50 --margin "0 0" --padding "1 4" \
    'Raycast Configuration' \
    '' \
    '• Set up browser shortcuts' \
    '• Set up DB shortcut' \
    '• Set up Notes shortcut' \
    '• Set up Reminders shortcut' \
    '• Set up Safari shortcut' \
    '• Set up Slack shortcut' \
    '• Set up Spotify shortcut' \
    '• Set up VSCode shortcut' \
    '• Set up Terminal shortcut' \
    '• Enable Switch Tabs (Alt+Tab)' \
    '• Configure Window Management'

gum confirm "Did you finish Raycast configuration?"