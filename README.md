# Dotfiles

This repo contains my dotfiles and all the configurations I use on my computers.
Here we have the configuration for Mac and Arch linux.

In the Cross-platform we will have some common tools and tools/apps/configuration specific to each OS

# Table of Contents
- [Dotfiles](#dotfiles)
- [Table of Contents](#table-of-contents)
  - [📦 Structure](#-structure)
  - [🚀 Installation](#-installation)
  - [Configurations for each OS](#configurations-for-each-os)
    - [MAC](#mac)
    - [Linux](#linux)

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

```bash
mkdir -p ~/dev/cm
git clone https://github.com/cesmunoz/dotfiles.git ~/dev/cm/dotfiles
cd ~/dev/cm/dotfiles
sudo ./install.sh
```

The installer will:

- Detect the operating system (macOS or Arch Linux)
- Ensure gum and stow are installed
- Install a small set of core tools (zsh, neovim, etc).
- Stow the dotfiles into $HOME
- Apply OS-specific steps:
  - macOS: optional Brewfile + defaults.sh
  - Arch: optional aur packages, set default shell to zsh

Note: The script uses gum for nicer prompts/spinners if available.
It will install gum automatically before using it.

## Configurations for each OS

### MAC

### Linux




