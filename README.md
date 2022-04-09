# mac-setup

A script for backing up some of the macOS configuration that can be restored on a blank macOS machine.



# What's being backed up?

- everything supported by Mackup
  - Homebrew is taken care of, i.e. the creation of a `Brewfile`
    - This includes applications managed by [mas](https://github.com/mas-cli/mas#-homebrew-integration)
- VSCodium extensions
- macOS preferences
  - There are some limitations:
    - Only user preferences are backup, i.e. power management is missing, I believe
    - Only `defaults` is used. There may be other reasonable configrations that may be accessible differently (i.e. a different command or even using AppleScript (GUI programming)). I am open for additions (issues / pull requests).
- XCode command line tools
- Any other *user* files you want. See below.


## Motivation


After having started writing TypeScript backup scripts and checking some resources on how to backup macOS `defaults` best,
I accidentally bumped into this [StackExchange Answer](https://apple.stackexchange.com/a/361946), which mentions *Mackup* and *MacPrefs*.


Running [MacPrefs](https://github.com/clintmod/macprefs) didn't work for me.
Mackup worked well in principle and is actively maintained (big shout-out to @lra!), thus this project is heavily based on [Mackup](https://github.com/lra/mackup).

This project is an extension wrapper around Mackup.
This way, arbitrary backup operations can be run before Mackup's backup is being run.
Therefore, the backup is not limited to files being copied/linked, but files can be generated, for example.
Also some more apps are supported and some apps are better supported (checkout the config files in `src/configs/`).

In addition, I didn't want to upload my backup to some cloud service
but wanted a local copy in case backing up private data is required
(even encryption would be pointless if the key is not backed up elsewhere...).

Furthermore, the backup can be restored without any prior user action, i.e. it does not require the user to install software before the backup can be restored.



## Usage



### Backup



:warning: The following commands must be run from this project's root directory.

The backup script creates the folder `~/macos-backup` in your home directory.
This backup folder can be moved around (most likely it contains hidden files!) as it's self-contained for restoring it.

```bash
./backup
# Custom repo clone (i.e. if you have a fork yourself, please create a Pull Request ;) )
# - The clone must be executable in the same way as https://github.com/lra/mackup.git
./backup 'git@github.com:jneuendorf/mackup.git --branch enable_glob'
```

To specify additional personal files to be backed up run `./customize.sh`.
This creates `custom.cfg` and `mackup.cfg` in the current working directory and open's the former for editing
(see the [Mackup docs](https://github.com/lra/mackup/tree/9f7b8473c509831ccc489e2b7842f8682136ed76/doc#add-support-for-an-application-or-almost-any-file-or-directory)).
The backup process then picks them up automatically.

You can save the backup directly on an external storage device
by editing the `mackup.cfg`'s `path` option, e.g. `path = /Volumes/MyDrive`.



### Restore

Simply run `./restore.sh` from the backup folder.


## Related Projects / Used Resources

- https://github.com/clintmod/macprefs
- https://github.com/lra/mackup
- https://github.com/Aerolab/setup
- https://github.com/ptb/mac-setup
- https://github.com/bkuhlmann/mac_os-config
- https://github.com/bkuhlmann/mac_os
- https://github.com/pathikrit/mac-setup-script
- https://github.com/daemonza/setupmac
- https://github.com/wilsonmar/mac-setup
- https://github.com/AkkeyLab/mac-auto-setup
- https://github.com/kaishin/Setup
- https://github.com/andrewconnell/osx-install
- https://git.herrbischoff.com/awesome-macos-command-line/about/
- https://github.com/CodelyTV/dotfiles
