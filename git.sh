#!/usr/bin/env bash

set -euo pipefail

source ./scripts/common.sh

setup_git() {
    [[ ! -f .env ]] && exit 1
    source .env

    if [[ ! -f "$HOME/.ssh/id_ed25519" ]]; then
        git config --global user.name "$GIT_NAME"
        git config --global user.email "$GIT_EMAIL"

        ssh-keygen -t ed25519 -C "$GIT_EMAIL" -f "$HOME/.ssh/id_ed25519" -N "" > /dev/null 2>&1
        eval "$(ssh-agent -s)" > /dev/null 2>&1
        ssh-add "$HOME/.ssh/id_ed25519" > /dev/null 2>&1

        case "$1" in
            "macos") pbcopy < "$HOME/.ssh/id_ed25519.pub" ;;
            "linux") xclip -selection clipboard < "$HOME/.ssh/id_ed25519.pub" ;;
            *) cat "$HOME/.ssh/id_ed25519.pub" ;;
        esac
    else
        cat "$HOME/.ssh/id_ed25519.pub"
    fi
}

OS=$(detect_os)

[[ $OS == "unsupported" ]] && exit 1
[[ $OS == "linux" ]] && ! command -v xclip &> /dev/null && sudo apt install -y xclip

setup_git "$OS"
