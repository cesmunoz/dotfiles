#!/bin/bash
set -e

copy_and_replace() {
  local name="$1"
  local src="$REPO_DIR/config/$name"
  local dest="$HOME/.config/$name"

  [ -d "$src" ] || return 0
  mkdir -p "$dest"
  cp -R "$src/"* "$dest" 2>/dev/null || true
}

copy_file() {
  local src="$1"
  local dest="$2"
  [ -f "$src" ] || return 0
  mkdir -p "$(dirname "$dest")"
  cp -f "$src" "$dest"
}

echo "Setup Omarchy-safe configurations"

mkdir -p "$HOME/.config"
copy_and_replace ghostty
copy_and_replace hypr
copy_and_replace mise
copy_and_replace zsh

copy_file "$REPO_DIR/config/starship.toml" "$HOME/.config/starship.toml"
copy_file "$REPO_DIR/config/.gitconfig" "$HOME/.gitconfig"
copy_file "$REPO_DIR/config/.gitignore" "$HOME/.gitignore"
copy_file "$REPO_DIR/config/.zshrc" "$HOME/.zshrc"

mkdir -p "$HOME/.pi/agent/extensions"
copy_file "$REPO_DIR/config/pi/agent/extensions/compact-footer.ts" "$HOME/.pi/agent/extensions/compact-footer.ts"
copy_file "$REPO_DIR/config/pi/agent/open-project-editor.sh" "$HOME/.pi/agent/open-project-editor.sh"
[ -f "$HOME/.pi/agent/open-project-editor.sh" ] && chmod +x "$HOME/.pi/agent/open-project-editor.sh"

if command -v node >/dev/null 2>&1; then
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
  echo "node not found; skipped Pi externalEditor setting"
fi
