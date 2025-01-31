# Path setting (((
() {
    local maybe_path=(
        "$HOME/bin"
        "$HOME/.local/bin"
        "$HOME/.local/nvim/bin"
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

# fzf (((

# taken from https://github.com/zimfw/fzf/blob/390a9f3adadfa3e244d972524c890a8f18d4d672/init.zsh#L1C1-L10C45
() {
  local -r target=${1}
  shift
  (( ${+commands[${1}]} )) || return 1
  if [[ ! ( -s ${target} && ${target} -nt ${commands[${1}]} ) ]]; then
    "${@}" >! ${target} || return 1
    zcompile -UR ${target}
  fi
  source ${target}
} ${0:h}/fzf---zsh.zsh fzf --zsh || return 1

fzf_fd_opt='--hidden --follow --exclude "Google Drive" --exclude ".lsp_symlink" --exclude ".bemol" --exclude ".git" --exclude "node_modules" --exclude "site-packages"'

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.

_fzf_compgen_path() {
    eval "fd $fzf_fd_opt . \"$1\""
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
    eval "fd $fzf_fd_opt --type d . \"$1\""
}

export FZF_DEFAULT_COMMAND="command fd $fzf_fd_opt --type d --type f"
export FZF_ALT_C_COMMAND="command fd $fzf_fd_opt --type d ."

# taken from https://github.com/zimfw/fzf/blob/390a9f3adadfa3e244d972524c890a8f18d4d672/init.zsh#L42-L73
local bat_cmd
if (( ${+commands[bat]} )); then
  bat_cmd=bat
elif (( ${+commands[batcat]} )); then
  # APT package
  bat_cmd=batcat
fi
if [[ -n ${bat_cmd} ]]; then
  export FZF_CTRL_T_OPTS="--bind ctrl-/:toggle-preview --preview 'command ${bat_cmd} --color=always --line-range :500 {}' ${FZF_CTRL_T_OPTS}"
fi
unset bat_cmd

local ls_cmd
if (( ${+commands[lsd]} )); then
  ls_cmd='lsd -l --color=always'
elif command ls --version &>/dev/null; then
  # GNU
  ls_cmd='ls --group-directories-first --color=always'
else
  # Stock OpenBSD ls does not support colors at all, but colorls does.
  if [[ ${OSTYPE} == openbsd* ]]; then
    if (( ${+commands[colorls]} )); then
      ls_cmd='colorls --color=always -CF'
    else
      ls_cmd='ls -CF'
    fi
  else
    ls_cmd='ls --color=always -CF'
  fi
fi
export FZF_ALT_C_OPTS="--bind ctrl-/:toggle-preview --preview 'command ${ls_cmd} {}' ${FZF_ALT_C_OPTS}"
unset ls_cmd

if (( ${+FZF_DEFAULT_COMMAND} )) export FZF_CTRL_T_COMMAND=${FZF_DEFAULT_COMMAND}

# )))

# Tmux plugin settings (((
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/tmux/README.md
export ZSH_TMUX_DEFAULT_SESSION_NAME="default"
# )))

# vim: set foldenable foldmethod=marker foldlevel=0 foldmarker=(((,))):
