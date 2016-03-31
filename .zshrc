#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

export PATH=$PATH:/Users/thalfpop/bin:/usr/local/sbin

export SUBLIME=subl
export EDITOR="$SUBLIME --wait"
export VISUAL=$EDITOR

alias idaq="wine /Users/thalfpop/.wine/drive_c/Program\ Files/IDA\ 6.8/idaq.exe"
alias idaq64="wine /Users/thalfpop/.wine/drive_c/Program\ Files/IDA\ 6.8/idaq64.exe"
export PATH="$PATH:/Applications/010 Editor.app/Contents/CmdLine"
