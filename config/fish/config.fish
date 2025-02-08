set -g fish_greeting

set -gx NVM_DIR $HOME/.nvm

if test -d $NVM_DIR
  fish_add_path $NVM_DIR/bin
end

fish_add_path $HOME/.local/bin
fish_add_path $HOME/Development/bin

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

function load_nvm --on-variable PWD --description 'Auto switch node version'
  if test -f .nvmrc
    set NODE (nvm version)
    set NVMRC (nvm version (cat .nvmrc))

    if [ $NVM = "N/A" ]
      nvm install
    else if [ $NVMRC != $NODE ]
      nvm use
    end
  end
end

load_aliases
load_nvm
