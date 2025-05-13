#!/bin/bash

# Install Homebrew
echo "Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" < /dev/null

# Enable the brew command
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install packages using the Brewfile
brew bundle --file=./brew/Brewfile

done
