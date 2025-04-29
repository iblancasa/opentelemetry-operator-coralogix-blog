# Applications
PREFIX ?= ttl.sh/$(shell id -u)-coralogix-demo-app
APP_IMG ?= $(PREFIX)-1
APP2_IMG ?= $(PREFIX)-2
APP3_IMG ?= $(PREFIX)-3


help: ## Show help message
	@printf "Example application\n"
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n"} /^[$$()% a-zA-Z_-]+:.*?##/ { printf "  %-15s \t\t%s\n", $$1, $$2 } /^##@/ { printf "\n%s\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

################## Cluster management ###########################################################################################
.PHONY: start-cluster
start-cluster: ## Start kind cluster
	kind create cluster

.PHONY: clean
clean: ## Clean all the resources
	kind delete cluster

################## Application management #######################################################################################
.PHONY: apps
apps:  ## Build and push the demo applications images
	cd apps && docker build -t $(APP_IMG) app
	docker push $(APP_IMG)
	cd apps && docker build -t $(APP2_IMG) app2
	docker push $(APP2_IMG)
	cd apps && docker build -t $(APP3_IMG) app3
	docker push $(APP3_IMG)

.PHONY: deploy-apps
deploy-apps:  ## Deploy the demo applications in the local cluster
	APP_IMG=$(APP_IMG) APP2_IMG=$(APP2_IMG) APP3_IMG=$(APP3_IMG) envsubst < apps/manifest.yaml | kubectl apply -f -

.PHONY: restart-apps
restart-apps: ## Restart the deployments
	kubectl rollout restart deployment app1-v1
	kubectl rollout restart deployment app2-v1
	kubectl rollout restart deployment app3-v1
