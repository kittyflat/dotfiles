# Use emacs-style key bindings at command prompt (Ctrl-A/E, Alt-F/B, Alt-D, etc)
# https://stackoverflow.com/questions/18240683/how-to-force-emacs-style-status-keys-in-tmux
# http://matija.suklje.name/zsh-vi-and-emacs-modes
bindkey -e

# Bind Alt-Left/Right to Forward/Backward-word
# https://stackoverflow.com/questions/12382499/looking-for-altleftarrowkey-solution-in-zsh
# Combined with Alacritty binding for Alt-F/B
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

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
