#!/bin/sh
DOTFILES="$(cd "$(dirname "$0")" && pwd)"

ln -snf "$DOTFILES/nvim" ~/.config/nvim
mkdir -p ~/.config/ghostty && ln -snf "$DOTFILES/ghostty/config.ghostty" ~/.config/ghostty/config.ghostty
mkdir -p ~/.config/tmux && ln -snf "$DOTFILES/tmux/tmux.conf" ~/.config/tmux/tmux.conf

echo "Done."
