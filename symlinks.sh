#!/usr/bin/env bash
set -e          # stop the script if anything fails

# Where this script lives (i.e. your dotfiles repo root)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p ~/.config   # make sure ~/.config exists

link () {
  local src="$1" dst="$2"

  [ ! -e "$src" ] && return      # if the source isn't there, skip

  rm -rf "$dst"                  # remove whatever is there (file, dir, or link)
  ln -s "$src" "$dst"            # make the new symlink
  echo "linked: $dst → $src"
}

link "$SCRIPT_DIR/alacritty"            ~/.config/alacritty
link "$SCRIPT_DIR/nvim"                 ~/.config/nvim
link "$SCRIPT_DIR/tmux/.tmux.conf"      ~/.tmux.conf
link "$SCRIPT_DIR/zsh/.zshrc"           ~/.zshrc
link "$SCRIPT_DIR/p10k/.p10k.zsh"       ~/.p10k.zsh
