REPOSITORY_ROOT := $(shell git rev-parse --show-toplevel)
SQL_FORMATTER ?= yarn --cwd "$(REPOSITORY_ROOT)/tools/sql-formatter" sql-formatter
NPROC = $(shell [ "$(uname)" = "Darwin" ] && sysctl -n hw.ncpu || nproc)

.PHONY: format-sql
format-sql:  ## Format PostgreSQL SQL files
	@find "$(CURDIR)" -type f -name '*.sql' \
		-print0 \
	| xargs -0 -P $(NPROC) -I {name} bash -c 'echo "Formatting {name}..." && $(SQL_FORMATTER) --fix -c "$(REPOSITORY_ROOT)/tools/sql-formatter/sql-formatter-postgresql.json" "{name}"'