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

install_homebrew() {
    if ! command -v brew &> /dev/null; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" < /dev/null

        if [[ $OS == "linux" ]]; then
            eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        elif [[ $OS == "macos" ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
    fi
}

install_common() {
    brew install fish git \
        && brew install --cask --quiet \
            google-chrome \
            postman \
            visual-studio-code \
            zed \
            cursor \
            kitty \
            1password

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

install_macos_apps() {
    brew install --cask --quiet raycast arc
}

install_font() {
    local fonts_dir
    if [[ $OS == "macos" ]]; then
        fonts_dir="$HOME/Library/Fonts"
    else
        fonts_dir="$HOME/.local/share/fonts"
    fi

    mkdir -p "$fonts_dir"
    curl -fsSLo "$fonts_dir/JetBrains Mono Regular Nerd Font Complete.ttf" \
        https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Regular/complete/JetBrains%20Mono%20Regular%20Nerd%20Font%20Complete.ttf
}

setup_configs() {
    mkdir -p "$HOME/.config/fish"
    mkdir -p "$HOME/Development"

    cp config/.gitconfig "$HOME/.gitconfig"
    cp config/fish/config.fish "$HOME/.config/fish/config.fish"
    cp "${OS}/.aliases" "$HOME/.aliases"
}

main() {
    [[ $OS == "unsupported" ]] && exit 1

    install_homebrew
    brew update --quiet
    install_common
    [[ $OS == "macos" ]] && install_macos_apps
    install_font
    setup_configs
}

main
