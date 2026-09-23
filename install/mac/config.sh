#!/bin/bash

copy_and_replace() {
  local name="$1"
  local src="$HOME/dev/cm/dotfiles/config/$name"
  local dest="$HOME/.config/$name"

  mkdir -p "$dest"

  cp -R "$src/"* "$dest"
}

gum log --level info "Setup Configurations"

# Copy and replace
mkdir -p ~/.config
copy_and_replace ghostty
copy_and_replace mise
copy_and_replace nvim
copy_and_replace zsh

cp -R ~/dev/cm/dotfiles/config/starship.toml ~/.config/starship.toml
cp -R ~/dev/cm/dotfiles/config/.gitconfig ~/.gitconfig
cp -R ~/dev/cm/dotfiles/config/.gitignore ~/.gitignore
cp -R ~/dev/cm/dotfiles/config/.zshrc ~/.zshrc

mkdir -p "$HOME/.pi/agent/extensions"
cp -R "$REPO_DIR/config/pi/agent/extensions/compact-footer.ts" "$HOME/.pi/agent/extensions/compact-footer.ts"
cp -R "$REPO_DIR/config/pi/agent/open-project-editor.sh" "$HOME/.pi/agent/open-project-editor.sh"
chmod +x "$HOME/.pi/agent/open-project-editor.sh"

if command -v node &> /dev/null; then
  node - "$HOME/.pi/agent/settings.json" "$HOME/.pi/agent/open-project-editor.sh" <<'NODE'
const fs = require("fs");
const [settingsPath, externalEditor] = process.argv.slice(2);
let settings = {};

if (fs.existsSync(settingsPath)) {
  settings = JSON.parse(fs.readFileSync(settingsPath, "utf8"));
}

settings.externalEditor = externalEditor;
fs.writeFileSync(settingsPath, `${JSON.stringify(settings, null, 2)}\n`);
NODE
else
  gum log --level warn "node not found; skipped Pi externalEditor setting"
fi

mkdir -p "$HOME/.local/bin"
ln -sf "$REPO_DIR/bin/cm" "$HOME/.local/bin/cm"
