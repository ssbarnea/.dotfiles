#!/bin/bash
set -ex

if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
    mkdir -p "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
fi

if [[ $OSTYPE == 'darwin'* ]]; then
    # Quickly install all brew dependencies from Brewfile
    brew bundle --no-upgrade --no-lock --file Brewfile.min.rb
fi

# Relinking dotfiles
stow -v root hush

# Installing python dependencies
pip3 install --user -q -r requirements.txt

# Install npm dependencies
type npm 2>/dev/null && {
    grep -v '^#' npm.txt | xargs npm install -g
}

if [[ $OSTYPE == 'darwin'* ]]; then
    # Configure background updates if needed
    brew autoupdate status | grep 'and running' >/dev/null || {
        brew autoupdate --upgrade start 86400 --enable-notification
    }

    # Avoid installing the whole brew bundle unless on interactive shell
    if tty -s; then
        brew bundle --no-upgrade --no-lock
    fi
fi
