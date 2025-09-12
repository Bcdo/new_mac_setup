#!/bin/bash

log_step() {
  echo ""
  echo "🔧 $1"
  echo ""
}

log_step "Setting up .zshrc configuration..."

# Backup existing .zshrc if it exists
if [ -f "$HOME/.zshrc" ]; then
    log_step "Backing up existing .zshrc to .zshrc.backup..."
    cp "$HOME/.zshrc" "$HOME/.zshrc.backup"
    echo "✅ Existing .zshrc backed up"
fi

# Copy the new .zshrc template
log_step "Installing new .zshrc configuration..."
cp "./SysSettings/zshrc_template" "$HOME/.zshrc"

# Make sure it's readable
chmod 644 "$HOME/.zshrc"

log_step "Installing universal package manager (ni)..."
# Check if npm is available and install ni
if command -v npm >/dev/null 2>&1; then
    npm install -g @antfu/ni
    echo "✅ @antfu/ni installed globally"
else
    echo "⚠️  npm not found - you can install ni later with: npm i -g @antfu/ni"
fi

log_step "✅ .zshrc configuration installed successfully!"
echo "   - Useful aliases and functions added"
echo "   - Development shortcuts configured"  
echo "   - Enhanced history and completion settings"
echo "   - Git integration with prompt"
echo "   - Universal package manager (ni) installed"
echo ""
echo "💡 You can customize further by editing ~/.zshrc.local"
echo "   This file will be automatically sourced and won't be overwritten"
