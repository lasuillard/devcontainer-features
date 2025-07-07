#!/usr/bin/env -S make -f

MAKEFLAGS += --warn-undefined-variable
MAKEFLAGS += --no-builtin-rules
MAKEFLAGS += --silent

SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
.DEFAULT_GOAL := help

help: Makefile  ## Show help
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'


# =============================================================================
# Common
# =============================================================================
install:  ## Install deps

.PHONY: install

init:  ## Initialize the project
	pre-commit install --install-hooks
.PHONY: init

update:  ## Update deps and tools
	pre-commit autoupdate
.PHONY: update


# =============================================================================
# CI
# =============================================================================
ci: lint test  ## Run CI tasks
.PHONY: ci

format:  ## Run autoformatters
	pre-commit run --all-files shfmt
.PHONY: format

lint:  ## Run all linters
	pre-commit run --all-files shellcheck
.PHONY: lint

test:  ## Run tests
	devcontainer features test
.PHONY: test


# =============================================================================
# Handy Scripts
# =============================================================================
clean:  ## Remove temporary files

.PHONY: clean
