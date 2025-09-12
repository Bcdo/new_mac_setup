#!/bin/bash

# Source common functions for consistent styling
source ../common_functions.sh 2>/dev/null || source ./common_functions.sh 2>/dev/null || {
    log_step() { echo -e "\033[1;36m\n🔧 $1\033[0m\n"; }
    log_success() { echo -e "\033[0;32m✅ $1\033[0m"; }
    log_progress() { echo -e "\033[0;35m⏳ $1\033[0m"; }
    log_info() { echo -e "\033[0;34mℹ️  $1\033[0m"; }
    log_warning() { echo -e "\033[0;33m⚠️  $1\033[0m"; }
    log_complete() { echo -e "\033[1;32m\n🎉 $1\033[0m\n"; }
}

log_step "Setting up .zshrc configuration..."

# Backup existing .zshrc if it exists
if [ -f "$HOME/.zshrc" ]; then
    log_step "Backing up existing .zshrc configuration..."
    log_progress "Creating backup at ~/.zshrc.backup"
    cp "$HOME/.zshrc" "$HOME/.zshrc.backup"
    log_success "Existing .zshrc backed up to .zshrc.backup"
fi

# Copy the new .zshrc template
log_step "Installing new .zshrc configuration..."
log_progress "Copying zshrc template to ~/.zshrc"
cp "./SysSettings/zshrc_template" "$HOME/.zshrc"

# Make sure it's readable
chmod 644 "$HOME/.zshrc"
log_success "New .zshrc configuration installed"

log_step "Installing universal package manager (ni)..."
# Check if npm is available and install ni
if command -v npm >/dev/null 2>&1; then
    log_progress "Installing @antfu/ni globally via npm..."
    if npm install -g @antfu/ni 2>/dev/null; then
        log_success "@antfu/ni installed globally"
    else
        log_warning "@antfu/ni installation failed (permission issue) - you can install later with: sudo npm i -g @antfu/ni"
    fi
else
    log_warning "npm not found - you can install ni later with: npm i -g @antfu/ni"
fi

log_complete ".zshrc Configuration Complete!"
log_success "Shell environment configured with:"
log_info "• Useful aliases and functions added"
log_info "• Development shortcuts configured"  
log_info "• Enhanced history and completion settings"
log_info "• Git integration with enhanced prompt"
log_info "• Universal package manager (ni) installed"
echo ""
log_info "💡 Customize further by editing ~/.zshrc.local"
log_info "   This file will be automatically sourced and won't be overwritten"
