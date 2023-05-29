# EKS Cluster
Creates an EKS cluster and deploys an app via helm charts using terraform. 
The cluster uses both managed EC2 node groups and Fargate.

## Requirements
- AWS CLI installed and configured
- Terraform 1.4.6+
- Kubectl 1.27
- If using Windows OS, use WSL2

## Creating a tfvars file
Create a tfvars file within the root of this folder and populate it with the following values.

Owner, region, and vpc_id are required and have no default values.

Replace `<VALUE>` with your own.
```shell
eks_nodegroup_instance_type = <INSTANCE TYPE> # default: t3.medium
eks_version                 = <EKS VERSION> # default: 1.27
environment                 = <ENVIRONMENT NAME> # default: poc
owner                       = <OWNER NAME>
region                      = <AWS REGION>
vpc_id                      = <VPC ID>
disk_size                   = <DISK SIZE> # default: 20
```

## Create EKS Cluster
```shell
make create
```

## Connecting to the cluster
Use `aws` command to update kubeconfig.
```shell
aws eks \
  --region <AWS REGION> \
  update-kubeconfig \
  --name <CLUSTER NAME>
```

Verify connection with `kubectl`. 
You should see your node groups and Fargate nodes.
```shell
kubectl get nodes
```

## Deploying example app
Update kubeconfig
```shell
make update-kube region=<AWS REGION> cluster=<CLUSTER NAME>
```

```shell
make deploy
```

## Destroy Cluster
When complete destroy the cluster with the following command.
```shell
make destroy
```

## NOTES

If kubectl is unable to connect due to an invalid apiVersion "error: exec plugin: invalid apiVersion "client.authentication.k8s.io/v1alpha1".

Enter the following command:
```shell
curl -L https://git.io/get_helm.sh | bash -s -- --version v3.8.2
```