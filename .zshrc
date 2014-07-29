# .zshrc

source ~/.zsh.d/zshrc
case ${OSTYPE} in
  darwin*)
    source ~/.zsh.d/zshrc.osx
    ;;
esac

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

# rbenv
export RBENV_ROOT=/usr/local/var/rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
