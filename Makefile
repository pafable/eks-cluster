TF = $(shell which terraform)

.PHONY: create deploy plan init fmt destroy test update-kubeconf

create: plan
	$(TF) -chdir=terraform/eks-cluster apply plan

deploy: create
	$(TF) -chdir=terraform/helm-apps/example-app plan -var-file=../../../vars.tfvars -out plan
	$(TF) -chdir=terraform/helm-apps/example-app apply plan

plan: init
	$(TF) -chdir=terraform/eks-cluster plan -var-file=../../vars.tfvars -out plan

init: fmt
	$(TF) -chdir=terraform/eks-cluster init
	$(TF) -chdir=terraform/helm-apps/example-app init

fmt:
	$(TF) -chdir=terraform/eks-cluster fmt
	$(TF) -chdir=terraform/helm-apps/example-app fmt

destroy: fmt
	$(TF) -chdir=terraform/eks-cluster destroy -var-file=../../vars.tfvars -auto-approve

test: fmt plan
	$(TF) -chdir=terraform/eks-cluster validate
	$(TF) -chdir=terraform/helm-apps/example-app validate

update-kube:
	aws eks --region $(region) update-kubeconfig --name $(cluster)