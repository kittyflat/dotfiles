# ============================================================
# Key bindings
# ============================================================

# Emacs-style bindings (Ctrl-A/E, Alt-F/B/D, etc.)
bindkey -e

# Alt-Left/Right for word navigation (paired with Ghostty's macos-option-as-alt)
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

# ============================================================
# Shell options
# ============================================================

# Prevent Ctrl-D from closing the shell
setopt ignore_eof

# Stop backward-kill-word on / and _ (bash-style word boundaries)
autoload -U select-word-style
select-word-style bash

# ============================================================
# Environment
# ============================================================

export TERM=xterm-256color
export EDITOR=nvim
export PAGER=less
export CLICOLOR=1

export HISTFILE=~/.histfile
export HISTSIZE=1000
export SAVEHIST=1000

# fzf: search hidden files, exclude .git
export FZF_DEFAULT_COMMAND="rg --files --hidden -g '!.git/**'"

# ============================================================
# PATH
# ============================================================

export PATH="/opt/homebrew/bin:$PATH"
export PATH="$PATH:$HOME/.local/bin"

# ============================================================
# Tool setup
# ============================================================

# asdf
export ASDF_DATA_DIR="$HOME/.asdf"
export PATH="$ASDF_DATA_DIR/shims:$PATH"

# direnv
eval "$(direnv hook zsh)"

# ============================================================
# Aliases
# ============================================================

source "$HOME/.aliases"

# ============================================================
# Utilities
# ============================================================

# Make `fg` work without requiring % prefix (e.g. `fg 1` instead of `fg %1`)
fg() {
  if [[ $# -eq 1 && $1 = - ]]; then
    builtin fg %-
  else
    builtin fg %"$@"
  fi
}

# ============================================================
# Completions
# ============================================================
autoload -Uz compinit && compinit

# ============================================================
# Graphite (gt) tab completion
# https://docs.graphite.dev/guides/graphite-cli/installing-the-cli/shell-completion-setup
# ============================================================
#compdef gt
###-begin-gt-completions-###
#
# yargs command completion script
#
# Installation: gt completion >> ~/.zshrc
#    or gt completion >> ~/.zprofile on OSX.
#
_gt_yargs_completions()
{
  local reply
  local si=$IFS
  IFS=$'
' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" gt --get-yargs-completions "${words[@]}"))
  IFS=$si
  _describe 'values' reply
}
compdef _gt_yargs_completions gt
###-end-gt-completions-###

# ============================================================
# Secrets
# ============================================================
[ -f ~/.secrets ] && source ~/.secrets

# ============================================================
# Local overrides (machine-specific config, etc.)
# ============================================================
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

# ============================================================
# Prompt (last so nothing above overrides it)
# ============================================================
eval "$(starship init zsh)"
