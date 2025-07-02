
.PHONY:  sql-format
SQL_DIR:=sql

sql-format:
	. .venv/bin/activate && sqlfluff fix $(SQL_DIR) --dialect postgres --exclude-rules L009

