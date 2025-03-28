#!/usr/bin/env bash

set -euo pipefail

source ./scripts/common.sh

install_apps() {
    brew install fish fnm git oven-sh/bun/bun zoxide --quiet

    if [[ $OS == "linux" ]]; then
        sudo apt update && sudo apt install -y kitty unzip
        sudo snap install 1password
        sudo snap install code --classic
        sudo snap install postman

        curl -fsS https://dl.brave.com/install.sh | sh
        curl -f https://zed.dev/install.sh | sh
    fi

    if [[ $OS == "macos" ]]; then
        local apps=(
            "1password"
            "brave-browser"
            "google-chrome"
            "kitty"
            "postman"
            "raycast"
            "visual-studio-code"
            "zed"
        )

        for app in "${apps[@]}"; do
            brew list --cask "$app" &>/dev/null || \
            brew install --cask --quiet "$app"
        done
    fi
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

main() {
    OS=$(detect_os)

    [[ $OS == "unsupported" ]] && exit 1

    install_homebrew
    install_apps
    install_font
    setup_directories
    setup_fish
    copy_config_files "$OS"
    cleanup_system
}

main
