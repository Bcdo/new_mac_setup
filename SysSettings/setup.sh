#!/bin/bash

# Source common functions for consistent styling
source ../common_functions.sh 2>/dev/null || source ./common_functions.sh 2>/dev/null || {
    log_step() { echo -e "\033[1;36m\n🔧 $1\033[0m\n"; }
    log_success() { echo -e "\033[0;32m✅ $1\033[0m"; }
    log_progress() { echo -e "\033[0;35m⏳ $1\033[0m"; }
    log_setting() { echo -e "\033[0;36m  📝 Setting: \033[0;33m$1\033[0m"; }
    log_info() { echo -e "\033[0;34mℹ️  $1\033[0m"; }
    log_warning() { echo -e "\033[0;33m⚠️  $1\033[0m"; }
    log_complete() { echo -e "\033[1;32m\n🎉 $1\033[0m\n"; }
}


# Sets Downloads/ as default location for screenshots
log_step "Setting default save folder for screenshots to Downloads/..."
log_setting "com.apple.screencapture location = ~/Downloads"
defaults write com.apple.screencapture location ~/Downloads
log_success "Screenshots will now save to Downloads folder"

# Set dock size (integer from 16 to 128; default is usually 64)
log_step "Adjusting dock size..."
log_setting "com.apple.dock tilesize = 26 pixels"
defaults write com.apple.dock tilesize -int 26
log_success "Dock size set to 26 pixels"

# Set display sleep time to 5 minutes
log_step "Adjusting display sleep time..."
sudo pmset -c displaysleep 5  # Display sleep after 5 minutes on AC power
sudo pmset -b displaysleep 5  # Display sleep after 5 minutes on battery
echo "Note: Password requirement timing is controlled in System Settings > Lock Screen"

# Set Proton Mail as default mail provider
log_step "Setting Proton Mail as the default mail provider..."
open -a "Proton Mail" --args -makeDefault

# Enable secondary click on the right side for Magic Mouse
log_step "Activating right click on the magic mouse..."
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode -string "TwoButton"

# Disable the keyboard shortcut of spotlight, so that when we install Raycast we can set it to that keyboard shortcut.
log_step "Disabling keyboard shortcut for spotlight..."
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 "{enabled = 0;}"
echo "PS: Remember to configure the shortcut inside Raycast settings, or import a backup of settings from a different computer"

# Turn off dock magnification
log_step "Turning off dock magnification..."
defaults write com.apple.dock magnification -bool false

# Turn off "Show suggested and recent apps in Dock"
log_step "Turning off suggested and recent apps in dock..."
defaults write com.apple.dock show-recents -bool false

# Turn off "Automatically hide and show the Dock"
log_step "Turning off dock auto-hide..."
defaults write com.apple.dock autohide -bool false


# Show path bar in Finder
log_step "Enabling path bar in Finder..."
defaults write com.apple.finder ShowPathbar -bool true

# Turn off automatic spelling correction
log_step "Turning off automatic spelling correction..."
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Set faster key repeat rates (for coding efficiency)
log_step "Setting faster key repeat rates..."
defaults write NSGlobalDomain InitialKeyRepeat -int 15  # Delay before key repeat starts
defaults write NSGlobalDomain KeyRepeat -int 2          # Key repeat rate

# Enable full keyboard access for all controls (Tab through everything)
log_step "Enabling full keyboard access..."
defaults write NSGlobalDomain AppleKeyboardUIMode -int 2

# Disable smart quotes and smart dashes (important for coding)
log_step "Disabling smart quotes and dashes..."
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Show Finder status bar (shows item count and free space)
log_step "Enabling Finder status bar..."
defaults write com.apple.finder ShowStatusBar -bool true

# Set Finder to default to list view
log_step "Setting Finder default view to list view..."
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Use scale effect for minimize (faster than genie effect)
log_step "Setting dock minimize effect to scale..."
defaults write com.apple.dock mineffect -string "scale"

# Expand save and print panels by default
log_step "Setting save and print dialogs to expand by default..."
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# Disable screenshot shadows
log_step "Disabling screenshot shadows..."
defaults write com.apple.screencapture disable-shadow -bool true

# Clean up dock and add only essential apps
log_step "Cleaning up dock and adding essential apps..."
# Clear all apps from dock
defaults write com.apple.dock persistent-apps -array

# Function to add an app to dock
add_app_to_dock() {
    local app_path="$1"
    if [[ -d "$app_path" ]]; then
        defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$app_path</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
        echo "Added $app_path to dock"
    else
        echo "Warning: $app_path not found, skipping"
    fi
}

# Add back essential apps
echo "Adding essential apps back to dock..."
add_app_to_dock "/System/Applications/Finder.app"
add_app_to_dock "/System/Applications/App Store.app"
add_app_to_dock "/System/Applications/System Settings.app"
add_app_to_dock "/System/Applications/iPhone Mirroring.app"

echo "Dock cleanup complete. Essential apps retained: Finder, App Store, System Settings, iPhone Mirroring"
echo "After brew installation, manually add: Warp, VS Code, Firefox Developer Edition, etc."

# Set Firefox Developer Edition as default browser
log_step "Setting Firefox Developer Edition as default browser..."
# Launch Firefox briefly to set as default, then quit it
open -a "Firefox Developer Edition" --args --make-default-browser
sleep 4
osascript -e 'quit app "Firefox Developer Edition"'

# Kill some services so they restart and the changes will show
log_step "Restarting system services to apply changes..."
log_progress "Restarting Dock, Finder, and system UI components..."
killall Dock
killall Finder
killall SystemUIServer
killall cfprefsd
log_complete "System Settings Configuration Complete!"
log_success "All macOS preferences have been configured"


