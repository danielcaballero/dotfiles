#!/usr/bin/env bash
# Clone required Oh‑My‑Zsh plugins if they are absent.
set -euo pipefail

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
mkdir -p "$ZSH_CUSTOM/plugins"

# name | git‑URL
plugins=(
  "zsh-autosuggestions|https://github.com/zsh-users/zsh-autosuggestions.git"
  "zsh-syntax-highlighting|https://github.com/zsh-users/zsh-syntax-highlighting.git"
)

for entry in "${plugins[@]}"; do
  name=${entry%%|*}
  url=${entry##*|}

  dest="$ZSH_CUSTOM/plugins/$name"
  if [[ ! -d "$dest/.git" ]]; then
    echo "→ cloning $name"
    git clone --depth=1 "$url" "$dest"
  else
    echo "✓ $name already present"
  fi
done

