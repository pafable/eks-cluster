output "eks_cluster_role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
}

output "eks_nodegroup_role_arn" {
  value = aws_iam_role.eks_nodegroup_role.arn
}

output "eks_arn" {
  value = aws_eks_cluster.my_cluster.arn
}

output "eks_id" {
  value = aws_eks_cluster.my_cluster.id
}

output "eks_endpoint" {
  value = aws_eks_cluster.my_cluster.endpoint
}

output "eks_status" {
  value = aws_eks_cluster.my_cluster.status
}
