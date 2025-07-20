.PHONY: setup format-sql lint-sql all install-sql sqlc-generate dev-setup

setup:  ## Setup development environment
	@echo "Setting up development environment..."
	@make -C tools setup
	@echo "Setup completed!"

format-sql:  ## Format PostgreSQL SQL files
	@make -C db/postgres format-sql

lint-sql:  ## Lint PostgreSQL SQL files
	@make -C db/postgres lint-sql

all:  ## Run all SQL operations (format and lint)
	@make -C db/postgres all



ROOT_DIR := $(shell git rev-parse --show-toplevel)
BIN_DIR  := $(ROOT_DIR)/.bin
GEN_DIR  := internal/infrastructure/db/postgres
install-sqlc:
	@if [ -x "$(BIN_DIR)" ]; then \
		echo "already sqlc installed"; \
	else \
   		mkdir -p $(BIN_DIR);\
		GOBIN=$(BIN_DIR) go install github.com/sqlc-dev/sqlc/cmd/sqlc@latest;\
	fi

sqlc-generate:
	rm -rf $(GEN_DIR)
	$(BIN_DIR)/sqlc generate

dev-setup:
	go mod tidy
	sqlc generate