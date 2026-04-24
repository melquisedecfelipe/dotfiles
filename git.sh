#!/usr/bin/env bash

set -euo pipefail

ok() { echo "  [OK] $*"; }

if [[ $# -ne 2 ]]; then
  echo "Usage: git.sh <name> <email>"
  echo "Example: git.sh \"Melquisedec Felipe\" email@example.com"
  exit 1
fi

git config -f ~/.gitconfig.local user.name "$1"
git config -f ~/.gitconfig.local user.email "$2"
ok "git configured (~/.gitconfig.local)"

if [[ ! -f "$HOME/.ssh/id_ed25519" ]]; then
  ssh-keygen -t ed25519 -C "$2" -f "$HOME/.ssh/id_ed25519" -N "" > /dev/null 2>&1
  eval "$(ssh-agent -s)" > /dev/null 2>&1
  ssh-add "$HOME/.ssh/id_ed25519" > /dev/null 2>&1
fi

echo ""
cat "$HOME/.ssh/id_ed25519.pub"
echo ""
echo "  → add your key at: https://github.com/settings/ssh/new"
