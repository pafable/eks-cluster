# EKS Cluster
Creates an EKS cluster using terraform. The cluster uses both managed EC2 node groups and Fargate.

## Requirements
- AWS CLI installed and configured
- Terraform 1.4.6+
- Kubectl

## Creating a tfvars file
Create a .tfvars file within the terraform folder and populate it with the following values.

Replace `<VALUE>` with your own.
```shell
eks_nodegroup_instance_type = <INSTANCE TYPE> # default: t3.medium
eks_version                 = <EKS VERSION> # default: 1.26
environment                 = <ENVIRONMENT NAME>
owner                       = <OWNER NAME>
region                      = <AWS REGION>
vpc_id                      = <VPC ID>
disk_size                   = <DISK SIZE> # default: 20
```

## Create Cluster
```shell
make create
```

## Connecting to the cluster
Use `aws` command to update kubeconfig
```shell
aws eks \
  --region <AWS REGION> \
  update-kubeconfig \
  --name <CLUSTER NAME>
```

Verify connection with `kubectl`. You should see your node groups and Fargate nodes.
```shell
kubectl get nodes
```

## Destroy Cluster
When complete destroy the cluster with the following command.
```shell
make destroy
```
