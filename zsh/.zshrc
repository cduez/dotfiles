autoload -U colors && colors
autoload -U compinit promptinit
compinit
promptinit

autoload -Uz vcs_info
setopt prompt_subst
setopt autocd

zstyle ':completion:*' menu select
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats " ● %b"


PROMPT='%n@%m:%B%(5~|%-1~/…/%3~|%4~)%b${vcs_info_msg_0_}%# '

typeset -U path
#path /usr/bin/vendor_perl ~/.cabal/bin $path)
path=("$(ruby -e 'puts Gem.user_dir')/bin" ~/dev/go/bin ~/dev/bash/ ~/.cargo/bin $path)

eval $(keychain --eval --quiet id_ed25519 --agents ssh)

bindkey "^R" history-incremental-search-backward
bindkey "^[Od" backward-word
bindkey "^[Oc" forward-word
bindkey "^[Ob" beginning-of-line
bindkey "^[Oa" end-of-line

bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5B" beginning-of-line
bindkey "^[[1;5A" end-of-line

bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

alias ls='ls --color=auto'
alias ll='ls -lh --color=auto'
alias git='LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8 git'
alias gblog='/home/cduez/dev/go/src/github.com/cduez/blog'

export EDITOR=nvim
export GOPATH=/home/cduez/dev/go
export GEM_HOME=$(ruby -e 'puts Gem.user_dir')

export HISTSIZE=50000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

export RIPGREP_CONFIG_PATH=$HOME/.config/ripgrep/rc

setopt hist_ignore_all_dups

vim()
{
  local STTYOPTS="$(stty --save)"
  stty stop '' -ixoff
  command vim "$@"
  stty "$STTYOPTS"
}

function toff() {
  synclient TouchpadOff=1
}

function ton() {
  synclient TouchpadOff=0
}

function don() {
  xrandr --output HDMI1 --auto --left-of LVDS1
}

function doff() {
  xrandr --output HDMI1 --off
}

function keyy() {
  KEYB=$(xinput list --id-only "keyboard:TypeMatrix.com USB Keyboard")
  echo "Set layout us and compose to ralt for xinput id=$KEYB"
  setxkbmap -layout us -option 'compose:ralt' -device $KEYB
}

#------------------------------
# Window title
#------------------------------
case $TERM in
  termite|*xterm*|rxvt|rxvt-unicode|rxvt-256color|rxvt-unicode-256color|(dt|k|E)term)
    precmd () {
      vcs_info
      print -Pn "\e]0;%~\a"
    }
    preexec () { print -Pn "\e]0;%~ ($1)\a" }
    ;;
  screen|screen-256color)
    precmd () {
      vcs_info
      print -Pn "\e]83;title \"$1\"\a"
      print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~]\a"
    }
    preexec () {
      print -Pn "\e]83;title \"$1\"\a"
      print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~] ($1)\a"
    }
    ;;
esac
