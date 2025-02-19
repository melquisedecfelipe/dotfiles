![dotfiles](./assets/icon.png)

# dotfiles

Dotfiles is composed of many configuration files of Linux, macOS, Windows to improve your bootstrap.

- Shell: Fish by default
- Font: JetBrains Mono
- Git: Global settings and SSH keys

# Installation

Clone repo

```bash
git clone https://github.com/melquisedecfelipe/dotfiles
```

And add permission to run scripts:

```bash
chmod +x bootstrap.sh git.sh wsl.sh linux/generate.sh
```

#### macOS and Linux

```bash
./bootstrap.sh
```

If you want to configure Git and SSH, run the following commands:

Create `.env` and set your `GIT_NAME` and `GIT_EMAIL`.

```bash
cp .env.example .env
```

```bash
./git.sh
```

After running you can paste in your [SSH keys](https://github.com/settings/keys).

#### Windows + WSL

For development environment you need to run:

```powershell
.\windows\bootstrap.bat
```

After running the script, restart your computer and run: `./wsl.sh` to complete setup.

#### Ubuntu [autoinstall.yaml](https://canonical-subiquity.readthedocs-hosted.com/en/latest/intro-to-autoinstall.html)

Create `.env` and set your `UBUNTU_PASSWORD`.

```bash
cp .env.example .env
```

```bash
./linux/generate.sh
```

Use this URL in your installation:

```bash
http://localhost:8000/autoinstall.yaml
```

#### Windows [autounattend.xml](https://schneegans.de/windows/unattend-generator)

Create `.env` and set your `WINDOWS_USERNAME`.

```powershell
cp .env.example .env
```

```powershell
.\windows\generate.bat
```

Copy the `autounattend.xml` to your [installation media](https://www.microsoft.com/pt-br/software-download/windows11).

After installing Windows, you can run: `.\windows\bootstrap.bat` (for development setup) or `.\windows\bootstrap.bat game` (for gaming setup).

### Apps

Here the apps that will be installed:

- [Homebrew](https://brew.sh/)
- [Kitty](https://sw.kovidgoyal.net/kitty/)
- [Oh My Fish!](https://github.com/oh-my-fish/oh-my-fish)
- [fnm](https://github.com/Schniz/fnm)
- [VS Code](https://code.visualstudio.com/)
- [Zed](https://zed.dev/)
- [1Password](https://1password.com/)

... and more! Only for MacOS:

- [Arc](https://arc.net/)
- [Raycast](https://www.raycast.com/)

dotfiles created by [Melquisedec Felipe](https://github.com/melquisedecfelipe).
