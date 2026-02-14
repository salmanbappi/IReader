.PHONY: help gh-release gh-preview gh-test-migration sync-upstream

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-25s\033[0m %s\n", $$1, $$2}'

gh-release: ## Trigger a Release build on GitHub (requires tag and name)
	@read -p "Enter Release Tag (e.g., v1.2.0): " tag; \
	read -p "Enter Release Name: " name; \
	gh workflow run Release.yaml -f release-tag=$$tag -f release-name="$$name"

gh-preview: ## Trigger a Preview build on GitHub
	gh workflow run Preview.yaml

gh-test-migration: ## Trigger Database Migration tests on GitHub
	gh workflow run database-migration-test.yml

gh-status: ## Monitor the status of the latest GitHub Action runs
	gh run list --limit 5

sync-upstream: ## Sync fork with upstream master
	git fetch upstream
	git merge upstream/master
	git push origin master