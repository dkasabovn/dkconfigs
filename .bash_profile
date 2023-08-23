#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
. "$HOME/.cargo/env"
[ -z "$DISPLAY" ] && [ $XDG_VTNR -eq 1 ] && exec startx
