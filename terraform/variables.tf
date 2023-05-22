variable "disk_size" {
  type    = number
}

variable "eks_nodegroup_instance_type" {
  type = string
}

variable "eks_nodegroup_role" {
  type = string
}

variable "eks_version" {
  type = number
}

variable "environment" {
  type = string
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
