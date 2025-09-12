#!/bin/bash

# Source common functions for consistent styling
source ../common_functions.sh 2>/dev/null || source ./common_functions.sh 2>/dev/null || {
    log_step() { echo -e "\033[1;36m\n🔧 $1\033[0m\n"; }
    log_success() { echo -e "\033[0;32m✅ $1\033[0m"; }
    log_progress() { echo -e "\033[0;35m⏳ $1\033[0m"; }
    log_error() { echo -e "\033[0;31m❌ $1\033[0m"; }
}

log_step "Installing Homebrew package manager..."

# Check if Homebrew is already installed
if command -v brew >/dev/null 2>&1; then
    log_success "Homebrew is already installed"
else
    log_progress "Downloading and installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" < /dev/null
    
    if command -v brew >/dev/null 2>&1; then
        log_success "Homebrew installed successfully"
    else
        log_error "Homebrew installation failed"
        exit 1
    fi
fi

log_step "Installing packages from Brewfile..."
log_progress "Processing Brewfile: ./Brew/Brewfile"

# Install packages using the Brewfile
if brew bundle --file=./Brew/Brewfile; then
    log_success "All packages installed successfully from Brewfile"
else
    log_error "Some packages failed to install - check output above"
    exit 1
fi

log_step "Allowing installed applications to run without security warnings..."
# This removes the quarantine attribute from applications installed via Homebrew Cask
find /Applications -name "*.app" -exec xattr -d com.apple.quarantine {} \; 2>/dev/null || true
log_success "Application security attributes updated"

