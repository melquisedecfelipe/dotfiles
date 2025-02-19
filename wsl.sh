#!/usr/bin/env bash

set -euo pipefail

install_homebrew() {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    sudo apt-get install build-essential
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

    brew update
}

install_apps() {
    sudo apt update && sudo apt install -y curl unzip

    brew install fish fnm git oven-sh/bun/bun zoxide --quiet

    if ! grep -q "$(command -v fish)" /etc/shells; then
        echo "$(command -v fish)" | sudo tee -a /etc/shells
    fi
    chsh -s "$(command -v fish)"

    curl -sSL https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install > install_omf
    fish install_omf --noninteractive
    rm install_omf

    fish -c "omf install nai"
}

setup_configs() {
    mkdir -p "$HOME/.config/fish"
    mkdir -p "$HOME/.config/fish/conf.d"
    mkdir -p "$HOME/Development"

    cp .config/.gitconfig "$HOME/.gitconfig"
    cp .config/fish/config.fish "$HOME/.config/fish/config.fish"
    cp .config/fish/conf.d/fnm.fish "$HOME/.config/fish/conf.d/fnm.fish"
    cp linux/.aliases "$HOME/.aliases"
}

cleanup() {
    sudo apt update && sudo apt upgrade -y
    sudo apt autoremove -y && sudo apt clean

    brew update && brew upgrade && brew cleanup
}

main() {
    install_homebrew
    install_apps
    setup_configs
    cleanup
}

main
