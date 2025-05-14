<h1 align="center">Welcome to new_mac_setup 👋</h1>
<p>
  <img alt="Version" src="https://img.shields.io/badge/version-2.1.2-blue.svg?cacheSeconds=2592000" />
  <a href="https://twitter.com/BjornarOtterlei" target="_blank">
    <img alt="Twitter: BjornarOtterlei" src="https://img.shields.io/twitter/follow/BjornarOtterlei.svg?style=social" />
  </a>
</p>

> Just another automated new mac setup. Fork the repo and alter the  Brew/brewfile and the SysSettings/setup.sh to your liking before running the install command.

## Description

This is an automated setup for a new mac or a fresh install of mac. It is forked from the [Init-blog](https://github.com/Init-blog/BasicSystemSetup) github. You might want to fork that repo instead of this.

When running the install command, it will download the repo into a temp folder, and run install.sh. The install.sh will execute two scripts, the Brew/install.sh and SysSettings/setup.sh, before deleting everything it has downloaded.

The Brew/install.sh will install Homebrew, as well as everything defined in the Brewfile.

The SysSettings/setup.sh will configure system settings. Example of this is changing the default saving path for screenshots to the _Downloads_ folder instead of _Desktop_

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

