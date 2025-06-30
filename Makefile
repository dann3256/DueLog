
.PHONY:  install-sqlc generate-sqlc 

install-sqlc:
	go install github.com/sqlc-dev/sqlc/cmd/sqlc@latest

# full pass
SQLC_BIN := $(HOME)/go/bin/sqlc

generate-sqlc:
	$(SQLC_BIN) generate

