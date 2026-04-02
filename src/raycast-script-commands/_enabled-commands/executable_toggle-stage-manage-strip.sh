#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle Stage Manager Strip
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🖥️
# @raycast.packageName Window Management

# Get the current state (0 for shown, 1 for hidden/autohide)
CURRENT_STATE=$(defaults read com.apple.WindowManager AutoHide)

if [ "$CURRENT_STATE" = "1" ]; then
  defaults write com.apple.WindowManager AutoHide -bool false
  echo "Recent apps: Shown"
else
  defaults write com.apple.WindowManager AutoHide -bool true
  echo "Recent apps: Hidden"
fi

# Refresh the Window Manager to apply changes
killall WindowManager
