#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open MeshClaw
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon 🦞

open "$(ssh cloud-dsk "/bin/zsh -ic '~/workplace/MeshClaw/src/MeshClaw/bin/meshclaw token' 2>/dev/null")"
