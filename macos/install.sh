#!/usr/bin/env bash

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

ok() { echo "  [OK] $*"; }
symlink() {
  local src="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  [[ -e "$dst" && ! -L "$dst" ]] && mv "$dst" "$dst.bak"
  ln -sf "$src" "$dst"
}

if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew bundle --file="$DOTFILES/Brewfile" --quiet
ok "brew packages installed"

symlink "$DOTFILES/macos/.aliases" "$HOME/.aliases"
