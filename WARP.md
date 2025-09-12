# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Repository Overview

This is an automated macOS setup repository that installs and configures a new Mac environment through Homebrew packages and system settings. It's designed to be run remotely via a single curl command that downloads, executes, and cleans up the setup scripts.

## Key Architecture

The setup process follows a four-stage architecture:

1. **Main Installer** (`install.sh`) - Downloads repo, coordinates execution, handles cleanup
2. **Package Installation** (`Brew/install.sh` + `Brewfile`) - Installs Homebrew and all defined packages
3. **System Configuration** (`SysSettings/setup.sh`) - Applies macOS system preferences and settings
4. **Shell Configuration** (`SysSettings/setup_zshrc.sh`) - Sets up .zshrc with aliases, functions, and development shortcuts


## Common Development Commands

### Testing the Full Setup Process
```bash
# Test the complete remote installation process
REPO_OWNER="mrb" REPO_NAME="new_mac_setup" curl -sSL https://raw.githubusercontent.com/"$REPO_OWNER"/"$REPO_NAME"/main/install.sh | sh -s "$REPO_OWNER" "$REPO_NAME"
```

### Local Development and Testing
```bash
# Test homebrew installation locally
sh Brew/install.sh

# Test system settings configuration locally  
sh SysSettings/setup.sh

# Test .zshrc setup locally
sh SysSettings/setup_zshrc.sh

# Validate Brewfile syntax
brew bundle check --file=./Brew/Brewfile

# Preview what would be installed without installing
brew bundle list --file=./Brew/Brewfile
```

### Modifying Package Lists
```bash
# Add new packages to Brewfile
echo 'brew "package-name"' >> Brew/Brewfile
echo 'cask "app-name"' >> Brew/Brewfile

# Search for available packages
brew search package-name
brew search --cask app-name
```

## Important Implementation Details

### Remote Installation Flow
The main `install.sh` creates a temporary directory (`$HOME/SystemSetupTmp`), downloads and extracts the repository, executes the setup scripts in sequence, then cleans up all downloaded files.

### System Settings Applied
- Screenshots save to Downloads instead of Desktop  
- Dock size set to 26 pixels
- Screensaver activates after 5 minutes, password required after 4 hours
- ProtonMail set as default mail client
- Magic Mouse right-click enabled
- Spotlight keyboard shortcut disabled (for Raycast integration)

### Shell Configuration Applied
- Comprehensive .zshrc with development aliases and functions
- Git shortcuts (gs, ga, gc, gp, etc.) and enhanced git prompt
- Development tools shortcuts (Docker, Python, Node.js)
- System monitoring aliases (cpu, mem, ports, etc.)
- Useful functions (mkcd, extract, project setup, weather)
- Enhanced history settings and auto-completion
- Backup of existing .zshrc to .zshrc.backup

### Package Categories
- **Must Haves**: Core utilities (Warp, Python, ImageMagick, Proton suite, etc.)
- **Development**: Programming tools (Bun, Supabase CLI, GitHub CLI, Git Flow, VS Code, PyCharm, OrbStack)
- **Optional**: Media and productivity apps (Plex, Teams, CleanMyMac, etc.)

## Repository Structure Notes

- Scripts assume execution from repository root
- All shell scripts require executable permissions
- The installation process requires sudo privileges upfront
- Temporary files are automatically cleaned up after installation
