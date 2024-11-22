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
alias kssh='kitten ssh'
type kssh &>/dev/null && compdef _ssh kssh

# )))

# Hyfetch (((

(( ${+commands[hyfetch]} )) && () {
    hyfetch -b fastfetch
}

# )))

# vim: set foldenable foldmethod=marker foldlevel=0 foldmarker=(((,))):

