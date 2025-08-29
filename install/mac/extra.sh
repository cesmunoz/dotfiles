#!/bin/bash

gum log --level info "Setup Extra"


# Title
gum style \
    --foreground 45 --border-foreground 51 --border double \
    --align center --width 50 --margin "0 0" --padding "1 4" \
    'Manual Installation'

# Git
gum style \
    --foreground 39 --border-foreground 75 --border double \
    --align left --width 50 --margin "0 0" --padding "1 4" \
    'Git Configuration' \
    '' \
    '• Login into an account' \
    '• Execute Git command: gh auth login' \
    '• Execute Git command: gh auth setup-git' \

gum confirm "Did you finish Git configuration?"

# Raycast
gum style \
    --foreground 39 --border-foreground 75 --border double \
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

# MongoDb
gum style \
    --foreground 208 --border-foreground 202 --border double \
    --align left --width 50 --margin "0 0" --padding "1 4" \
    'MongoDB Configuration' \
    '' \
    '• Install application' \
    '• Set up connections'

gum confirm "Did you finish MongoDB configuration?"

# Autofirma
gum style \
    --foreground 129 --border-foreground 135 --border double \
    --align left --width 50 --margin "0 0" --padding "1 4" \
    'Autofirma Configuration' \
    '' \
    '• Install app' \
    '• Install credentials'

gum confirm "Did you finish Autofirma configuration?"

# Logi Options
gum style \
    --foreground 220 --border-foreground 226 --border double \
    --align left --width 50 --margin "0 0" --padding "1 4" \
    'Logi Options +' \
    '' \
    '• Set up mouse'

gum confirm "Did you finish Logi Options configuration?"

# Aws cli
gum style \
    --foreground 33 --border-foreground 27 --border double \
    --align left --width 50 --margin "0 0" --padding "1 4" \
    'Aws cli' \
    '' \
    '• Set up environments'

gum confirm "Did you finish Aws cli configuration?"

# Amphetamine
gum style \
    --foreground 214 --border-foreground 208 --border double \
    --align left --width 50 --margin "0 0" --padding "1 4" \
    'Amphetamine' \
    '' \
    '• Set up wake up app'

gum confirm "Did you finish Amphetamine configuration?"

# Mac
gum style \
    --foreground 39 --border-foreground 75 --border double \
    --align left --width 50 --margin "0 0" --padding "1 4" \
    'Mac Configuration' \
    '' \
    '• Show percentage on battery' \

gum confirm "Did you finish Raycast configuration?"
