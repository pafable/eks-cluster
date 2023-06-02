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