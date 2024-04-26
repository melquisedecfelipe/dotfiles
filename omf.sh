#!/usr/local/bin/fish
omf install nvm nai

function copy
  set file $argv[1]
  set destination $argv[2]

  if test -f "$destination/$file"
    mv "$destination/$file" "$destination/$file.backup"
  end

  cp "$file" "$destination/$file"
end

copy ".aliases" $HOME
copy "./fish/config.fish" "$HOME/.config/fish"
