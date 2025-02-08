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
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    if [[ $OS == "linux" ]]; then
        sudo apt-get install build-essential
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    elif [[ $OS == "macos" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    brew update
}

install_linux() {
    sudo apt update && sudo apt install -y unzip
    sudo apt install -y kitty
    sudo snap install code --classic
    sudo snap install postman
    sudo snap install 1password

    curl -f https://zed.dev/install.sh | sh
}

install_macos() {
    brew install --cask --quiet \
        google-chrome \
        postman \
        visual-studio-code \
        zed \
        cursor \
        kitty \
        1password \
        raycast \
        arc
}

install_apps() {
    brew install fish git

    if [[ $OS == "linux" ]]; then
        install_linux
    fi

    if [[ $OS == "macos" ]]; then
        install_macos
    fi

    if ! grep -q "$(command -v fish)" /etc/shells; then
        echo "$(command -v fish)" | sudo tee -a /etc/shells
    fi
    chsh -s "$(command -v fish)"

    curl -sSL https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install > install_omf
    fish install_omf --noninteractive
    rm install_omf

    fish -c "omf install nvm nai pyenv"

    curl -fsSL https://bun.sh/install | bash
}

install_font() {
    local fonts_dir
    if [[ $OS == "macos" ]]; then
        fonts_dir="$HOME/Library/Fonts"
    else
        fonts_dir="$HOME/.local/share/fonts"
    fi

    mkdir -p "$fonts_dir"
    curl -fsSLo "$fonts_dir/JetBrainsMono.zip" \
        https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
    unzip -o "$fonts_dir/JetBrainsMono.zip" -d "$fonts_dir"
    rm "$fonts_dir/JetBrainsMono.zip"
}

setup_configs() {
    mkdir -p "$HOME/.config/fish"
    mkdir -p "$HOME/Development"

    cp config/.gitconfig "$HOME/.gitconfig"
    cp config/fish/config.fish "$HOME/.config/fish/config.fish"
    cp "${OS}/.aliases" "$HOME/.aliases"
}

cleanup() {
    if [[ $OS == "linux" ]]; then
        sudo apt update && sudo apt upgrade -y
        sudo apt autoremove -y && sudo apt clean
    fi

    brew update && brew upgrade && brew cleanup
}

main() {
    [[ $OS == "unsupported" ]] && exit 1

    install_homebrew
    install_apps
    install_font
    setup_configs
    cleanup
}

main
