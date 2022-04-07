#!/usr/bin/env bash

if [ $(which brew) ]; then
    echo "> Backing up homebrew to ~/.Brewfile"
    brew bundle dump --force --file=~/.Brewfile
fi
