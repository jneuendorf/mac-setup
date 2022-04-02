from pathlib import Path
import sys

# Enable importing from project root
PROJECT_ROOT = Path(__file__).parent.parent.parent
sys.path.insert(0, str(PROJECT_ROOT))


from src.macosx_prefs import backup_prefs


if __name__ == '__main__':
    backup_prefs(skip_sudo=True)
