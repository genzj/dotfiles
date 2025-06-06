#!/bin/bash
#
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Outdated List
# @raycast.mode fullOutput
# @raycast.packageName Brew
#
# Optional parameters:
# @raycast.icon 🍺
#
# Documentation:
# @raycast.description Show list of outdated formulae
# @raycast.author Thiago Holanda
# @raycast.authorURL https://twitter.com/tholanda

if ! command -v brew &> /dev/null; then
  echo "brew command is required (https://brew.sh).";
  exit 1;
fi

BREW=/opt/homebrew/bin/brew

echo "🚧 Updating brew recipes"

OUT=$("$BREW" update --quiet &>/dev/null && \
    "$BREW" outdated -g)
COUNT="$(echo "$OUT" | wc -l | awk '{ print $1 }')"
echo "$OUT"
echo "🍻 ${COUNT} items are outdated."
