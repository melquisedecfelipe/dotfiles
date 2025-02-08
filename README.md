![dotfiles](./assets/icon.png)

# dotfiles

Dotfiles is composed of many configuration files of Linux, macOS, Windows to improve your bootstrap.

- Shell: Fish by default
- Font: JetBrains Mono Nerd Font
- Git: Global settings
- Terminal: Integration with Windows Terminal in WSL

# Installation

1. Clone repo

```bash
git clone https://github.com/melquisedecfelipe/dotfiles
```

2. Add permission to run commands

```bash
chmod +x bootstrap.sh bootstrap-wsl.sh linux/generate-autoinstall.sh
```

#### macOS e Linux

```bash
./bootstrap.sh
```

#### Windows + WSL

```powershell
.\windows\install-dev.ps1
```

After running the script, restart your computer

#### Ubuntu autoinstall.yaml

Create `.env` and set your password in `PASSWORD`

```bash
cp .env.example .env
```

```bash
./linux/generate-autoinstall.sh
```

Use the URL in your installation

```bash
http://localhost:8000/autoinstall.yaml
```

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
