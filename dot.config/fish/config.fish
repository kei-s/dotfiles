# Added by Krypton
set -x GPG_TTY (tty)

direnv hook fish | source
eval (starship init fish)
