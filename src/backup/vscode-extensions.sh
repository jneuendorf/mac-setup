#!/usr/bin/env bash

echo "> backing up VSCode extensions to ~/.vscode_extensions"

# TODO: Support VSCode etc.
if [ $(which codium) ]; then
    extensions=$(codium --list-extensions)
fi


if [ "$extensions" != "" ]; then
    echo "$extensions" > ~/.vscode_extensions
fi
