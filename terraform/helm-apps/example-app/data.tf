data "aws_eks_cluster" "tf_eks_cluster" {
  name = local.cluster_name
}