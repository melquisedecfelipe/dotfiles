#!/usr/bin/env bash

set -euo pipefail

install_common() {
    sudo apt update && sudo apt install -y git curl fish

    if ! grep -q "$(command -v fish)" /etc/shells; then
        echo "$(command -v fish)" | sudo tee -a /etc/shells
    fi
    chsh -s "$(command -v fish)"

    curl -sSL https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install > install_omf
    fish install_omf --noninteractive
    rm install_omf

    fish -c "omf install nvm nai"

    curl -fsSL https://bun.sh/install | bash
}

setup_configs() {
    mkdir -p "$HOME/.config/fish"
    mkdir -p "$HOME/Development"

    cp config/.gitconfig "$HOME/.gitconfig"
    cp config/fish/config.fish "$HOME/.config/fish/config.fish"
    cp linux/.aliases "$HOME/.aliases"
}

main() {
    install_common
    setup_configs
}

main
