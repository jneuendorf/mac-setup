#!/usr/bin/env bash

if [ -f ~/.vscode_extensions ]; then
    extensions=$(cat ~/.vscode_extensions)

    # TODO: Support VSCode etc.
    if [ $(which codium) ]; then
        for extension in $extensions
        do
            codium --install-extension "$extension"
        done
    fi
fi
