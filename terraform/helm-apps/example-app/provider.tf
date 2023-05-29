terraform {
  required_version = ">= 1.4.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.67.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.9.0"
    }
  }
}

locals {
  cluster_name = "${var.owner}-${var.environment}-eks-${var.region}"
}

provider "aws" {
  default_tags {
    tags = {
      environment = var.environment
      owner       = var.owner
      region      = var.region
    }
  }
  region = var.region
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.tf_eks_cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.tf_eks_cluster.certificate_authority[0].data)

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args = [
        "--region",
        var.region,
        "eks",
        "get-token",
        "--cluster-name",
        local.cluster_name
      ]
      command = "aws"
    }
  }
}