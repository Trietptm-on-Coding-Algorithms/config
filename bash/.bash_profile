export PATH=$PATH:~/bin:/usr/local/sbin
export PS1="\[\033[38;5;46m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\]:\[$(tput sgr0)\]\[\033[38;5;7m\]\W\[$(tput sgr0)\]\[\033[38;5;15m\]\\$\[$(tput sgr0)\]"

export EDITOR=vim
export VISUAL=$EDITOR

alias lls="ls -la -G"
alias lss="ls -a -G"
alias idaq="wine ~/.wine/drive_c/Program\ Files/IDA\ 6.8/idaq.exe"
alias idaq64="wine ~/.wine/drive_c/Program\ Files/IDA\ 6.8/idaq64.exe"
export PATH="$PATH:/Applications/010 Editor.app/Contents/CmdLine"
