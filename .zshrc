# Use emacs-style key bindings at command prompt (Ctrl-A/E, Alt-F/B, Alt-D, etc)
# https://stackoverflow.com/questions/18240683/how-to-force-emacs-style-status-keys-in-tmux
# http://matija.suklje.name/zsh-vi-and-emacs-modes
bindkey -e

# Bind Alt-Left/Right to Forward/Backward-word
# https://stackoverflow.com/questions/12382499/looking-for-altleftarrowkey-solution-in-zsh
# Combined with Alacritty binding for Alt-F/B
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

# Ignore ctrl-d
# https://zsh.sourceforge.io/Doc/Release/Options.html
# https://superuser.com/a/1309966
setopt ignore_eof

# Use bash manner of moving/editing words, only alphanumeric characters are
# considered word characters (i.e. stop backward-kill-word on / and _ characters)
# https://stackoverflow.com/questions/444951/zsh-stop-backward-kill-word-on-directory-delimiter
# https://zsh.sourceforge.io/Doc/Release/User-Contributions.html#Widgets
autoload -U select-word-style
select-word-style bash

# Prompt
# https://www.themoderncoder.com/add-git-branch-information-to-your-zsh-prompt/
#
# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '%b'

# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
# https://unix.stackexchange.com/questions/273529/shorten-path-in-zsh-prompt
PROMPT='[%D{%y/%m/%f} %D{%L:%M:%S}] %n@%m %(3~|%2~|%~) $ '
RPROMPT=\$vcs_info_msg_0_

# Make fg work like in bash (without requiring %)
# https://stackoverflow.com/questions/32614648/weird-jobs-behavior-within-zsh
fg() {
    if [[ $# -eq 1 && $1 = - ]]; then
        builtin fg %-
    else
        builtin fg %"$@"
    fi
}

source ~/.bash_profile

export PATH="/usr/local/opt/postgresql@10/bin:$PATH"

# Load local config if exists
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
