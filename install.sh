#!/bin/bash

# Install Homebrew on macOS and Linux
if [[ "$(uname)" == "Darwin" ]]; then
  if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
else
  if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  sudo apt-get update
fi

# Install Fish shell and set as default
brew install --quiet fish

if ! grep -q "/usr/local/bin/fish" /etc/shells; then
  echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
fi
chsh -s /usr/local/bin/fish

# Install oh-my-fish and plugins
curl -L https://get.oh-my.fish | fish
omf install nvm nai

# Install Homebrew packages and casks
brew install --quiet code git google-chrome postman spotify
brew install --quiet --cask warp

# Install Homebrew casks only on macOS
if [[ "$(uname)" == "Darwin" ]]; then
  brew install --quiet --cask raycast zed
fi

# Configure Git
read -p "Digite o seu nome de usuário do Git: " git_username
git config --global user.name "$git_username"
read -p "Digite o seu email do Git: " git_email
git config --global user.email "$git_email"

git config --global alias.cb "checkout -b"
git config --global alias.ci "commit"
git config --global alias.lg "log --pretty=format:'%Cred%h%Creset %C(bold)%cr%Creset %Cgreen<%an>%Creset %s' --max-count=30"
git config --global alias.rollback "reset --soft HEAD~1"

# Download JetBrains font
mkdir -p ~/Developer/Fonts
curl -L -o ~/Developer/Fonts/JetBrainsMono-Regular.ttf https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
curl -L -o ~/Developer/Fonts/JetBrainsMono-NF-Regular.ttf https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
