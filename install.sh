#!/bin/bash
set -ex

# Quickly install all brew dependencies from Brewfile
brew bundle --no-upgrade --no-lock

# Relinking dotfiles
stow -v root hush

# Installing python dependencies
pip install -q -r requirements.txt

# Install npm dependencies
grep -v '^#' npm.txt  | xargs npm install -g

# Configure background updates if needed
brew autoupdate status | grep 'and running' >/dev/null || {
    brew autoupdate --upgrade start 86400 --enable-notification
}
