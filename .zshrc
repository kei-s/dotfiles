# .zshrc

source ~/.zsh.d/zshrc

## below are old settings
#case "${OSTYPE}" in
  #freebsd*|darwin*)
  #alias ls="ls -aFhG"
  #;;
  #linux*)
  #alias ls="ls -aFh --color=auto --show-control-chars"
  #;;
#esac
#alias la="ls -aF"
#alias ll="ls -l"

#alias w3m="w3m -no-mouse"

# History
#function history-all { history -E 1 }

#setopt auto_list

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
