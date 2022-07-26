# .zshenv
source ~/.zsh.d/zshenv
if [ -e ~/.zsh.d/zshenv.local ]; then
  source ~/.zsh.d/zshenv.local
fi

USERNAME="kei"
export USERNAME
export NODE_PATH=/usr/local/lib/node_modules
export GOPATH=$HOME
export PATH=$PATH:$GOPATH/bin
export PATH="$HOME/.rbenv/bin:$PATH"

export LC_COLLATE=C
export LC_CTYPE=ja_JP.UTF-8
export LC_MESSAGES=C
export LC_MONETARY=C
export LC_NUMERIC=C
export LC_TIME=C
. "$HOME/.cargo/env"
