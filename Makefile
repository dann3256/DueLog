.PHONY: setup format-sql all

setup:
	@echo "Setting up development environment..."
	@make -C tools setup
	@echo "Setup completed!"

all:
	@make -C db/postgres format-sql