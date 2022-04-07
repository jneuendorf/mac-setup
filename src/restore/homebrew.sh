#!/usr/bin/env bash

if [ -f ~/.Brewfile ]; then
    echo "> restoring Homebrew formulas/casks from ~/.Brewfile"
    # No need to install Homebrew because we need it in the main script anyway
    brew bundle install --file=~/.Brewfile
else
    # Uninstall Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
fi

