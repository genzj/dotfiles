#!/bin/zsh
set -x

# Rebuild bat theme cache (((
() {
    (( ${+commands[bat]} )) || return 0
    bat cache --build
}
# )))

# Reinstall ZIM modules (((
() {
    test -e "${HOME}/.zim/zimfw.zsh" || return 0
    source .zshrc
    zimfw reinstall -q
}
#)))

# Disable global compinit if Zsh is installed by Ubuntu apt (((
() {
    (( ${+commands[apt]} )) || return 0
    apt list --installed zsh 2>/dev/null | grep -q ubuntu || return 0
    grep -q 'skip_global_compinit' ~/.zshenv 2>/dev/null && return 0
    echo 'skip_global_compinit=1' >>! ~/.zshenv
}
#)))

# vim: set foldenable foldmethod=marker foldlevel=0 foldmarker=(((,))):
