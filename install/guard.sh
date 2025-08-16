
#!/bin/bash

# ------------------------------------------------------------------------------
# Guard
# - Detecting OS
# ------------------------------------------------------------------------------

# - Detecting OS
if [[ "$OS" == "Darwin" ]]; then
  OS="mac"
elif [[ "$OS" == "Linux" ]]; then
  if command -v pacman &> /dev/null; then
    OS="arch"
  else
    exit 1
  fi
else
  exit 1
fi

echo -e "Guard clauses passed"