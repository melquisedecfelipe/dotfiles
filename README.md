![dotfiles](./assets/icon.png)

# dotfiles

Personal dotfiles for macOS and Linux (development) and Windows (gaming).

- Shell: Fish + Oh My Fish (nai theme)
- Font: JetBrains Mono Nerd Font
- Editor: Zed
- Terminal: Ghostty

## macOS / Linux

```bash
./install.sh
./git.sh "Your Name" <mail>
```

> `git.sh` writes your name and email to `~/.gitconfig.local`, which is included by `git/.gitconfig` and never committed. See `git/.gitconfig.local.example` for other per-machine overrides.

## Clean install

### Ubuntu

Generate the `autoinstall.yaml` and serve it locally:

```bash
./linux/generate.sh <username> "Real Name" <password>
```

Use the following URL in the Ubuntu installer: [http://localhost:8000/autoinstall.yaml](http://localhost:8000/autoinstall.yaml)

### Windows

Windows is configured for gaming only. Generate `autounattend.xml` and copy it to your [installation media](https://www.microsoft.com/software-download/windows11):

```bat
.\windows\generate.bat <username>
```

Download the [Ninite](https://ninite.com) installer with your selected apps and place it on the installation media alongside `autounattend.xml`. It will run automatically on first login.

dotfiles by [Melquisedec Felipe](https://github.com/melquisedecfelipe).
