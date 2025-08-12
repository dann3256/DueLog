
set -euo pipefail

ROOT_DIR=$(git rev-parse --show-toplevel)
BIN_DIR="${ROOT_DIR}/.bin"

mkdir -p "$BIN_DIR"

# sqlc
if [ -x "$BIN_DIR/sqlc" ]; then
  echo "sqlc is already installed"
else
  echo "Installing sqlc..."
  GOBIN="$BIN_DIR" go install github.com/sqlc-dev/sqlc/cmd/sqlc@latest
fi

# ogen & redocly
if [ -x "$BIN_DIR/ogen" ]; then
  echo "ogen is already installed"
else
  echo "Installing ogen and redocly..."
  npm install @redocly/cli --prefix "$BIN_DIR"
  ln -sf "$BIN_DIR/node_modules/.bin/redocly" "$BIN_DIR/redocly"
  GOBIN="$BIN_DIR" go install github.com/ogen-go/ogen/cmd/ogen@latest
fi
