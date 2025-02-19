set -g fish_greeting

if test -d /home/linuxbrew/.linuxbrew
  eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
else if test -d /opt/homebrew
  eval (/opt/homebrew/bin/brew shellenv)
end

function load_aliases
  if test -f ~/.aliases
    source ~/.aliases
  end
end

function load_nvmrc --on-variable PWD --description 'Auto switch Node.js version'
  if test -f .nvmrc
    fnm use (cat .nvmrc)
  else if test -f .node-version
    fnm use (cat .node-version)
  end
end

load_aliases
load_nvmrc

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

zoxide init fish | source
