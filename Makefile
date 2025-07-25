.PHONY: setup format-sql lint-sql all install-sql sqlc-generate install-ogen ogen-generate dev-setup

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
SQL_DIR  := $(ROOT_DIR)/internal/infrastructure/db/postgres
OGEN_DIR  := $(ROOT_DIR)/internal/infrastructure/ogen
install-sqlc:
	@if [ -x "$(BIN_DIR)/sqlc" ]; then \
		echo "already sqlc installed"; \
	else \
   		mkdir -p $(BIN_DIR);\
		GOBIN=$(BIN_DIR) go install github.com/sqlc-dev/sqlc/cmd/sqlc@latest;\
	fi
	
install-ogen:
	@if [ -x "$(BIN_DIR)/ogen" ]; then \
		echo "already ogen installed"; \
	else \
		npm install @redocly/cli --prefix $(BIN_DIR);\
		ln -sf $(BIN_DIR)/node_modules/.bin/redocly $(BIN_DIR)/redocly;\
		mkdir -p $(BIN_DIR);\
		GOBIN=$(BIN_DIR) go install github.com/ogen-go/ogen/cmd/ogen@latest;\
	fi

sqlc-generate:
	rm -rf $(SQL_DIR)
	$(BIN_DIR)/sqlc generate

ogen-generate:
	rm -rf $(OGEN_DIR)
	npx --prefix $(ROOT_DIR)/.bin redocly bundle docs/api/openapi.yaml -o docs/api/bundle.yaml
	$(ROOT_DIR)/.bin/ogen -target $(OGEN_DIR) --clean --package api   docs/api/bundle.yaml

dev-setup:
	go mod tidy
	sqlc generate