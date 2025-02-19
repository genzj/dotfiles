#!/bin/zsh

set -x

infocmp xterm-kitty >/dev/null && exit 0

cat "${CHEZMOI_SOURCE_DIR}/../data/kitty.terminfo.tic" | tic -x -

