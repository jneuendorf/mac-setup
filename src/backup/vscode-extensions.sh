#!/usr/bin/env bash

# TODO: Support VSCode etc.
if [ $(which codium) ]; then
    extensions=$(codium --list-extensions)
fi


if [ "$extensions" != "" ]; then
    echo "$extensions" > ~/.vscode_extensions
fi
