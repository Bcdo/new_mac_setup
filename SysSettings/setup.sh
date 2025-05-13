#!/bin/bash

# Sets Downloads/ as default location for screenshots
defaults write com.apple.screencapture location ~/Downloads

# Set dock size (integer from 16 to 128; default is usually 64)
defaults write com.apple.dock tilesize -int 26

# Set screensaver time to 5 minutes, and password req after 4 hours
defaults write com.apple.screensaver idleTime -int 300
defaults write com.apple.screensaver askForPasswordDelay -int 14400

# Set protonmail as default mail provider
open -a "Protonmail" --args -makeDefault

# Enable secondary click on the right side for Magic Mouse
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode -string "TwoButton"

# Disable the keyboard shortcut of spotlight, so that when we install Raycast we can set it that keyboard shortcut.
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 "{enabled = 0;}"

# Kill som services so they restart and the changes will show
killall Dock
killall SystemUIServer
killall cfprefsd
