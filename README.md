# Dotfiles

This repo contains my dotfiles and all the configurations I use on my computers.
Here we have the configuration for Mac and Arch linux.

In the Cross-platform we will have some common tools and tools/apps/configuration specific to each OS

# Table of Contents
- [Dotfiles](#dotfiles)
- [Table of Contents](#table-of-contents)
  - [📦 Structure](#-structure)
  - [🚀 Installation](#-installation)
- [On Arch](#on-arch)
    - [Linux](#linux)
- [FOR Linux](#for-linux)

## 📦 Structure
```
~/.dotfiles
├── dotfiles
├── install/
    ├── os/
    │   ├── mac/
    │   ├── arch/
```
---

## 🚀 Installation

Clone the repo into `~/dev`:

# On Arch
```bash
mkdir -p ~/dev/cm
git clone https://github.com/cesmunoz/dotfiles.git ~/dev/cm/dotfiles
cd ~/dev/cm/dotfiles
sudo ./install.sh
```

The installer will:

- Detect the operating system (macOS or Arch Linux)
- Ensure gum and other dependencies are installed (depending on the os)
- Install a small set of core tools (zsh, neovim, etc).
- Stow the dotfiles into $HOME
- Apply OS-specific steps:
  - macOS
  - Arch

### Linux

# FOR Linux
```
zsh, oh my zsh and adjust .zshrc, eza, fzf, git, curl, neovim, fd, fzf, zoxide
gh, lazygit, stow, mise, ffmpeg, pnpm
unzip, zip, waybar, cloudflared, aws cli, mongodb-compass, slack, dunst,
 firefox, obs-studio, spotify, chrome, brave, 1password, ghostty, vscode,
 vscode-insiders, postman, discord, screen shots

 -STOW
- Requirements
```



