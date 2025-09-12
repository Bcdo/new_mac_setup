#!/bin/bash

# Test mode - shows what would be changed without making actual changes
DRY_RUN=true

log_step() {
  echo ""
  echo "🔧 [TEST MODE] $1"
  echo ""
}

# Mock defaults command for testing
mock_defaults() {
    local action="$1"
    local domain="$2"
    local key="$3"
    local value="$4"
    
    if [[ "$action" == "write" ]]; then
        echo "  📝 Would set: $domain $key = $value"
        # Show current value if it exists
        current=$(defaults read "$domain" "$key" 2>/dev/null || echo "(not set)")
        echo "  📖 Current value: $current"
    elif [[ "$action" == "read" ]]; then
        defaults read "$domain" "$key" 2>/dev/null || echo "(not set)"
    fi
}

# Mock other commands
mock_open() {
    echo "  🚀 Would run: open $@"
}

mock_pmset() {
    echo "  ⚡ Would run: sudo pmset $@"
}

mock_killall() {
    echo "  🔄 Would restart: $1"
}

mock_osascript() {
    echo "  🍎 Would run AppleScript: $@"
}

# Replace actual commands with mock versions in test mode
if [[ "$DRY_RUN" == "true" ]]; then
    defaults() { mock_defaults "$@"; }
    open() { mock_open "$@"; }
    pmset() { mock_pmset "$@"; }
    killall() { mock_killall "$@"; }
    osascript() { mock_osascript "$@"; }
    sleep() { echo "  ⏱️  Would sleep for $1 seconds"; }
fi

echo "🧪 RUNNING SYSTEM SETTINGS SCRIPT IN TEST MODE"
echo "   This will show what would be changed without making actual changes"
echo ""

# Sets Downloads/ as default location for screenshots
log_step "Setting default save folder for screenshots to Downloads/..."
defaults write com.apple.screencapture location ~/Downloads

# Set dock size (integer from 16 to 128; default is usually 64)
log_step "Adjusting dock size..."
defaults write com.apple.dock tilesize -int 26

# Set display sleep time to 5 minutes
log_step "Adjusting display sleep time..."
pmset -c displaysleep 5  # Display sleep after 5 minutes on AC power
pmset -b displaysleep 5  # Display sleep after 5 minutes on battery
echo "Note: Password requirement timing is controlled in System Settings > Lock Screen"

# Set Proton Mail as default mail provider
log_step "Setting Proton Mail as the default mail provider..."
# Launch Firefox briefly to set as default, then quit it
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

# Set Firefox Developer Edition as default browser
log_step "Setting Firefox Developer Edition as default browser..."
# Launch Firefox briefly to set as default, then quit it
open -a "Firefox Developer Edition" --args --make-default-browser
sleep 2
osascript -e 'quit app "Firefox Developer Edition"'

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

# Dock app management note
log_step "Note: Consider manually organizing your dock apps..."
echo "Recommended dock apps to keep: Finder, App Store, System Settings, iPhone Mirroring"
echo "After brew installation, consider adding: Warp, VS Code, Firefox Developer Edition, etc."
echo "Remove unused default apps from dock manually through System Settings > Desktop & Dock"

# Kill some services so they restart and the changes will show
log_step "Restarting services..."
killall Dock
killall Finder
killall SystemUIServer
killall cfprefsd

log_step "Test run complete - no actual changes were made!"
echo ""
echo "✅ This was a dry run. To apply these changes for real, run the actual setup.sh script."
