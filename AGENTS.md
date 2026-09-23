# AGENTS.md

Guide for agents working in this dotfiles repository.

## Context

- Dotfiles repository for macOS and Arch Linux.
- The main entrypoint is `install.sh`.
- Configuration files live mostly in `config/` and are installed into `$HOME` with GNU Stow.
- OS-specific scripts are in:
  - `install/mac/`
  - `install/arch/`

## Working rules

- Do not run `sudo ./install.sh` or destructive scripts without explicit confirmation.
- Before changing installation scripts, inspect the full flow from `install.sh` and `install/guard.sh`.
- Keep macOS and Arch compatibility when the change is cross-platform.
- If a change is OS-specific, keep it inside `install/mac/` or `install/arch/`.
- Prefer small, easy-to-review changes.
- Do not add secrets, tokens, SSH keys, or personal data.
- Be careful with symlinks and absolute paths: this repo usually lives in `~/dev/cm/dotfiles`.

## Conventions

- Shell scripts: use `bash`/`zsh` as appropriate and keep existing `set -e`/guards when present.
- User configs: edit files in `config/`, not directly in `$HOME`.
- Custom scripts/binaries: place them in `bin/` and use `cm-*` names when applicable.
- Installers: separate changes by the existing categories (`requirements`, `terminal`, `desktop`, `system`, `extra`, `config`).

## Recommended validation

Before finishing:

```bash
bash -n install.sh
find install bin -type f -maxdepth 3 -exec bash -n {} \; 2>/dev/null || true
git diff --check
```

If you touch specific config files, validate them with the relevant tool when reasonable.

## Response style

- Respond briefly and in English by default.
- Show modified paths clearly.
- Include concrete next steps when something still needs to be run.
