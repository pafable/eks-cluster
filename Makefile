TF = $(shell which terraform)

.PHONY: create plan init destroy

create: plan
	$(TF) -chdir=terraform apply plan

plan: init
	$(TF) -chdir=terraform plan -var-file=vars.tfvars -out plan

init: fmt
	$(TF) -chdir=terraform init

fmt:
	$(TF) -chdir=terraform fmt

destroy: fmt
	$(TF) -chdir=terraform destroy -var-file=vars.tfvars -auto-approve

test: fmt
	$(TF) -chdir=terraform validate
