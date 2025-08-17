#!/bin/bash

# Remap Caps Lock (bloq mayus) to Escape on macOS
hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x700000029}]}'