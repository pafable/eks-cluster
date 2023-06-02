terraform {
  required_version = ">= 1.4.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.67.0"
    }
  }
}

provider "aws" {
  default_tags {
    tags = {
      environment   = var.environment
      owner         = var.owner
      region        = var.region
      managed_by    = "terraform"
      creation_date = timestamp()
    }
  }
  region = var.region
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.tf_eks_cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.tf_eks_cluster.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.tf_eks_cluster.token
  }
}

locals {
  cluster_name = "${var.owner}-${var.environment}-eks-${var.region}"
}

data "aws_eks_cluster" "tf_eks_cluster" {
  name = local.cluster_name
}

data "aws_eks_cluster_auth" "tf_eks_cluster" {
  name = local.cluster_name
}