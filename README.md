# dotfiles

## Prerequisites

- [Homebrew](https://brew.sh)

## Setup

```sh
git clone https://github.com/kittyflat/dotfiles.git
cd dotfiles && ./setup.sh
```

`setup.sh` will:

1. Install Homebrew packages via `Brewfile`
2. Symlink configs:
   - `~/.zshrc`, `~/.aliases`
   - `~/.gitconfig`
   - `~/.config/nvim`
   - `~/.config/ghostty/config.ghostty`
   - `~/.config/tmux/tmux.conf`
3. Create `~/.gitconfig.local` with your GitHub name and email (skipped if it already exists)
