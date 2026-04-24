#!/usr/bin/env bash

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ok() { echo "  [OK] $*"; }

symlink() {
  local src="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  [[ -e "$dst" && ! -L "$dst" ]] && mv "$dst" "$dst.bak"
  ln -sf "$src" "$dst"
}

# ── Platform
if [[ "$OSTYPE" == "darwin"* ]]; then
  bash "$DOTFILES/macos/install.sh"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  bash "$DOTFILES/linux/install.sh"
else
  echo "Unsupported OS" && exit 1
fi

# ── Fish
if ! grep -q "$(command -v fish)" /etc/shells; then
  echo "$(command -v fish)" | sudo tee -a /etc/shells
  chsh -s "$(command -v fish)"
fi
if ! fish -c "type -q omf" &>/dev/null; then
  curl -sSL https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install > /tmp/install_omf
  fish /tmp/install_omf --noninteractive
  rm /tmp/install_omf
  fish -c "omf install nai"
fi
ok "fish configured"

# ── Symlinks
symlink "$DOTFILES/git/.gitconfig"    "$HOME/.gitconfig"
symlink "$DOTFILES/fish/config.fish"         "$HOME/.config/fish/config.fish"
symlink "$DOTFILES/fish/conf.d/mise.fish"    "$HOME/.config/fish/conf.d/mise.fish"
symlink "$DOTFILES/zed/settings.json" "$HOME/.config/zed/settings.json"
symlink "$DOTFILES/ghostty/config.ghostty"    "$HOME/.config/ghostty/config.ghostty"
ok "configs linked"

echo ""
ok "done! open a new shell to apply changes."
echo "  → run: ./git.sh \"Your Name\" email@example.com"
