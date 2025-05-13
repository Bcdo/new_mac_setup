#!/bin/bash

# Sets Downloads/ as default location for screenshots
defaults write com.apple.screencapture location ~/Downloads

# Set dock size (integer from 16 to 128; default is usually 64)
defaults write com.apple.dock tilesize -int 26

# Set screensaver time to 5 minutes, and password req after 4 hours
defaults -currentHost write com.apple.screensaver idleTime -int 300
defaults write com.apple.screensaver askForPasswordDelay -int 14400

