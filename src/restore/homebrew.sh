#!/usr/bin/env bash

if [ -f ~/.Brewfile ]; then
    echo "> restoring Homebrew formulas/casks from ~/.Brewfile"
    # No need to install Homebrew because we need it in the main script anyway
    brew bundle install --file=~/.Brewfile
fi

