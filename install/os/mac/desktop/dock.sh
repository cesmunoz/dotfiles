#!/bin/bash

defaults write com.apple.dock persistent-apps -array

defaults write com.apple.dock autohide -bool true

killall Dock