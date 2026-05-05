#!/bin/sh
DOTFILES="$(cd "$(dirname "$0")" && pwd)"

link() {
  mkdir -p "$(dirname "$2")"
  ln -snf "$1" "$2"
  echo "  $2 -> $1"
}

echo "Symlinking dotfiles from $DOTFILES..."
link "$DOTFILES/nvim"                              ~/.config/nvim
link "$DOTFILES/ghostty/config.ghostty"            ~/.config/ghostty/config.ghostty
link "$DOTFILES/tmux/tmux.conf"                    ~/.config/tmux/tmux.conf
echo "Done."
