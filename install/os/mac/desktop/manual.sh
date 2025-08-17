#!/bin/bash

gum style \
	--foreground 212 --border-foreground 212 --border double \
	--align center --width 50 --margin "0 0" --padding "1 4" \
	'Manual Installation'

gum confirm "Install MongoDb Compass"
gum confirm "Install Autofirma Compass"
