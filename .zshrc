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
# Prompt
# ============================================================

autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b'
setopt PROMPT_SUBST

PROMPT='[%D{%y/%m/%f} %D{%L:%M:%S}] %n@%m %(3~|%2~|%~) $ '
RPROMPT=\$vcs_info_msg_0_

# ============================================================
# Environment
# ============================================================

export TERM=xterm-256color
export EDITOR=vim
export PAGER=less
export CLICOLOR=1

export HISTFILE=~/.histfile
export HISTSIZE=1000
export SAVEHIST=1000

# fzf: search hidden files, exclude .git
export FZF_DEFAULT_COMMAND="rg --files --hidden -g '!.git/**'"

# ============================================================
# Tool setup
# ============================================================

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

# pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

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
# Local overrides
# Machine-specific config, secrets, tool completions (e.g. gt, aws, etc.)
# ============================================================
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
