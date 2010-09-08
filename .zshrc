# .zshrc

# DEFAULT EDITOR
export EDITOR=vim
bindkey -e

# PROMPT & RPROMPT
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
precmd() {
  psvar=()

  # for vcs_info
  LANG=en_US.UTF-8 vcs_info
  [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"

  # for rvm
  [[ -s ~/.rvm/bin/rvm-prompt ]] &&
  [[ "$(~/.rvm/bin/rvm-prompt v)" != "" ]] &&
  psvar[2]="$(~/.rvm/bin/rvm-prompt v)"
}
VCS_PROMPT="%1(v|%F{green} %1v%f|)"
RUBY_PROMPT="%2(v| %U%B%F{magenta}(%2v)%f%b%u|)"
PROMPT="[%n@%m]%# "
RPROMPT="[%~]$RUBY_PROMPT$VCS_PROMPT"
#SPROMPT=""

# forbid C-s
stty stop undef

# keymap

bindkey "^?"    backward-delete-char
bindkey "^H"    backward-delete-char
bindkey '^@'    backward-delete-char
bindkey "^[[3~" backward-delete-char
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

# Auto cd
setopt auto_cd
setopt auto_pushd

# Inform Correct Command
setopt correct

# Small Complete
setopt list_packed

# User specific aliases and functions
setopt complete_aliases

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

case "${OSTYPE}" in
  freebsd*|darwin*)
  alias ls="ls -aFhG"
  ;;
  linux*)
  alias ls="ls -aFh --color=auto --show-control-chars"
  ;;
esac
alias la="ls -aF"
alias ll="ls -l"

alias rm="rm -i"
alias rmback="rm *~;rm .*~;rm *.bak"

alias cp="cp -i"

alias h="history"
alias x="exit"

alias w3m="w3m -no-mouse"

# History

HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=100000
setopt extended_history
setopt auto_pushd
function history-all { history -E 1 }

setopt share_history
setopt auto_list

# Auto Complete

autoload -U compinit
compinit

# screen

if [ "$TERM" = "screen" -o "$TERM" = "screen-bce" ]; then
	chpwd () { echo -n "_`dirs`\\" }
	preexec() {
		emulate -L zsh
		local -a cmd; cmd=(${(z)2})
		case $cmd[1] in
			fg)
				if (( $#cmd == 1 )); then
					cmd=(builtin jobs -l %+)
				else
					cmd=(builtin jobs -l $cmd[2])
				fi
				;;
			%*)
				cmd=(builtin jobs -l $cmd[1])
				;;
			cd)
				if (( $#cmd == 2 )); then
					cmd[1]=$cmd[2]
				fi
				;&
			*)
				echo -n "k$cmd[1]:t\\"
				return
				;;
		esac

		local -A jt; jt=(${(kv)jobtexts})

		$cmd >>(read num rest
			cmd=(${(z)${(e):-\$jt$num}})
			echo -n "k$cmd[1]:t\\") 2>/dev/null
	}
	chpwd
fi

#function ssh_screen(){
#  eval server=\${$#}
#  screen -t $server ssh "$@"
#}
#if [ x$TERM = xscreen ]; then
#  alias ssh=ssh_screen
#fi

# rvm-install added line:
if [[ -s ~/.rvm/scripts/rvm ]] ; then source ~/.rvm/scripts/rvm ; fi

