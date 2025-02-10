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

# vim: set foldenable foldmethod=marker foldlevel=0 foldmarker=(((,))):
