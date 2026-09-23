#!/usr/bin/env bash
set -euo pipefail

# Pi passes the temporary prompt file as $1. Ignore it and open the current
# project/worktree instead.
if command -v zed >/dev/null 2>&1; then
  exec zed "$PWD"
fi

for candidate in /opt/homebrew/bin/zed /usr/local/bin/zed; do
  if [[ -x "$candidate" ]]; then
    exec "$candidate" "$PWD"
  fi
done

echo "zed not found. Install Zed or make the 'zed' command available in PATH." >&2
exit 127
