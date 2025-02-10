# External Env II -- Env may change auto completion (((

() {
    local maybe_env=(
    )

    for d in $maybe_env ; do
        [[ -f "$d" ]] && source "$d"
    done
}

# )))

# More completion setups (((

# kitten ssh alias
# use function instead of alias for correct completion
kssh() {
    command kitten ssh "$@"
}
compdef kssh=ssh

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
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
export FZF_ALT_C_COMMAND="command fd $fzf_fd_opt --type d ."

_fzf_zoxide() {
    setopt localoptions pipefail no_aliases 2> /dev/null
    local dir="$(
FZF_DEFAULT_COMMAND=${FZF_ZOXIDE_COMMAND:-} \
FZF_DEFAULT_OPTS=$(__fzf_defaults "--reverse --walker=dir,follow,hidden --scheme=path" "${FZF_ZOXIDE_OPTS-} +m") \
FZF_DEFAULT_OPTS_FILE='' $(__fzfcmd) < /dev/tty)"
    if [[ -z "$dir" ]]
    then
            zle redisplay
            return 0
    fi
    zle push-line
    BUFFER="builtin cd -- ${(q)dir:a}"
    zle accept-line
    local ret=$?
    unset dir
    zle reset-prompt
    return $ret
}

if (( ${+commands[zoxide]} )); then
    export FZF_ZOXIDE_COMMAND="command zoxide query --list"
    export FZF_ZOXIDE_OPTS=""
    zle -N _fzf_zoxide
    bindkey '^[z' _fzf_zoxide
fi

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
  ls_cmd='lsd -l --icon=always --color=always'
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
export FZF_ZOXIDE_OPTS="--bind ctrl-/:toggle-preview --preview 'command ${ls_cmd} {}' ${FZF_ZOXIDE_OPTS}"
unset ls_cmd

if (( ${+FZF_DEFAULT_COMMAND} )) export FZF_CTRL_T_COMMAND=${FZF_DEFAULT_COMMAND}

# )))

# Hyfetch (((

(( ${+commands[hyfetch]} )) && () {
    hyfetch -b fastfetch
}

# )))

# vim: set foldenable foldmethod=marker foldlevel=0 foldmarker=(((,))):

