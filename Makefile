.PHONY: setup format-sql lint-sql all install-sql

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

SQLC_CONFIG := db/postgres/sqlc.yaml
SQL_DIR := db/postgres/query
SCHEMA_DIR := db/postgres/schema
GEN_DIR := internal/db

install-sql:
	@make 