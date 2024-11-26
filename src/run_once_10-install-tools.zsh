#!/bin/zsh

set -x

# Install mise (((
() {
    (( ${+commands[mise]} )) && return 0
    curl https://mise.run | sh
}
# )))

# vim: set foldenable foldmethod=marker foldlevel=0 foldmarker=(((,))):
