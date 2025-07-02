REPOSITORY_ROOT := $(shell git rev-parse --show-toplevel)
JQ_SCRIPT := sql-formatter/extract-workspace-sql-formatter-config.jq

.PHONY: setup all
setup:  ## Setup sql-formatter environment
	@echo "Installing sql-formatter dependencies..."
	@yarn --cwd=sql-formatter install
	@echo "Generating configuration files..."
	@$(MAKE) all
	@echo "sql-formatter setup completed!"

all: sql-formatter/sql-formatter-postgresql.json

sql-formatter/sql-formatter-postgresql.json: $(REPOSITORY_ROOT)/compound/default.code-workspace $(JQ_SCRIPT)
	@if [ -f "$(REPOSITORY_ROOT)/compound/default.code-workspace" ]; then \
		grep -v '\s*//' "$<" | jq --from-file "$(JQ_SCRIPT)" > "$@"; \
	else \
		echo "Workspace file not found, skipping config generation"; \
	fi
