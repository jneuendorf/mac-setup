#!/usr/bin/env bash


mackup_cfg="$1"

if [[ "$mackup_cfg" != "" ]]; then
    mackup_cfg="$1"
    if [ ! -f "$mackup_cfg" ]; then
        echo "Invalid mackup config path '$1'. Exiting..."
        exit 1
    fi
else
    mackup_cfg=src/mackup.cfg
fi



echo "
>> Copying mackup config stub..."

cp "$mackup_cfg" ~/.mackup.cfg



# NOTE: mackup automatically backs up the configs' apps
echo "
>> Copying application configs..."

mkdir -p ~/.mackup/
for cfg in $(ls src/configs/)
do
    echo "copying src/configs/$cfg -> ~/.mackup/$cfg"
    cp "src/configs/$cfg" ~/.mackup
done



echo "
>> Running backup preparation scripts..."

src/backup/homebrew.sh
src/backup/vscode-extensions.sh
src/backup/macos-prefs.sh



# FIND OUT WHICH MACKUP EXECUTABLE TO USE
if [ $(which mackup) ]; then
    mackup_bin=$(which mackup)
else
    cd mackup
    pipenv install
    pipenv run make develop
    mackup_bin="pipenv run mackup"
fi



echo "
>> Running mackup..."

$mackup_bin backup --copy --force
