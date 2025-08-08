
set -euo pipefail

ROOT_DIR=$(git rev-parse --show-toplevel)
BIN_DIR="${ROOT_DIR}/.bin"
SQLC_DIR="${ROOT_DIR}/internal/infrastructure/db/sqlc"


rm -rf "$SQLC_DIR"
"$BIN_DIR/sqlc" generate
