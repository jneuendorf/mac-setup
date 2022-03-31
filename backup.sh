#!/usr/bin/env bash


mackup_cfg="$1"

if [[ "$mackup_cfg" != "" ]]; then
    mackup_cfg="$1"
    if [ -f ~/.vscode_extensions ]; then
        #
    else
        echo "Invalid mackup config path '$1'. Exiting..."
        exit 1
    fi
else
    mackup_cfg=src/mackup.cfg
fi



echo "
>> Copying mackup config stub..."

cp "$mackup_cfg" ~/.mackup.cfg



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

./src/backup/homebrew.sh
./src/backup/vscode-extensions.sh
python3 ./src/backup/defaults.py



# FIND OUT WHICH MACKUP BINARY TO USE
if [ $(which mackup) ]; then
    mackup_bin=$(which mackup)
else
    cd mackup
    # pipenv install
    # pipenv run make develop
    mackup_bin="pipenv run mackup"
fi



echo "
>> Finalizing mackup config (applications_to_sync)..."

echo "[applications_to_sync]" >> ~/.mackup.cfg
apps_to_sync=$(sed 's/ - //g' <<< $($mackup_bin list | grep -- '- '))  # remove ' - ' from all list items
for app in $apps_to_sync
do
    echo "$app" >> ~/.mackup.cfg
done



echo "
>> Running mackup..."

$mackup_bin backup


# TODO
# echo "
# >> Generating standalone restore binary"