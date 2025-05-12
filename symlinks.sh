#!/usr/bin/env bash
# Symlink all dotfiles into the home directory and install Zsh plugins.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p ~/.config   # ensure XDG config dir exists

link() {
  local src="$1" dst="$2"
  [[ -e "$src" ]] || return             # skip if source missing
  rm -rf "$dst"                          # remove old file/dir/link
  ln -s "$src" "$dst"
  echo "linked: $dst → $src"
}

link "$SCRIPT_DIR/alacritty"            ~/.config/alacritty
link "$SCRIPT_DIR/nvim"                 ~/.config/nvim
link "$SCRIPT_DIR/tmux/.tmux.conf"      ~/.tmux.conf
link "$SCRIPT_DIR/zsh/.zshrc"           ~/.zshrc
link "$SCRIPT_DIR/p10k/.p10k.zsh"       ~/.p10k.zsh

# ---------------------------------------------------------------------------
# Install required Zsh plugins (runs only if missing)
# ---------------------------------------------------------------------------
bash "$SCRIPT_DIR/zsh/install-plugins.sh"

