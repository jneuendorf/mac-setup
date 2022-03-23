#!/usr/bin/env bash

# cwd=$(pwd)
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

./src/backup/vscode-extensions.sh


# FIND OUT WHICH MACKUP BINARY TO USE

# cp -f src/mackup.cfg ~/.mackup.cfg
# mackup_config="$(cat src/mackup.cfg) $(sed 's/ - //g' <<< $(pipenv run mackup list | grep -- '- '))"
# echo $mackup_config
# # mackup_apps=`sed 's/ - //g' <<< $(pipenv run mackup list | grep -- '- ')`
# exit 0

if [ $(which mackup) ]; then
    mackup_bin=$(which mackup)
    # apps_to_sync=$(sed 's/ - //g' <<< $(mackup list | grep -- '- '))
    # sed -i "s/__apps__/$apps_to_sync/" ~/.mackup.cfg

    # mackup backup
else
    cd mackup
    # pipenv install
    # pipenv run make develop

    mackup_bin="pipenv run mackup"

    # pipenv run mackup backup
fi


echo "
>> Generating mackup config..."
apps_to_sync=$(sed 's/ - //g' <<< $($mackup_bin list | grep -- '- '))  # remove ' - ' from all list items
# sed -i "s/__apps__/$apps_to_sync/" ~/.mackup.cfg
for app in $apps_to_sync
do
    echo "$app" >> ~/.mackup.cfg
done


echo "
>> Running mackup..."
$mackup_bin backup