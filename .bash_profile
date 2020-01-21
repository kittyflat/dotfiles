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

# brew install git bash completion
# https://stackoverflow.com/questions/14970728/homebrew-s-git-not-using-completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# git _completion_loader
__git_complete g  _git
# __git_complete gb _git_branch
# __git_complete gc _git_checkout
# __git_complete gd _git_diff
# __git_complete gl _git_log
# __git_complete gp _git_push
# __git_complete gs _git_status

# Add Git branch name to terminal prompt (osx)
# https://gist.github.com/joseluisq/1e96c54fa4e1e5647940
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

parse_git_handle() {
  git remote get-url origin 2> /dev/null | sed -e 's/.*:\(.*\)\/.*\.git/\1/'
}

parse_git_repo() {
  git remote get-url origin 2> /dev/null | sed -e 's/.*:.*\/\(.*\)\.git/\1/'
}

parse_git() {
  # local git_handle="$(parse_git_handle)"
  local git_repo="$(parse_git_repo)"
  local git_branch="$(parse_git_branch)"

  # [[ ! -z "$git_handle" && ! -z "$git_repo" && ! -z "$git_branch" ]] && echo " ($git_handle/$git_repo@$git_branch)"
  # [[ ! -z "$git_repo" && ! -z "$git_branch" ]] && echo " ($git_repo@$git_branch)"
  [[ ! -z "$git_branch" ]] && echo " ($git_branch)"
}

export PS1="\u@\h \W\[\033[32m\]\$(parse_git)\[\033[00m\] $ "

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/dd/Downloads/google-cloud-sdk/path.bash.inc' ]; then . '/Users/dd/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/dd/Downloads/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/dd/Downloads/google-cloud-sdk/completion.bash.inc'; fi

# chruby
[ -s "/usr/local/opt/chruby/share/chruby/chruby.sh" ] && source /usr/local/opt/chruby/share/chruby/chruby.sh
[ -s "/usr/local/share/chruby/auto.sh" ] && source /usr/local/share/chruby/auto.sh

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# avn
# [[ -s "$HOME/.avn/bin/avn.sh" ]] && source "$HOME/.avn/bin/avn.sh" # load avn

# pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

eval $(thefuck --alias)
