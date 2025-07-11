REPOSITORY_ROOT := $(shell git rev-parse --show-toplevel)
JQ_SCRIPT := sql-formatter/extract-workspace-sql-formatter-config.jq

.PHONY: setup setup-formatter setup-lint all
setup:  ## Setup sql-formatter and sql-lint environment
	@echo "Setting up SQL tools..."
	@$(MAKE) setup-formatter
	@$(MAKE) setup-lint
	@echo "SQL tools setup completed!"

setup-formatter:  ## Setup sql-formatter
	@echo "Installing sql-formatter dependencies..."
	@yarn --cwd=sql-formatter install
	@echo "Generating formatter configuration files..."
	@$(MAKE) all

setup-lint:  ## Setup sql-lint
	@echo "Creating sql-lint configuration..."
	@echo '{"driver":"postgres","ignore-errors":["odd-code-point","trailing-whitespace"]}' > sql-formatter/.sql-lint.json

all: sql-formatter/sql-formatter-postgresql.json

sql-formatter/sql-formatter-postgresql.json: $(JQ_SCRIPT)
	@if [ -f "$(REPOSITORY_ROOT)/compound/default.code-workspace" ]; then \
		grep -v '\s*//' "$<" | jq --from-file "$(JQ_SCRIPT)" > "$@"; \
	else \
		echo "Workspace file not found, skipping config generation"; \
	fi