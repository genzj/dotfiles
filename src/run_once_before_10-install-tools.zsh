#!/bin/zsh

set -x

/usr/bin/env | sort

# Ensure tool bin dir (((
mkdir -p "$HOME/.local/bin"
# )))

# Install mise (((
() {
    (( ${+commands[mise]} )) && return 0
    curl https://mise.run | sh
}
# )))

# TODO: migrate to `mise use -g auqa:xxx` (sharkdp/fd, sharkdp/bat, BurntSushi/ripgrep and lsd-rs/lsd) or `ubi:xxx/yyy` (zoxide)
# TODO: add lsd-rs/lsd
# Install fd (((
() {
    (( ${+commands[fd]} )) && return 0
    if (( ${+commands[fdfind]} )) ; then
        [[ -e "$HOME/.local/bin/fd" ]] || ln -s "${commands[fdfind]}" "$HOME/.local/bin/fd"
        return 0
    fi
    "${CHEZMOI_SOURCE_DIR}/../scripts/fd-install.sh" --bin-dir ~/.local/bin
}
# )))

# Install bat (((
() {
    (( ${+commands[bat]} )) && return 0
    if (( ${+commands[batcat]} )) ; then
        [[ -e "$HOME/.local/bin/bat" ]] || ln -s "${commands[batcat]}" "$HOME/.local/bin/bat"
        return 0
    fi
    "${CHEZMOI_SOURCE_DIR}/../scripts/bat-install.sh" --bin-dir ~/.local/bin
}
# )))

# Install ripgrep (((
() {
    (( ${+commands[rg]} )) && return 0
    "${CHEZMOI_SOURCE_DIR}/../scripts/ripgrep-install.sh" --bin-dir ~/.local/bin
}
# )))

# vim: set foldenable foldmethod=marker foldlevel=0 foldmarker=(((,))):
