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

# Install and Update tmux plugins (((
() {
    test -e "${HOME}/.tmux/plugins/tpm/bin/install_plugins" || return 0
    "${HOME}/.tmux/plugins/tpm/bin/install_plugins"
    test -e "${HOME}/.tmux/plugins/tpm/bin/update_plugins" || return 0
    "${HOME}/.tmux/plugins/tpm/bin/update_plugins" all
}
#)))

# Disable global compinit if Zsh is installed by Ubuntu apt (((
() {
    (( ${+commands[apt]} )) || return 0
    [[ -f /etc/zsh/zshrc ]] || return 0
    grep -q 'skip_global_compinit' /etc/zsh/zshrc 2>/dev/null || return 0
    grep -q 'skip_global_compinit' ~/.zshenv 2>/dev/null && return 0
    echo 'skip_global_compinit=1' >>! ~/.zshenv
}
#)))

# vim: set foldenable foldmethod=marker foldlevel=0 foldmarker=(((,))):
