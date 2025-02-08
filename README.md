![dotfiles](./assets/icon.png)

# dotfiles

Dotfiles is composed of many configuration files of Linux, macOS, Windows to improve your bootstrap.

- Shell: Fish by default
- Font: JetBrains Mono Nerd Font
- Git: Global settings
- Terminal: Integration with Windows Terminal in WSL

# Installation

1. Clone repo `git clone https://github.com/melquisedecfelipe/dotfiles`
2. Add permission to run commands: `chmod +x bootstrap.sh bootstrap-wsl.sh linux/generate-autoinstall.sh`

#### macOS e Linux

1. Run files `./bootstrap.sh`

#### Windows + WSL

1. Run `.\windows\install-dev.psm1` as administrator
2. Restart your computer
3. Open `Ubuntu` and run `./bootstrap-wsl.sh`

#### Ubuntu autoinstall.yaml

1. Copy `.env.example` to `.env`
2. Set your password in `UBUNTU_PASSWORD`
3. Run `./linux/generate-autoinstall.sh`
4. Use the URL `http://localhost:8000/autoinstall.yaml` in your Ubuntu installation

### Apps

Here the apps that will be installed:

- [Homebrew](https://brew.sh/)
- [nvm](https://github.com/derekstavis/plugin-nvm)
- [Oh My Fish!](https://github.com/oh-my-fish/oh-my-fish)
- [VS Code](https://code.visualstudio.com/)
- [Kitty](https://sw.kovidgoyal.net/kitty/)
- [Zed](https://zed.dev/)
- [1Password](https://1password.com/)

... and more! Only for MacOS:

- [Arc](https://arc.net/)
- [Raycast](https://www.raycast.com/)

dotfiles created by [Melquisedec Felipe](https://github.com/melquisedecfelipe).
