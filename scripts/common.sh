#!/usr/bin/env bash

detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "linux"
    else
        echo "unsupported"
    fi
}

install_homebrew() {
    if ! command -v brew &> /dev/null; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        if [[ $OS == "linux" ]]; then
            sudo apt-get install -y build-essential
            eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        else
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
    fi
}

setup_fish() {
    if ! grep -q "$(command -v fish)" /etc/shells; then
        echo "$(command -v fish)" | sudo tee -a /etc/shells
        chsh -s "$(command -v fish)"
    fi

    if ! fish -c "type -q omf"; then
        curl -sSL https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install > install_omf

        fish install_omf --noninteractive
        rm install_omf
    fi

    fish -c "omf install nai"
}

setup_directories() {
    mkdir -p "$HOME/.config/fish/conf.d" "$HOME/.config/kitty" "$HOME/Development"
}

copy_config_files() {
    cp "${1}/.aliases" "$HOME/.aliases"
    cp .config/.gitconfig "$HOME/.gitconfig"
    cp .config/fish/config.fish "$HOME/.config/fish/config.fish"
    cp .config/fish/conf.d/fnm.fish "$HOME/.config/fish/conf.d/fnm.fish"
    cp .config/kitty/kitty.conf "$HOME/.config/kitty/kitty.conf"
}

cleanup_system() {
    if [[ $OS == "linux" ]]; then
        sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt clean
    fi

    brew update && brew upgrade && brew cleanup
}
