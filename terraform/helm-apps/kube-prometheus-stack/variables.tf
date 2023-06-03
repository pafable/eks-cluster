variable "environment" {
  type        = string
  description = "Environment for this project. Default is poc = proof of concept "
  default     = "poc"
}

variable "owner" {
  type        = string
  description = "Owner of this cluster"
}

variable "region" {
  type        = string
  description = "AWS region to deploy the cluster to"
}

