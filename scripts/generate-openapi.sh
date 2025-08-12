
set -euo pipefail

ROOT_DIR=$(git rev-parse --show-toplevel)
BIN_DIR="${ROOT_DIR}/.bin"
OGEN_DIR="${ROOT_DIR}/internal/infrastructure/ogen"


rm -rf "$OGEN_DIR"
npx --prefix "$BIN_DIR" redocly bundle docs/api/openapi.yaml -o docs/api/bundle.yaml
"$BIN_DIR/ogen" --target "$OGEN_DIR" --clean --package api docs/api/bundle.yaml
