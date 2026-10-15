# Queued-command sessions: keep startup minimal. {{{
#
# Sourced as the very first thing from ~/.zshrc, before anything else touches the
# tty.
#
# Apps that open Terminal.app with a command (AppleScript `do script`, e.g.
# MeshClawHub) have that command written into the tty while this file is still
# running. Full zim startup takes ~1.8s, long enough for the command to be lost.
# If input is already pending when we start, skip zim and let the queued command
# run immediately. zselect only *polls* fd 0, so the pending bytes are left in
# the buffer for zle to read.
#
# Interactive sessions (nothing typed yet) fall through to the full setup.
# Set ZIM_FULL=1 to force the full setup, ZSHRC_QUEUED_INPUT_WAIT to change the
# poll window (centiseconds).
#
# ZSHRC_MINIMAL is the handshake with 10-zshrc.zsh: `return` here only leaves
# this file, so the main fragment checks the flag and returns immediately too.
if [[ -o interactive && -t 0 && -z ${ZIM_FULL} ]]; then
  zmodload -F zsh/zselect b:zselect 2>/dev/null
  if (( ${+builtins[zselect]} )) && \
      zselect -A _zshrc_ready -t ${ZSHRC_QUEUED_INPUT_WAIT:-20} -r 0 2>/dev/null; then
    unset _zshrc_ready
    typeset -g ZSHRC_MINIMAL=1
    PS1='%~ %# '
    export PATH="$HOME/.bin:$PATH"
    export LC_ALL=en_US.UTF-8
    export LANG=en_US.UTF-8
    export LANGUAGE=en_US.UTF-8
    if [[ -r "$HOME/.zshrc.host" ]] ; then
        source "$HOME/.zshrc.host"
    fi
    return
  fi
  unset _zshrc_ready
fi
# }}}

# vim: set foldenable foldmethod=marker foldlevel=0:
