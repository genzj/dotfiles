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

    if [[ -d "$HOME/.zfunc" ]]; then
        for f in "$HOME/.zfunc"/*; do
            autoload -Uz "$(basename "$f")"
        done
    fi
}
# )))

# Application-based function path setup (((
# This section dynamically loads function files based on application availability:
# 1. Looks for function directories in ./functions/
# 2. For directories named with __, checks if path exists (e.g. usr__local -> /usr/local)
# 3. For other directory names, checks if command exists (e.g. lsd -> $commands["lsd"])
# 4. If conditions met, adds directory to fpath and autoloads functions
() {
    local funcs_dir="${${(%):-%x}:A:h}/functions"
    [[ -d "$funcs_dir" ]] || return

    for folder in "$funcs_dir"/*(/N); do
        local folder_name="${folder:t}"
        local should_load=false

        if [[ "$folder_name" == *__* ]]; then
            local check_path="${folder_name//__//}"
            [[ -e "/$check_path" ]] && should_load=true
        else
            (( $+commands[$folder_name] )) && should_load=true
        fi

        if $should_load; then
            fpath=("$folder" $fpath)
            for func in "$folder"/*; do
                autoload -Uz "${func:t}"
            done
        fi
    done
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
