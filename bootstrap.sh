#!/bin/bash
brew_install() {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew install --quiet gum
}

brew_update() {
  brew update --quiet
  brew install --quiet gum
}

error() {
  log "error" "$1"
}

info() {
  log "info" "$1"
}

fish_configure() {
  install "fish"
  LOCAL=$(brew --prefix)

  if ! fgrep -q "${LOCAL}/bin/fish" /etc/shells; then
    echo "${LOCAL}/bin/fish" | sudo tee -a /etc/shells;
    chsh -s "${LOCAL}/bin/fish";
  fi;

  gum spin --spinner dot --title "Waiting, installing $(style 'oh-my-fish')..." -- curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish

  info "$(style 'oh-my-fish') intalled successfully!"
  warn "Remember to execute ./fish/.omf.sh"
}

git_configure() {
  install "git"

  USERNAME=$(gum input --prompt "Your git $(style 'user.name'): " --value "Melquisedec Felipe")
  EMAIL=$(gum input --prompt "Your git $(style 'user.email'): " --value "melquisedecfelipe@gmail.com")

  git config --global user.name "$USERNAME"
  git config --global user.email "$EMAIL"

  git config --global apply.whitespace fix
  git config --global color.ui auto
  git config --global help.autocorrect 1
  git config --global init.defaultBranch main

  git config --global alias.l "log --pretty=oneline -n 10 --graph --abbrev-commit  --branches --not --remotes"
  git config --global alias.ca "!git add ':(exclude,attr:builtin_objectmode=160000)' && git commit -av"
  git config --global alias.go '!f() { git checkout -b "$1" 2> /dev/null || git checkout "$1"; }; f'
  git config --global alias.aliases "config --get-regexp alias"
  git config --global alias.reb '!r() { git rebase -i HEAD~$1; }; r'
  git config --global alias.rol "reset --soft HEAD~1"
  git config --global alias.dm "!git branch --merged | grep -v '\\*' | xargs -n 1 git branch -d"
  git config --global alias.contributors "shortlog --summary --numbered"
  git config --global alias.whoami "config user.email"

  info "$(style 'git') configured successfully!"
}

install() {
  gum spin --spinner dot --title "Waiting, installing $(style $1)..." -- brew install $1
  info "$(style $1) intalled successfully!"
}

install_all() {
  echo $1 | tr " " "\n" | while read APP
  do
    install "$APP"
  done
}

install_font() {
  gum spin -s dot --title "Waiting, downloading $(style $1)..." -- curl -s -L -o $2 $3
  info "$(style $1) downloaded successfully!"
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
  gum style --foreground 212 "$1"
}

warn() {
  log "warn" "$1"
}

if [[ "$(uname)" == "Linux" ]]; then
  echo "Linux detected, install requirements..."

  if ! command -v brew &> /dev/null; then
    brew_install
  else
    brew_update
  fi
elif [[ "$(uname)" == "Darwin" ]]; then
  echo "macOs detected, install requirements..."

  if ! command -v brew &> /dev/null; then
    brew_install
  else
    brew_update
  fi
else
  echo "Unsupported OS!"
  exit 1
fi

next "Now, you ready! Welcome $(style '.dotfiles')"

git_configure

fish_configure

next "Common Apps"

APPS=$(gum choose --no-limit --header "Select Common apps to install:" -- google-chrome postman slack spotify telegram visual-studio-code warp whatsapp 1password)

if [ -n "$APPS" ]; then
  install_all "$APPS"
else
  warn "You have not selected any options"
fi

if [[ "$(uname)" == "Darwin" ]]; then
  next "MacOS Apps"

  MACOS_APPS=$(gum choose --no-limit --header "Select only macOS apps to install:" -- arc notion-calendar raycast zed)

  if [ -n "$MACOS_APPS" ]; then
    install_all "$MACOS_APPS"
  else
    warn "You have not selected any options"
  fi
fi

next "Assets"

mkdir -p ~/Developer/Fonts
install_font "JetBrains" ~/Developer/Fonts/JetBrainsMono-Regular.ttf https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip

next "$(style 'Very well'), installation completed!"

gum spin --spinner dot --title "Waiting, cleanup..." -- brew cleanup --quiet

info "Cleanup completed!"
warn "Remember to execute .omf.sh"
