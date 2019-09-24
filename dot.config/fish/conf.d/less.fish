# source-highlight
set -x LESS -R
set -x LESSOPEN '| /usr/local/bin/src-hilite-lesspipe.sh %s'
