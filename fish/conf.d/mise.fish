mkdir -p ~/.cache/fish
set -l mise_init ~/.cache/fish/mise_init.fish
if not test -f $mise_init
    mise activate fish > $mise_init
end
source $mise_init
