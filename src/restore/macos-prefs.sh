#!/usr/bin/env bash

echo "> Restoring macOS preferences from ~/.macos_prefs/"

for plist_file in ~/.macos_prefs/*.plist; do
    domain=$(basename "$plist_file" .plist)
    echo "   $domain"
    defaults import $domain "$plist_file"
done
