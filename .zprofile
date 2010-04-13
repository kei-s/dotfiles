# .zprofile
# User specific environment and startup programs
USERNAME="kei"
PATH=.:$PATH
export USERNAME PATH
export PATH=$PATH:/opt/local/bin:/opt/local/sbin/
export PATH=$PATH:/Developer/SDKs/flex/bin
export MANPATH=/opt/local/man:$MANPATH
export SVN_EDITOR="vim"
export EDITOR="vim"
alias fcd='source ~/tools/fcd/fcd.sh'
