#!/usr/bin/env bash

# https://stackoverflow.com/a/8488293/6928824


echo "
>> Copying mackup config stub..."
cp src/mackup.cfg ~/.mackup.cfg


echo "
>> Copying application configs..."

mkdir -p ~/.mackup/
for config in $(ls src/configs/)
do
    echo "copying src/configs/$config -> ~/.mackup/$config"
    # cp -v -f "src/configs/$config" "~/.mackup/"
    cp "src/configs/$config" ~/.mackup
done


echo "
>> Running backup preparation scripts..."
./src/backup/homebrew.sh
./src/backup/vscode-extensions.sh


# FIND OUT WHICH MACKUP BINARY TO USE
if [ $(which mackup) ]; then
    mackup_bin=$(which mackup)
else
    cd mackup
    mackup_bin="pipenv run mackup"
fi


echo "
>> Generating mackup config..."
apps_to_sync=$(sed 's/ - //g' <<< $($mackup_bin list | grep -- '- '))  # remove ' - ' from all list items
for app in $apps_to_sync
do
    echo "$app" >> ~/.mackup.cfg
done


echo "
>> Running mackup..."
$mackup_bin backup