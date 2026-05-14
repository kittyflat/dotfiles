#!/bin/sh
DOTFILES="$(cd "$(dirname "$0")" && pwd)"

link() {
  mkdir -p "$(dirname "$2")"
  if [ -e "$2" ] && [ ! -L "$2" ]; then
    mv "$2" "$2.bak"
    echo "  backed up $2 -> $2.bak"
  fi
  ln -snf "$1" "$2"
  echo "  $2 -> $1"
}

echo "Installing Homebrew packages..."
brew bundle --file="$DOTFILES/Brewfile" || echo "⚠️  Some packages failed to install. Check the output above."

if ! gh auth status &>/dev/null; then
  echo "Authenticating with GitHub..."
  gh auth login
fi

echo "Symlinking dotfiles from $DOTFILES..."

# Shell
link "$DOTFILES/.zshrc"                            ~/.zshrc
link "$DOTFILES/.aliases"                          ~/.aliases

# Git
link "$DOTFILES/.gitconfig"                        ~/.gitconfig

# Tools
link "$DOTFILES/nvim"                              ~/.config/nvim
link "$DOTFILES/ghostty/config.ghostty"            ~/.config/ghostty/config.ghostty
link "$DOTFILES/tmux/tmux.conf"                    ~/.config/tmux/tmux.conf

# Write ~/.gitconfig.local with GitHub user info if not already present.
# Uses the noreply email (id+login@users.noreply.github.com) since GitHub's
# email privacy setting hides the real address from the API without extra scopes.
if [ ! -f "$HOME/.gitconfig.local" ]; then
  echo "Setting up ~/.gitconfig.local..."
  GH_NAME=$(gh api user --jq '.name')
  GH_ID=$(gh api user --jq '.id')
  GH_LOGIN=$(gh api user --jq '.login')
  GH_EMAIL="${GH_ID}+${GH_LOGIN}@users.noreply.github.com"
  cat > "$HOME/.gitconfig.local" << EOF
[user]
	name = $GH_NAME
	email = $GH_EMAIL
EOF
  echo "  ~/.gitconfig.local written (name: $GH_NAME, email: $GH_EMAIL)"
else
  echo "  ~/.gitconfig.local already exists, skipping."
fi

echo "Done."
