#!/bin/bash
log_step() {
  echo ""
  echo "🔧 $1"
  echo ""
}

# Close System Preferences to avoid it overwriting changes
osascript -e 'tell application "System Settings" to quit' 2>/dev/null
osascript -e 'tell application "System Preferences" to quit' 2>/dev/null

# Sets Downloads/ as default location for screenshots
log_step "Setting default save folder for screenshots to Downloads/..."
defaults write com.apple.screencapture location ~/Downloads

# Set dock size (integer from 16 to 128; default is usually 64)
log_step "Adjusting dock size..."
defaults write com.apple.dock tilesize -int 26

# Set screensaver time to 5 minutes, and password req after 4 hours
log_step "Adjusting time to screensaver and password lock..."
defaults write com.apple.screensaver idleTime -int 300
defaults write com.apple.screensaver askForPasswordDelay -int 14400

# Set protonmail as default mail provider
log_step "Opening Proton Mail to set it as default..."
open -a "Proton Mail"

# Enable secondary click on the right side for Magic Mouse
log_step "Activating right click on the magic mouse..."
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode -string "TwoButton"

# Disable the keyboard shortcut of spotlight, so that when we install Raycast we can set it that keyboard shortcut.
log_step "Disabling keyboardshortcut for spotlight..."
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 "{enabled = 0;}"
echo "PS: Remember to configure the shortcut inside Raycast settings, or import a backup of settings from a different computer"

sleep 3
# Kill som services so they restart and the changes will show
log_step "Restarting services..."
killall Dock
killall -9 SystemUIServer
killall cfprefsd

log_step "Setup complete"
