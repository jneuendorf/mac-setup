#!/usr/bin/env bash


# TODO: Support VSCode etc.
if [ $(which codium) ]; then
    extensions=$(codium --list-extensions)
fi


if [ "$extensions" != "" ]; then
    echo "> Backing up VSCode extensions to ~/.vscode_extensions"
    echo "$extensions" > ~/.vscode_extensions
fi
