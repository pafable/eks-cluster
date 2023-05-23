variable "disk_size" {
  type    = number
  default = 20
}

variable "eks_nodegroup_instance_type" {
  type    = string
  default = "t3.medium"
}

variable "eks_version" {
  type    = number
  default = 1.26
}

variable "environment" {
  type = string
}

variable "kubernetes_namespace" {
  type    = string
  default = "default"
}

variable "owner" {
  type = string
}

variable "region" {
  type = string
}

variable "vpc_id" {
  type = string
}
