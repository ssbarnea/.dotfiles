#!/bin/bash
# shellcheck source=$HOME/.bash_profile
[ -n "$PS1" ] && source "$HOME/.bash_profile";

eval "$(_MOLECULE_COMPLETE=source_bash molecule)"
