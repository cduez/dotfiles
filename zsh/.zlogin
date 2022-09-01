[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec sway &> ~/.sway.log
#[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx -- -keeptty &> ~/.xorg.log
