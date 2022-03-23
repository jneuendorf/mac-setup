#!/usr/bin/env bash

mkdir -p ~/.mackup
# curl -L https://github.com/lra/mackup/files/3684261/vscode-extensions.cfg.txt > ~/.mackup/vscode-extensions.cfg
# grep '\[applications_to_sync\]' ~/.mackup.cfg && echo 'VSCode-Extensions' >> ~/.mackup.cfg

echo "[application]
name = VSCode Extensions

[configuration_files]
.vscode/extensions" > ~/.mackup/vscode-extensions.cfg

echo "[application]
name = VSCodium Extensions

[configuration_files]
.vscode-oss/extensions" > ~/.mackup/vscodium-extensions.cfg

if [ grep '\[applications_to_sync\]' ~/.mackup.cfg ]; then
    grep '\[applications_to_sync\]' ~/.mackup.cfg && echo 'VSCode-Extensions' >> ~/.mackup.cfg
    grep '\[applications_to_sync\]' ~/.mackup.cfg && echo 'VSCodium-Extensions' >> ~/.mackup.cfg
else
    echo "
[applications_to_sync]
VSCode-Extensions
VSCodium-Extensions
" >> ~/.mackup.cfg
fi