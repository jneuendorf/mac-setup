#!/usr/bin/env bash

CURRENT_DIR=$(pwd)


# Try installing the command line tools (CLT) in any case since there may be
# problems detecting if already installed. For me, everything looked in place
#   xcode-select --print-path -> /Library/Developer/CommandLineTools
#   xcode-select --version    -> xcode-select version 2395.
# but I got
#   xcrun: error: invalid active developer path (/Library/Developer/CommandLineTools),
#   missing xcrun at: /Library/Developer/CommandLineTools/usr/bin/xcrun
# Thus the Homebrew install script didn't install the CLT for me.
# See https://apple.stackexchange.com/a/254381
if [ $(xcode-select --install) ]; then
    # Block the script until command line tools have been installed
    read -p 'Follow the installation wizard (this may take several minutes), then hit Enter:'
fi
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# Install pipenv in case we run a local version of mackup
brew install pipenv



echo "
>> Running mackup..."
# NOTE: Mackup takes care of copying all configs into place first.
cd mackup
pipenv install
pipenv run make develop
pipenv run mackup restore --copy --force



# Uninstall => revert to original state. 'src/restore/homebrew.sh' handles the rest
brew uninstall pipenv


echo "
>> Running restore post-processing scripts..."
cd "$CURRENT_DIR"
src/restore/homebrew.sh
src/restore/vscode-extensions.sh
src/restore/macos-prefs.sh



echo "
>> Done!
"