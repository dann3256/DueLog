# ファイル名ではなくコマンド名であることを明記（疑似ターゲット）
# ファイル名と被ってもコマンドを読み込める
.PHONY: install-ogen install-sqlc generate-sqlc generate-ogen build run clean setup

# SQLC のインストール
install-sqlc:
	go install github.com/sqlc-dev/sqlc/cmd/sqlc@latest
# Ogenのインストール
install-ogen:
	go install github.com/ogen-go/ogen/cmd/ogen@latest

# sqlcとogenのフルパス
SQLC_BIN := $(HOME)/go/bin/sqlc
OGEN_BIN := $(HOME)/go/bin/ogen

# SQLCでコード生成
generate-sqlc:
	$(SQLC_BIN) generate

# ogenでコード生成
generate-ogen:
	$(OGEN_BIN) --target internal/ogen /--clean /--package api/openapi.yaml

regen: generate-sqlc generate-ogen

# アプリケーションのビルド（コンパイラ）
build:
	go build -o app main.go

# アプリケーションの実行
run:
	go run main.go

# クリーンアップ
clean:
# -f：親ディレクトリがなくても強制実行
# -r：そのフォルダ内をすべて削除
# 	rm -f app users.db
	rm -rf internal/ 

# 初期セットアップ（SQLC インストール + コード生成 + 依存関係取得）
# p：ディレクトリごと作成
setup: install-sqlc install-ogen
	go mod tidy
	mkdir -p sql/schema sql/queries internal/db internal/ogen
	$(SQLC_BIN) generate
	$(OGEN_BIN) --target internal/ogen --clean --package api openapi.yaml

# 開発用（コード生成 + 実行）
dev: generate run