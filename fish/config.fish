if status is-interactive
  printf '\eP$f{"hook": "SourcedRcFileForWarp", "value": { "shell": "fish"}}\x9c'
end

alias clean="rm -rf ./node_modules && rm package-lock.json && npm cache clean --force && npm i"
alias dev="git checkout develop && git pull && git fetch --prune"

# Set up nvm
function __check_nvm --on-variable PWD --description 'Do nvm stuff'
  if test -f .nvmrc
    set node_version (nvm version)
    set nvmrc_node_version (nvm version (cat .nvmrc))

    if [ $nvmrc_node_version = "N/A" ]
      nvm install
    else if [ $nvmrc_node_version != $node_version ]
      nvm use
    end
  end
end

__check_nvm
