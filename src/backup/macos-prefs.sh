#!/usr/bin/env bash

echo "> Backing up macOS preferences to ~/.macos_prefs/"

mkdir -p ~/.macos_prefs/
for domain in $(defaults domains); do
    if [[ "$domain" == com.apple.* ]]; then
        # Remove trailing comma
        domain=$(sed 's/,//g' <<< $domain)
        echo "   $domain"
        defaults export $domain ~/.macos_prefs/$domain.plist
    fi
done
defaults export NSGlobalDomain ~/.macos_prefs/NSGlobalDomain.plist
defaults -currentHost export NSGlobalDomain ~/.macos_prefs/NSGlobalDomain.currentHost.plist
