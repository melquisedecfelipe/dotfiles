#!/usr/bin/env bash

set -euo pipefail

source ./scripts/common.sh

install_apps() {
    sudo apt update && sudo apt install -y curl unzip

    brew install fish fnm git oven-sh/bun/bun zoxide --quiet
}

main() {
    OS="linux"

    install_homebrew
    install_apps
    setup_directories
    setup_fish
    copy_config_files "$OS"
    cleanup_system
}

main
