#!/bin/bash

# Get the repository params
export REPO_OWNER=$1
export REPO_NAME=$2

# Source common functions for consistent styling
source ./common_functions.sh 2>/dev/null || {
    # If running remotely, define basic functions inline
    log_header() { echo -e "\033[1;34m\n🚀 $1\033[0m\n"; }
    log_step() { echo -e "\033[1;36m\n🔧 $1\033[0m\n"; }
    log_success() { echo -e "\033[0;32m✅ $1\033[0m"; }
    log_error() { echo -e "\033[0;31m❌ $1\033[0m"; }
    log_complete() { echo -e "\033[1;32m\n🎉 $1\033[0m\n"; }
    log_progress() { echo -e "\033[0;35m⏳ $1\033[0m"; }
}

log_header "macOS System Setup Starting"
log_step "Initializing setup environment..."

# Check for sudo access with proper TTY handling for piped execution
log_progress "Checking administrator privileges..."
if sudo -n true 2>/dev/null; then
    log_success "Administrator privileges already available"
else
    log_info "This installation requires administrator privileges"
    log_info "You will be prompted for your password"
    
    # Use /dev/tty to handle password input even when script is piped
    if sudo -p "[sudo] Please enter your password to continue macOS setup: " true < /dev/tty; then
        log_success "Administrator privileges obtained"
    else
        log_error "Administrator privileges are required for this installation"
        log_error "Please ensure you have admin access and try again"
        exit 1
    fi
fi

# Setup a temporary folder to download the repository, exit script if filesystem is not writable
log_step "Setting up temporary workspace..."
mkdir -p "$HOME/SystemSetupTmp"
cd "$HOME/SystemSetupTmp" || exit
log_success "Temporary workspace created at $HOME/SystemSetupTmp"

# Download and unzip repository, exit script if download failed
log_step "Downloading repository..."
log_progress "Fetching https://github.com/$REPO_OWNER/$REPO_NAME/archive/refs/heads/main.zip"
curl -L -o main.zip https://github.com/$REPO_OWNER/$REPO_NAME/archive/refs/heads/main.zip
log_success "Repository downloaded"

log_progress "Extracting archive..."
unzip -o main.zip
cd $REPO_NAME-main || exit
log_success "Repository extracted and ready"

# Source common functions in the extracted repository
source ./common_functions.sh

log_step "Installing Homebrew and packages..."
sh Brew/install.sh

log_step "Configuring system settings..."
sh SysSettings/setup.sh

log_step "Setting up shell configuration..."
sh SysSettings/setup_zshrc.sh

log_step "Cleaning up temporary files..."
# Finally, remove the temporary directory and its contents recursively    
rm -rf "$HOME/SystemSetupTmp"    
log_success "Temporary files removed successfully"

log_complete "New macOS System Setup Complete!"
log_success "Your new Mac is ready for development"


unset REPO_OWNER
unset REPO_NAME
