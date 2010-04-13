# .bashrc

PATH=.:$PATH

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias ls="ls -aFh --color=auto --show-control-chars"
alias la="ls -aF"
alias ll="ls -l"

alias rm="rm -i"
alias rmback="rm *~"
alias cp="cp -i"

alias h="history"
alias x="exit"

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

#for screen
PS1='\033k\033\\[\u@\h \W]\$ '

function share_history {
    history -a
    history -c
    history -r
}
PROMPT_COMMAND='share_history'
shopt -u histappend
export HISTSIZE=9999

# rvm-install added line:
if [[ -s ~/.rvm/scripts/rvm ]] ; then source ~/.rvm/scripts/rvm ; fi

