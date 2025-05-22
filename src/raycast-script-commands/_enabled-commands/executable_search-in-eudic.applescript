#!/usr/bin/osascript

# Note: EuDic required

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Look up a word in EuDic
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName EuDic
# @raycast.icon images/eudic.png
#
# Arguments
# @raycast.argument1 { "type": "text", "placeholder": "Word", "optional": false }
#
# Documentation:
# @raycast.description Open EuDic and search for the word
# @raycast.author genzj
# @raycast.authorURL https://github.com/genzj

on run argv
	tell application "Eudb_en"
		reopen
		show dic with word item 1 of argv
	end tell
end run
