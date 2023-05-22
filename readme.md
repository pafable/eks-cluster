# EKS Cluster
Creates an EKS cluster using terraform.

## Requirements
- AWS CLI installed and configured
- Terraform 1.4.6+

## Creating a tfvars file
Create a .tfvars file within the terraform folder and populate it with the following values.

Replace `<VALUE>` with your own.
```shell
eks_nodegroup_instance_type = <INSTANCE TYPE>
eks_version                 = <EKS VERSION>
environment                 = <ENVIRONMENT NAME>
owner                       = <OWNER NAME>
region                      = <AWS REGION>
vpc_id                      = <VPC ID>
disk_size                   = <DISK SIZE>
```
## Create Cluster
```shell
make create
```

## Destroy Cluster
```shell
make destroy
```
