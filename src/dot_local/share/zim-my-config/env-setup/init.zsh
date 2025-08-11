# Path setting (((
() {
    local maybe_path=(
        "$HOME/bin"
        "$HOME/.local/bin"
        "$HOME/.local/nvim/bin"
        "$HOME/.tmux/plugins/tmux-session-wizard/bin"
        "$PYENV_ROOT/bin"
        "/opt/homebrew/bin"
    )

    for d in $maybe_path ; do
        try_adding_folder "$d" path
    done
}
# )))

# Android SDK setting (((
() {
    local android_sdk=""
    local maybe_path=(
        "$HOME/Library/Android/sdk"
    )

    for d in $maybe_path ; do
        if [[ -d "$d" ]] ; then
            android_sdk="$d"
            break
        fi
    done

    if [[ -n "$android_sdk" ]] ; then
        export ANDROID_HOME="$HOME/Library/Android/sdk"
        export PATH="$PATH:$ANDROID_HOME/emulator"
        export PATH="$PATH:$ANDROID_HOME/platform-tools"
    fi
}
# )))

# Aliases (((
() {
    alias s='sudo'
    alias la='ls -a'
    alias lla='ls -a -l'
}
# )))

# Completion path setting (((
() {
    try_adding_folder ~/.zsh/completion fpath
    try_adding_folder ~/.zfunc fpath
}
# )))

# Tmux plugin settings (((
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/tmux/README.md
export ZSH_TMUX_DEFAULT_SESSION_NAME="default"
# )))

# Zsh options (((
# disable EXTENDED_GLOB to simplify git command inputs
unsetopt EXTENDED_GLOB

WORDCHARS='*?_~&;!#$%^<>'
# )))

# Editor setting (((
() {
    if (( $+commands[nvim] )) ; then
        export EDITOR=nvim
    fi
}
# )))

# vim: set foldenable foldmethod=marker foldlevel=0 foldmarker=(((,))):
