#!/usr/bin/env bash

CURRENT_DIR=$(pwd)



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
src/restore/xcode-select.sh
src/restore/homebrew.sh
src/restore/vscode-extensions.sh
src/restore/macos-prefs.sh



echo "
>> Done!
"