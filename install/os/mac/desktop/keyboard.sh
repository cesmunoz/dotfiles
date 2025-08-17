#!/bin/bash

# Remap Caps Lock (bloq mayus) to Escape on macOS
hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x700000029}]}'

# i want to have F1-F12 keys without pressing Fn key
defaults write -g com.apple.keyboard.fnState -bool true