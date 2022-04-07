#!/usr/bin/env bash

if [ -f ~/.xcode_select ]; then
    echo "> Installing XCode Command Line Tools"
    xcode-select --install
fi
