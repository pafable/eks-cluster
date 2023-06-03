HELM = $(shell which helm)
TF = $(shell which terraform)
EX_APP ?= 'example-app'

# Helm chart dir
NGINX_CHART_DIR ?= 'charts/nginx'

# Terraform dir
EKS_DIR ?= 'terraform/eks-cluster'
EX_APP_DIR ?= 'terraform/helm-apps/example-app'
KUBE_PROM_DIR ?= 'terraform/helm-apps/kube-prometheus-stack'

.PHONY: create deploy plan init fmt destroy test

create: plan
	$(TF) -chdir=$(EKS_DIR) apply plan
	# EKS cluster needs to be created before kube-prometheus-stack plan can be created
	$(TF) -chdir=$(KUBE_PROM_DIR) plan -var-file=../../../vars.tfvars -out plan
	$(TF) -chdir=$(KUBE_PROM_DIR) apply plan

deploy: create
	$(TF) -chdir=$(EX_APP_DIR) plan -var-file=../../../vars.tfvars -out plan
	$(TF) -chdir=$(EX_APP_DIR) apply plan
	$(HELM) test $(EX_APP)

plan: init
	$(TF) -chdir=$(EKS_DIR) plan -var-file=../../vars.tfvars -out plan

init: fmt
	$(TF) -chdir=$(EKS_DIR) init
	$(TF) -chdir=$(KUBE_PROM_DIR) init
	$(TF) -chdir=$(EX_APP_DIR) init

fmt:
	$(TF) -chdir=$(EKS_DIR) fmt
	$(TF) -chdir=$(KUBE_PROM_DIR) fmt
	$(TF) -chdir=$(EX_APP_DIR) fmt

destroy: fmt
	$(TF) -chdir=$(EKS_DIR) destroy -var-file=../../vars.tfvars -auto-approve

test: fmt
	$(TF) -chdir=$(EKS_DIR) validate
	$(TF) -chdir=$(KUBE_PROM_DIR) validate
	$(TF) -chdir=$(EX_APP_DIR) validate
	$(HELM) lint $(NGINX_CHART_DIR)
