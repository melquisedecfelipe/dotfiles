set -g fish_greeting

mkdir -p ~/.cache/fish

# Brew - cached to avoid slow startup
if test -d /home/linuxbrew/.linuxbrew
  set -l brew_bin /home/linuxbrew/.linuxbrew/bin/brew
else if test -d /opt/homebrew
  set -l brew_bin /opt/homebrew/bin/brew
end

if set -q brew_bin
  set -l brew_env ~/.cache/fish/brew_env.fish
  if not test -f $brew_env
    $brew_bin shellenv fish > $brew_env
  end
  source $brew_env
end

# Aliases
if test -f ~/.aliases
  source ~/.aliases
end

# Zoxide (smarter cd)
set -l zoxide_init ~/.cache/fish/zoxide_init.fish
if not test -f $zoxide_init
  zoxide init fish > $zoxide_init
end
source $zoxide_init

# Atuin (shell history)
set -l atuin_init ~/.cache/fish/atuin_init.fish
if not test -f $atuin_init
  atuin init fish > $atuin_init
end
source $atuin_init
