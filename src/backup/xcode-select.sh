#!/usr/bin/env bash

if [ $(xcode-select --print-path) ]; then
    echo "> Backing up xcode-select to ~/.xcode_select"
    xcode-select --print-path > ~/.xcode_select
    xcode-select --version >> ~/.xcode_select
fi