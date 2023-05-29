variable "environment" {
  type        = string
  description = "Environment for this project. Default is poc = proof of concept "
  default     = "poc"
}

variable "kube_config" {
  type    = string
  default = "~/.kube/config"
}

variable "owner" {
  type        = string
  description = "Owner of this cluster"
}

variable "region" {
  type        = string
  description = "AWS region to deploy the cluster to"
}
