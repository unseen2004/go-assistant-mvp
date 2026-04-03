.PHONY: build run test docker-up docker-down docker-logs k8s-deploy k8s-delete k8s-status tf-init tf-plan tf-apply health e2e-test lint help

build: ## Build the gateway binary
	mkdir -p bin
	go build -o bin/gateway ./cmd/gateway/main.go

run: ## Run the gateway locally
	go run ./cmd/gateway/main.go

test: ## Run Go tests
	go test ./... -v

docker-up: ## Start services with docker-compose
	docker-compose up --build -d

docker-down: ## Stop services with docker-compose
	docker-compose down

docker-logs: ## Follow application logs
	docker-compose logs -f app

k8s-deploy: ## Deploy to Kubernetes
	kubectl apply -f deploy/k8s/

k8s-delete: ## Remove from Kubernetes
	kubectl delete -f deploy/k8s/

k8s-status: ## Check Kubernetes status
	kubectl get all -n go-assistant

tf-init: ## Initialize Terraform
	cd deploy/terraform && terraform init

tf-plan: ## Plan Terraform changes
	cd deploy/terraform && terraform plan

tf-apply: ## Apply Terraform changes
	cd deploy/terraform && terraform apply -auto-approve

health: ## Check application health
	curl -s http://localhost:8080/health

e2e-test: ## Run the full end-to-end test scenario
	chmod +x scripts/e2e_test.sh
	./scripts/e2e_test.sh

lint: ## Run Go vet
	go vet ./...

help: ## Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'
