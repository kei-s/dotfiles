# .zshrc

# DEFAULT EDITOR
export EDITOR=vim
bindkey -e

# PROMPT & RPROMPT
setopt prompt_subst
autoload -Uz colors
colors
autoload -Uz add-zsh-hook
# for rvm
function _precmd_rvm() {
  psvar=()
  [[ -s ~/.rvm/bin/rvm-prompt ]] &&
  [[ "$(~/.rvm/bin/rvm-prompt v)" != "" ]] &&
  psvar[1]="$(~/.rvm/bin/rvm-prompt v)"
}
add-zsh-hook precmd _precmd_rvm
# for vcs_info
function _precmd_vcs_info() {
  LANG=en_US.UTF-8 vcs_info
}
add-zsh-hook precmd _precmd_vcs_info
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats       "%b"    "%s"
zstyle ':vcs_info:*' actionformats "%b|%a" "%s"
function vcs_info_for_git() {
  VCS_GIT_PROMPT="${vcs_info_msg_0_}"
  VCS_GIT_PROMPT_CLEAN="%{${fg[green]}%}"
  VCS_GIT_PROMPT_DIRTY="%{${fg[yellow]}%}"

  VCS_GIT_PROMPT_ADDED="%{${fg[cyan]}%}A%{${reset_color}%}"
  VCS_GIT_PROMPT_MODIFIED="%{${fg[yellow]}%}M%{${reset_color}%}"
  VCS_GIT_PROMPT_DELETED="%{${fg[red]}%}D%{${reset_color}%}"
  VCS_GIT_PROMPT_RENAMED="%{${fg[blue]}%}R%{${reset_color}%}"
  VCS_GIT_PROMPT_UNMERGED="%{${fg[magenta]}%}U%{${reset_color}%}"
  VCS_GIT_PROMPT_UNTRACKED="%{${fg[red]}%}?%{${reset_color}%}"

  INDEX=$(git status --porcelain 2> /dev/null)
  if [[ -z "$INDEX" ]];then
    STATUS="${VCS_GIT_PROMPT_CLEAN}${VCS_GIT_PROMPT}%{${reset_color}%}"
  else
    STATUS=" ${VCS_GIT_PROMPT_DIRTY}${VCS_GIT_PROMPT}%{${reset_color}%}"
    if $(echo "$INDEX" | grep '^UU ' &> /dev/null); then
      STATUS="$VCS_GIT_PROMPT_UNMERGED$STATUS"
    fi
    if $(echo "$INDEX" | grep '^R ' &> /dev/null); then
      STATUS="$VCS_GIT_PROMPT_RENAMED$STATUS"
    fi
    if $(echo "$INDEX" | grep '^ D ' &> /dev/null); then
      STATUS="$VCS_GIT_PROMPT_DELETED$STATUS"
    fi
    if $(echo "$INDEX" | grep '^?? ' &> /dev/null); then
      STATUS="$VCS_GIT_PROMPT_UNTRACKED$STATUS"
    fi
    if $(echo "$INDEX" | grep '^ M ' &> /dev/null); then
      STATUS="$VCS_GIT_PROMPT_MODIFIED$STATUS"
    fi
    if $(echo "$INDEX" | grep '^A ' &> /dev/null); then
      STATUS="$VCS_GIT_PROMPT_ADDED$STATUS"
    elif $(echo "$INDEX" | grep '^M ' &> /dev/null); then
      STATUS="$VCS_GIT_PROMPT_ADDED$STATUS"
    fi
  fi
  echo "${STATUS}"
}
function vcs_info_with_color() {
  VCS_PROMPT_PREFIX="%{${fg[green]}%}[%{${reset_color}%}"
  VCS_PROMPT_SUFFIX="%{${fg[green]}%}]%{${reset_color}%}"

  VCS_NOT_GIT_PROMPT="%{${fg[green]}%}${vcs_info_msg_0_}%{${reset_color}%}"

  if [[ -n "${vcs_info_msg_0_}" ]]; then
    if [[ "${vcs_info_msg_1_}" = "git" ]]; then
      STATUS=$(vcs_info_for_git)
    else
      STATUS=${VCS_NOT_GIT_PROMPT}
    fi
    echo " ${VCS_PROMPT_PREFIX}${STATUS}${VCS_PROMPT_SUFFIX}"
  fi
}
RUBY_PROMPT="%1(v| %U%B%{${fg[magenta]}%}(%1v)%{${reset_color}%}%b%u|)"
PROMPT="[%n@%m]%# "
RPROMPT='[%~]$RUBY_PROMPT$(vcs_info_with_color)'
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

alias g="git"
alias v="vim"

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
compinit -u

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
