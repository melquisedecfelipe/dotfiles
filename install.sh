#!/bin/bash

message() {
  echo -e "\n[INFO] $1"
}

error() {
  echo -e "\n[ERROR] $1"
  exit 1
}

read -p "This script will install and configure tools. Do you want to continue? (y/n): " choice
if [[ ! $choice =~ ^[Yy]$ ]]; then
  message "Script aborted."
  exit 0
fi

message "Installing Homebrew..."
if [[ "$(uname)" == "Darwin" ]]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || error "Failed to install Homebrew."
else
  sudo apt-get update || error "Failed to update apt."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || error "Failed to install Homebrew."
fi

message "Installing fish shell..."
brew install --quiet fish || error "Failed to install fish."
if ! grep -q "/usr/local/bin/fish" /etc/shells; then
  echo "/usr/local/bin/fish" | sudo tee -a /etc/shells || error "Failed to add fish to /etc/shells."
fi
chsh -s /usr/local/bin/fish || error "Failed to set fish as default."

message "Installing Oh My Fish! and plugins (nvm and nai theme)..."
curl -L https://get.oh-my.fish | fish || error "Failed to install oh-my-fish."
omf install nvm nai || error "Failed to install nvm and nai."

message "Installing Homebrew packages and casks..."
brew install --quiet code git google-chrome postman spotify || error "Failed to install packages."
brew install --quiet --cask warp || error "Failed to install casks."
if [[ "$(uname)" == "Darwin" ]]; then
  brew install --quiet --cask raycast zed || error "Failed to install casks on macOS."
fi

message "Configuring Git..."
read -p "Enter your Git username: " git_username
git config --global user.name "$git_username"
read -p "Enter your Git email: " git_email
git config --global user.email "$git_email"

git config --global core.editor "code --wait"

git config --global init.defaultBranch main

git config --global alias.cb "checkout -b"
git config --global alias.ci "commit"
git config --global alias.lg "log --pretty=format:'%Cred%h%Creset %C(bold)%cr%Creset %Cgreen<%an>%Creset %s' --max-count=30"
git config --global alias.rollback "reset --soft HEAD~1"

message "Downloading JetBrains font..."
mkdir -p ~/Developer/Fonts || error "Failed to create font directory."
curl -L -o ~/Developer/Fonts/JetBrainsMono-Regular.ttf https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip || error "Failed to download JetBrains font."
curl -L -o ~/Developer/Fonts/JetBrainsMono-NF-Regular.ttf https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip || error "Failed to download JetBrains font."

message "Installation complete."
exit 0
