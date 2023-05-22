# EKS Cluster
Creates an EKS cluster using terraform.

## Requirements
- AWS CLI installed and configured
- Terraform 1.4.6+

## Creating a tfvars file
Create a .tfvars file within the terraform folder and populate it with the following values.
```shell
eks_nodegroup_instance_type = <INSTANCE TYPE>
eks_nodegroup_role          = <NODE_GROUP_NAME>
eks_version                 = <EKS_VERSION>
environment                 = <ENVIRONMENT_NAME>
owner                       = <OWNER_NAME>
region                      = <AWS_REGION>
vpc_id                      = <VPC_ID>
```
## Create Cluster
```shell
make create
```

## Destroy Cluster
```shell
make destroy
```
