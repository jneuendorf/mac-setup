#!/usr/bin/env bash

if [ -f ~/.xcode_select ] && [ ! $(xcode-select --print-path) ]; then
    echo "> Installing XCode Command Line Tools"
    xcode-select --install
fi
