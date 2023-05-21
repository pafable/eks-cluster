TF = $(shell which terraform)

.PHONY: create plan init destroy

create: plan
	$(TF) -chdir=terraform apply plan

plan: init
	$(TF) -chdir=terraform plan -var-file=vars.tfvars -out plan

init:
	$(TF) -chdir=terraform init

destroy:
	$(TF) -chdir=terraform destroy -var-file=vars.tfvars -auto-approve