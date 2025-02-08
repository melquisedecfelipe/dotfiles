#!/usr/bin/env bash

set -euo pipefail

install_homebrew() {
    if ! command -v brew &> /dev/null; then
        NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi
}

install_common() {
    sudo apt update && sudo apt install -y git curl
    brew install fish

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

install_font() {
    local fonts_dir="$HOME/.local/share/fonts"
    mkdir -p "$fonts_dir"
    curl -fsSLo "$fonts_dir/JetBrains Mono Regular Nerd Font Complete.ttf" \
        https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Regular/complete/JetBrains%20Mono%20Regular%20Nerd%20Font%20Complete.ttf
}

setup_configs() {
    mkdir -p "$HOME/.config/fish"
    mkdir -p "$HOME/Development"

    cp config/.gitconfig "$HOME/.gitconfig"
    cp config/fish/config.fish "$HOME/.config/fish/config.fish"
    cp linux/.aliases "$HOME/.aliases"
}

main() {
    install_homebrew
    brew update --quiet
    install_common
    install_font
    setup_configs
}

main
