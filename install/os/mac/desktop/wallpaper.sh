#!/bin/bash

WALLPAPER_PATH="$REPO_DIR/images/wallpaper.jpg"

osascript -e "tell application \"System Events\" to set picture of every desktop to \"$WALLPAPER_PATH\""