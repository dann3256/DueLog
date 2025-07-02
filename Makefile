
.PHONY:  sql-format
SQL_DIR:=sql

sql-format:
	.venv/bin/sqlfluff fix $(SQL_DIR) --dialect postgres --exclude-rules L009

sql-lint:
	.venv/bin/sqlfluff lint sql --dialect postgres

