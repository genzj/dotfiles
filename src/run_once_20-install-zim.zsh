#!/bin/zsh

set -x

# Install zim (((
() {
    [[ -d "$HOME/.zim" ]] && return 0
    curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
}
# )))

# Install starship (((
() {
    (( ${+commands[starship]} )) && return 0
    curl -sS https://starship.rs/install.sh | sh
}
# )))

# Install fzf (((
() {
    (( ${+commands[fzf]} )) && return 0
    curl -fsSL --output "$HOME/.fzf-install" https://github.com/junegunn/fzf/raw/refs/heads/master/install &&
        bash "$HOME/.fzf-install" --bin
}
# )))

# Install zoxide (((
() {
    (( ${+commands[zoxide]} )) && return 0
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
}
# )))

# vim: set foldenable foldmethod=marker foldlevel=0 foldmarker=(((,))):
