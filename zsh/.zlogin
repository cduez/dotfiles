[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec sway &> ~/.sway.log
