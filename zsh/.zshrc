autoload -U colors && colors
autoload -U compinit promptinit
compinit
promptinit

autoload -Uz vcs_info
setopt prompt_subst
setopt autocd

zstyle ':completion:*' menu select
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats " ● %b "

PROMPT='%n@%m:%B%(5~|%-1~/…/%3~|%4~)%b${vcs_info_msg_0_}%# '

typeset -U path
#path /usr/bin/vendor_perl ~/.cabal/bin $path)
path=($path ~/.rvm/bin ~/.yarn/bin)
#RVM
#export PATH="$PATH:$HOME/.rvm/bin"
#PATH="$HOME/.node_modules/bin:$PATH"


eval $(keychain --eval --quiet id_ed25519 id_ed25519_gh --agents ssh)

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
alias glong='/home/cduez/dev/longboat'
alias lg='/home/cduez/dev/longboat/longboat_app'
alias ce='/home/cduez/dev/longboat/common_engine'
alias et='/home/cduez/dev/longboat/email_templates'
alias lm='/home/cduez/dev/longboat/longboat_mailer'
alias re='/home/cduez/dev/longboat/report_engine'
alias ga='/home/cduez/dev/longboat/gateway_app'
alias at='/home/cduez/dev/longboat/authoring_tool'
alias auth='/home/cduez/dev/longboat/authentication_api'
alias us='/home/cduez/dev/longboat/users_service'
alias api='/home/cduez/dev/longboat/longboat_v2_api'
alias cli='/home/cduez/dev/longboat/longboat_v2_cli'
alias mux="tmuxinator"
alias focus="bundle exec rspec --tag focus"
alias agl="ag --ignore-dir=log --ignore-dir=vendor"
alias be="bundle exec"

export EDITOR=nvim
#export GOPATH=/home/cduez/dev/go
#RVM use GEM_HOME
#export GEM_HOME=$(ruby -e 'puts Gem.user_dir')

export HISTSIZE=100000
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
  xinput disable "DLL07BE:01 06CB:7A13 Touchpad"
}

function ton() {
  xinput enable "DLL07BE:01 06CB:7A13 Touchpad"
}

function don() {
  #xrandr --output DP-1-1-1 --auto --right-of eDP-1-1
  xrandr --output HDMI-1-1 --auto --right-of eDP-1-1
}

function doff() {
  #xrandr --output DP-1-1-1 --off
  xrandr --output HDMI-1-1 --off
}

function keyy() {
  KEYB=$(xinput list --id-only "keyboard:TypeMatrix.com USB Keyboard")
  echo "Set layout us and compose to ralt for xinput id=$KEYB"
  setxkbmap -layout us -option 'compose:ralt' -device $KEYB
}

function loc() {
   sed -i '/common_engine/c\gem "common_engine", path: "../common_engine"' ~/dev/longboat/longboat_app/Gemfile
   pushd ~/dev/longboat/longboat_app
   bundle
   popd
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

source /usr/share/nvm/init-nvm.sh
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
