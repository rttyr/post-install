alias grep='grep --color=auto'
alias ls='ls --color=auto'

unset HISTFILE

[[ $- != *i* ]] && return

if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
    sway --unsupported-gpu
fi
