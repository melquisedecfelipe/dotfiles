#!/usr/bin/env bash

set -euo pipefail

detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "linux"
    else
        echo "unsupported"
    fi
}

OS=$(detect_os)

if [[ "$OS" == "linux" ]]; then
    if ! command -v xclip &> /dev/null; then
        sudo apt update && sudo apt install -y xclip
    fi
fi

source .env

if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
    git config --global user.name "$GIT_NAME"
    git config --global user.email "$GIT_EMAIL"

    ssh-keygen -t ed25519 -C "$GIT_EMAIL" -f "$HOME/.ssh/id_ed25519" -N "" > /dev/null 2>&1
    eval "$(ssh-agent -s)" > /dev/null 2>&1
    ssh-add "$HOME/.ssh/id_ed25519" > /dev/null 2>&1

    if [[ "$OS" == "macos" ]]; then
        pbcopy < "$HOME/.ssh/id_ed25519.pub"
    elif [[ "$OS" == "linux" ]]; then
        xclip -selection clipboard < "$HOME/.ssh/id_ed25519.pub"
    else
        cat "$HOME/.ssh/id_ed25519.pub"
    fi
else
    cat "$HOME/.ssh/id_ed25519.pub"
fi
