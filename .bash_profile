export EDITOR=vim
# export PATH=/usr/local/bin:$PATH
# export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
# export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"
# for pg modeler
# export PATH="/usr/local/opt/qt/bin:$PATH"

export HISTFILE=~/.histfile
export HISTSIZE=1000
export SAVEHIST=1000
export PAGER="less"
export EDITOR="vim"
export CLICOLOR=1
# eval $(gdircolors ~/.dir_colors)

# Postgres $PATH
# export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin

source $HOME/.aliases

# nvm
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# avn
# [[ -s "$HOME/.avn/bin/avn.sh" ]] && source "$HOME/.avn/bin/avn.sh" # load avn

# git bash completion (from brew)
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# git _completion_loader
__git_complete g  _git
# __git_complete gb _git_branch
# __git_complete gc _git_checkout
# __git_complete gd _git_diff
# __git_complete gl _git_log
# __git_complete gp _git_push
# __git_complete gs _git_status