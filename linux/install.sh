#!/usr/bin/env bash

set -euo pipefail

ok() { echo "  [OK] $*"; }

if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

brew install fish zoxide atuin bat git gh mise --quiet
ok "brew packages installed"

command -v zed           &>/dev/null || curl -f https://zed.dev/install.sh | sh
snap list ghostty        &>/dev/null || sudo snap install ghostty --classic
snap list 1password      &>/dev/null || sudo snap install 1password
command -v brave-browser &>/dev/null || curl -fsS https://dl.brave.com/install.sh | sh
ok "apps installed"

if ! fc-list | grep -q "JetBrainsMono"; then
  command -v unzip &>/dev/null || sudo apt install -y unzip
  FONTS_DIR="$HOME/.local/share/fonts"
  mkdir -p "$FONTS_DIR"
  curl -fsSLo "$FONTS_DIR/JetBrainsMono.zip" \
    https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
  unzip -o "$FONTS_DIR/JetBrainsMono.zip" -d "$FONTS_DIR"
  rm "$FONTS_DIR/JetBrainsMono.zip"
  fc-cache -f "$FONTS_DIR"
fi
ok "font installed"
