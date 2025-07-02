REPOSITORY_ROOT := $(shell git rev-parse --show-toplevel)
SQL_FORMATTER ?= yarn --cwd "$(REPOSITORY_ROOT)/tools/sql-formatter" sql-formatter
SQL_LINT ?= yarn --cwd "$(REPOSITORY_ROOT)/tools/sql-formatter" sql-lint
NPROC = $(shell [ "$(uname)" = "Darwin" ] && sysctl -n hw.ncpu || nproc)

.PHONY: format-sql lint-sql all

all:  ## Run formatter and lint on SQL files
	@echo "Running SQL formatter and lint..."
	@$(MAKE) format-sql
	@$(MAKE) lint-sql
	@echo "SQL operations completed!"
format-sql:  ## Format PostgreSQL SQL files
	@find "$(CURDIR)" -type f -name '*.sql' \
		-print0 \
	| xargs -0 -P $(NPROC) -I {name} bash -c 'echo "Formatting {name}..." && $(SQL_FORMATTER) --fix -c "$(REPOSITORY_ROOT)/tools/sql-formatter/sql-formatter-postgresql.json" "{name}"'

lint-sql:  ## Lint PostgreSQL SQL files
	@echo "=== SQL Lint Results ==="
	@find "$(CURDIR)" -type f -name '*.sql' \
		-print0 \
	| xargs -0 -I {name} bash -c '\
		echo ""; \
		echo "📁 Checking: {name}"; \
		echo "---"; \
		$(SQL_LINT) --config "$(REPOSITORY_ROOT)/tools/sql-formatter/.sql-lint.json" "{name}" 2>&1 | \
		sed "s|^/.*\.sql:\([0-9]*\) |⚠️  Line \1: |g" | \
		sed "s|sql-lint was unable to lint|❌ Unable to parse|g" | \
		sed "s|This could be a bug with sql-lint.*|💡 This might be PostgreSQL-specific syntax|g" || \
		echo "✅ No issues found"; \
		echo ""'
	@echo "=== Lint Complete ==="