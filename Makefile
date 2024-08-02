.DEFAULT_GOAL := help
BUILD_TIME := $(shell date -u '+%F_%T')
VERSION ?= $(shell (git describe --tags --dirty --match='v*' 2>/dev/null || echo v0.0.0) | cut -c2-)
TAG ?= ${VERSION}
DOCKER_REGISTRY?=ghcr.io/barkardk
.PHONY: help
help: ## Help
	@grep -E '^[a-zA-Z\\._-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: install 
install: verify deploy ## Verify local colima instalnse and deploy kafka

.PHONY: verify 
verify:  ## Verify the current cluster is a running colima instance
	./install.sh verify

.PHONY: deploy 
deploy: ## Deploy kafka to local k3s cluster
	./install.sh deploy

.PHONY: delete
delete: ## Uninstall kafka
	./install.sh uninstall
