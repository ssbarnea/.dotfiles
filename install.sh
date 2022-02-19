#!/bin/bash
set -ex

# Relinking dotfiles
stow -v root hush

# Installing python dependencies
pip install -q -r requirements.txt

# Install npm dependencies
cat npm.txt | grep -v '^#' | xargs npm install -g
