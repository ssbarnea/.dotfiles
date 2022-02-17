#!/bin/bash
set -ex

# Relinking dotfiles
stow -v root hush

# Installing python dependencies
pip install -q -r requirements.txt
