on run argv
	tell application "iStat Menus"
		activate
	end tell

	tell application "System Events"
		tell process "iStat Menus"
			click menu item "Export Settings…" of menu "file" of menu bar 1
		end tell
	end tell

	tell application "System Events"
		tell process "iStat Menus"
			keystroke "g" using {shift down, command down} -- go to
			delay 1
			keystroke item 1 of argv -- argv[1]
			delay 1
			keystroke return
			delay 1
			keystroke return
			delay 1
			keystroke "w" using command down
		end tell
	end tell
end run