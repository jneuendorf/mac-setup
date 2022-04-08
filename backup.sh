#!/usr/bin/env bash

if [[ "$1" != "" ]]; then
    git clone "$1" mackup_clone
    mackup_dir="mackup_clone"
else
    mackup_dir="mackup"
fi


CURRENT_DIR=$(pwd)
# According to src/mackup.cfg
BACKUP_DIR=~/macos-backup



# NOTE: mackup automatically backs up the configs' apps
echo "
>> Copying application configs..."
mkdir -p ~/.mackup/
for cfg in $(ls src/configs/); do
    echo "copying src/configs/$cfg -> ~/.mackup/$cfg"
    cp "src/configs/$cfg" ~/.mackup/
done
echo "> Copying Mackup config ..."
cp src/mackup.cfg ~/.mackup.cfg
if [ -f custom.cfg ]; then
    echo "> Copying custom config ..."
    cp custom.cfg ~/.mackup/
fi



echo "
>> Running backup preparation scripts..."
src/backup/homebrew.sh
src/backup/vscode-extensions.sh
src/backup/macos-prefs.sh
src/backup/xcode-select.sh



echo "
>> Running mackup..."
cd $mackup_dir
# pipenv install
# pipenv run make develop
pipenv run mackup backup --copy --force



echo "
>> Generating restore script..."
# Copy this project (and mackup (the clone if necessary)) to the backup location
# so it can be run on a fresh machine
cd "$CURRENT_DIR"
if [[ -d $BACKUP_DIR/mackup ]] || [[ -f $BACKUP_DIR/mackup ]]; then
    echo "WARNING: There is a file/folder 'mackup' in the backup folder. Please make sure you don't backup any files/folders with this name from your home directory."
fi
cp -R $mackup_dir $BACKUP_DIR/mackup/
# Rename 'mackup_clone' to 'mackup' if necessary
# mv -f $BACKUP_DIR/mackup_clone $BACKUP_DIR/mackup
cp src/restore.sh $BACKUP_DIR
mkdir -p $BACKUP_DIR/src/restore/
cp -R src/restore/. $BACKUP_DIR/src/restore/


echo "
>> Done!
"