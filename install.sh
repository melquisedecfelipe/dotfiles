#!/bin/bash
brew_install() {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew install --quiet gum
}

download() {
  gum spin -s dot --title "Waiting, downloading $(style $1)..." -- curl -s -L -o $2 $3
  info "$(style $1) downloaded successfully!"
}

error() {
  log "error" "$1"
}

info() {
  log "info" "$1"
}

fish_configure() {
  if ! grep -q "/usr/local/bin/fish" /etc/shells; then
    echo "/usr/local/bin/fish" | sudo tee -a /etc/shells || error "Failed to add fish to /etc/shells"
  fi
  chsh -s /usr/local/bin/fish || error "Failed to set fish as default"
}

git_configure() {
  USERNAME=$(gum input --prompt "Your git $(style 'user.name'): " --value "Melquisedec Felipe")
  EMAIL=$(gum input --prompt "Your git $(style 'user.email'): " --value "melquisedecfelipe@gmail.com")

  git config --global user.name "$USERNAME"
  git config --global user.email "$EMAIL"

  git config --global core.editor "code --wait"

  git config --global init.defaultBranch main

  git config --global alias.cb "checkout -b"
  git config --global alias.ci "commit -m"
  git config --global alias.de "branch -D"
  git config --global alias.lg "log --pretty=format:'%Cred%h%Creset %C(bold)%cr%Creset %Cgreen<%an>%Creset %s' --max-count=5"
  git config --global alias.rollback "reset --soft HEAD~1"

  info "$(style 'git') configured successfully!"
}

install() {
  gum spin --spinner dot --title "Waiting, installing $(style $1)..." -- brew install "$1"
  info "$(style $1) intalled successfully!"
}

install_all() {
  echo $1 | tr " " "\n" | while read APP
  do
    install $APP
  done
}

log() {
  gum log --time TimeOnly --level $1 ": $2"
}

next() {
  sleep 1
  clear
  echo "$(style ".dotfiles") next step"
  gum style \
    --align center --border normal --border-foreground 212 \
    --margin "1" --padding "1 2" --width 40 "$1"
}

style() {
  gum style --foreground 212 $1
}

warn() {
  log "warn" "$1"
}

if [[ "$(uname)" == "Linux" ]]; then
  echo "Linux detected, install requirements..."

  if ! command -v brew &> /dev/null; then
    brew_install
  fi
elif [[ "$(uname)" == "Darwin" ]]; then
  echo "macOs detected, install requirements..."

  if ! command -v brew &> /dev/null; then
    brew_install
  fi
else
  echo "Unsupported OS!"
  exit 1
fi

next "Now, you ready! Welcome $(style '.dotfiles')"

install "git"
git_configure

install "fish"
fish_configure

gum spin -s line --title "Install $(style 'Oh-My-Fish')..." -- curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish

omf install nvm nai || error "Failed to install nvm and nai theme"

info "$(style 'Oh-My-Fish') intalled successfully!"

next "Common Apps"

APPS=$(gum choose --no-limit --header "Select Common apps to install:" -- docker google-chrome postman slack spotify telegram visual-studio-code warp whatsapp 1password)

if [ -n "$APPS" ]; then
  install_all $APPS
else
  warn "You have not selected any options"
fi

if [[ "$(uname)" == "Darwin" ]]; then
  next "MacOS Apps"

  MACOS_APPS=$(gum choose --no-limit --header "Select only macOS apps to install:" -- arc notion-calendar raycast zed)

  if [ -n "$MACOS_APPS" ]; then
    install_all $MACOS_APPS
  else
    warn "You have not selected any options"
  fi
fi

next "Assets"

mkdir -p ~/Developer/Fonts
download "JetBrains" ~/Developer/Fonts/JetBrainsMono-Regular.ttf https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip

echo ""
echo "Very well, installation $(style 'completed')!"
