<h1 align="center">Welcome to new_mac_setup 👋</h1>
<p>
  <img alt="Version" src="https://img.shields.io/badge/version-1.0.0-blue.svg?cacheSeconds=2592000" />
  <a href="https://twitter.com/BjornarOtterlei" target="_blank">
    <img alt="Twitter: BjornarOtterlei" src="https://img.shields.io/twitter/follow/BjornarOtterlei.svg?style=social" />
  </a>
</p>

> Just another automated new mac setup. Fork the repo and alter the  Brew/brewfile and the SysSettings/setup.sh to your liking before running the install command.

## Description

This is an automated setup for a new mac or a fresh install of mac. It is forked from the [Init-blog](https://github.com/Init-blog/BasicSystemSetup) github. You might want to fork that repo instead of this.

When running the install command, it will download the repo into a temp folder, and run install.sh. The install.sh will execute three scripts, before deleting everything it has downloaded:

1. **Brew/install.sh** - Installs Homebrew and all packages defined in the Brewfile
2. **SysSettings/setup.sh** - Configures system settings (e.g., screenshot save location, dock size, etc.)
3. **SysSettings/setup_zshrc.sh** - Sets up a comprehensive .zshrc with useful aliases, functions, and development shortcuts

## Shell Configuration

The setup includes a comprehensive .zshrc configuration with:
- Useful aliases for development, git, system management
- Handy functions like `mkcd`, `extract`, `project`, `cdm`
- Enhanced history and git-aware prompt
- Universal package manager (`ni`) for seamless npm/yarn/pnpm/bun usage [Check out Antfu's ni](https://github.com/antfu-collective/ni)

### Personal Customizations

Your existing .zshrc will be backed up to `.zshrc.backup`. For personal customizations that won't be overwritten by future runs, create a `~/.zshrc.local` file:

```bash
# ~/.zshrc.local - Your personal customizations
alias myalias="my command"
export MY_VAR="my value"
# Add your custom functions, aliases, etc.
```

This file will be automatically sourced by the main .zshrc configuration.

## Install

```sh
REPO_OWNER="GITHUB_USERNAME"
REPO_NAME="REPO_NAME" 
curl -sSL https://raw.githubusercontent.com/"$REPO_OWNER"/"$REPO_NAME"/main/install.sh | sh -s "$REPO_OWNER" "$REPO_NAME"
```

## Author

👤 **Bjørnar Otterlei**

* Website: https://www.kodesmien.no
* Twitter: [@BjornarOtterlei](https://twitter.com/BjornarOtterlei)
* Github: [@Bcdo](https://github.com/Bcdo)

## Show your support

Give a ⭐️ if this project helped you!

