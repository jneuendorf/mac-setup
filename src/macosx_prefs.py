import json
from pathlib import Path
import subprocess


PREFS_FILENAME = '~/.macos_prefs.json'
PREFS_FILE_PATH = Path(PREFS_FILENAME).expanduser()


print(f'> backing up macOS preferences to {PREFS_FILENAME}')


def get_read_command(item: dict) -> str:
    return (
        f'{"sudo " if item.get("sudo", False) else ""}'
        f'defaults read {item["domain"]} \'{item["key"]}\''
    )


def get_write_command(item: dict) -> str:
    param_type = item["param"]["type"]
    # Convert additions to setters because read commands return the entire array/dict.
    if param_type == 'array-add':
        param_type = 'array'
    elif param_type == 'dict-add':
        param_type = 'dict'

    return (
        f'{"sudo " if item.get("sudo", False) else ""}'
        f'defaults write {item["domain"]} \'{item["key"]}\' '
        f'-{param_type} \'{{value}}\''
    )


def run_command(command, sudo=False) -> tuple[bool, str]:
    # TODO: handle sudo, see
    #  https://github.com/jneuendorf/AdvancedSettingsMacOS/blob/master/options/command.py#L36-L58
    #  Should the entire backup/restore be run with sudo or is single command sudo access better?
    # print(f'running: {command}')
    try:
        response = subprocess.check_output(
            command,
            shell=True,
            stderr=subprocess.STDOUT,
        )
        success = True
    except subprocess.CalledProcessError as error:
        # print(str(error))
        success = error.returncode == 0
        response = error.output
    return success, response.decode('utf-8')


def backup_prefs(skip_sudo=True):
    with open(Path(__file__).resolve().parent / 'macosx-prefs.json') as file:
        defaults_data: dict[str, list[dict]] = json.load(file)
        used_keys = set()
        prefs = []

        for source, items in defaults_data.items():
            for item in items:
                for key_item in item['keys']:
                    key = (key_item['domain'], key_item['key'])
                    assert key not in used_keys, (
                        f'duplicate key {key}'
                    )
                    used_keys.add(key)

                    command = get_read_command(key_item)
                    if key_item.get('sudo'):
                        if skip_sudo:
                            continue

                        print('root access required for:', command)
                        do_sudo = input('Continue with password? (y/n) ')
                        if do_sudo.lower() != 'y':
                            continue

                    # print(get_write_command(key_item).format(value=2))
                    success, output = run_command(command)
                    if success:
                        prefs.append([*key, output.strip()])
                        # print()
                        # print(command)
                        # print(output)

    # print(json.dumps(prefs, indent=2))
    with PREFS_FILE_PATH.open('w') as file:
        json.dump(prefs, file)


def restore_prefs():
    ...



# TODO: The following commands don't fit the json structure or are not `defaults`, but may be useful nonetheless
#     'standbydelay': {
#         'label': 'Set standby delay in hours (default is 1 hour).',
#         'command': 'pmset -a standbydelay {0}',
#         'type': 'number',
#         'stringify_input': lambda hours: str(int(hours * 3600)),
#         'sudo': True,
#         'default': '1',
#     }
#     => pmset -g everything -> seems it's been renamed to 'standby
#     => pmset -g live | grep standby
#
#     'soundonboot': {
#         'label': 'Disable the sound effects on boot',
#         'command': 'nvram SystemAudioVolume=" "',
#         # 'type': 'boolean',
#         'type': 'none',
#         'sudo': True,
#     }
#     => nvram SystemAudioVolume -> 'SystemAudioVolume	7
#
#     'hibernatemode': {
#         'label': 'Disable hibernation (speeds up entering sleep mode).',
#         'command': 'sudo pmset -a hibernatemode 0',
#         'type': 'none',
#         'sudo': True,
#     }
#
    # 'automaticEmojiSubstitutionEnablediMessage': {
    #     'label': 'Disable automatic emoji substitution (i.e. use plain text smileys).',
    #     'command': 'defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool {0}',
    #     'type': 'boolean',
    # }

    # 'automaticQuoteSubstitutionEnabled': {
    #     'label': 'Disable smart quotes as it’s annoying for messages that contain code.',
    #     'command': 'defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool {0}',
    #     'type': 'boolean',
    # }

    # 'continuousSpellCheckingEnabled': {
    #     'label': 'Disable continuous spell checking.',
    #     'command': 'defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool {0}',
    #     'type': 'boolean',
    # }
# TODO: The following commands are more complex (use -dict-add or multiple arguments)...
# {'label': 'Expand the following File Info panes: “General”, “Open with”, and “Sharing & Permissions”.', 'command': 'defaults write com.apple.finder FXInfoPanesExpanded -dict General -bool true OpenWith -bool true Privileges -bool true', 'type': 'none'}
# {'label': 'Add the keyboard shortcut ⌘ + Enter to send an email.', 'command': 'defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Send" "@\\U21a9"', 'type': 'none'}
# {'label': 'Display emails in threaded mode, sorted by date (oldest at the top)', 'command': 'defaults write com.apple.mail DraftsViewerAttributes -dict-add "DisplayInThreadedMode" -string "yes" && defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortedDescending" -string "yes" && defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortOrder" -string "received-date"', 'type': 'none'}
# {'label': 'Disable automatic emoji substitution (i.e. use plain text smileys).', 'command': 'defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool {0}', 'type': 'boolean'}
# {'label': 'Disable smart quotes as it’s annoying for messages that contain code.', 'command': 'defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool {0}', 'type': 'boolean'}
# {'label': 'Disable continuous spell checking.', 'command': 'defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool {0}', 'type': 'boolean'}
