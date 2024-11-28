#!/bin/zsh

set -x

# Install mise (((
() {
    (( ${+commands[mise]} )) && return 0
    curl https://mise.run | sh
}
# )))

# Install fd (((
() {
    (( ${+commands[fd]} )) && return 0
    if (( ${+commands[fdfind]} )) ; then \
        mkdir -p "$HOME/.local/bin"
        [[ -f "$HOME/.local/bin/fd" ]] || ln -s "${commands[fdfind]}" "$HOME/.local/bin/fd"
        return 0
    fi
    /usr/bin/env | sort
    "${CHEZMOI_SOURCE_DIR}/../scripts/fd-install.sh" --bin-dir ~/.local/bin
}
# )))

# vim: set foldenable foldmethod=marker foldlevel=0 foldmarker=(((,))):
