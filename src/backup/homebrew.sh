#!/usr/bin/env bash

if [ $(which brew) ]; then
    echo "> backing up homebrew to ~/.Brewfile"
    brew bundle dump --force --file=~/.Brewfile
fi
