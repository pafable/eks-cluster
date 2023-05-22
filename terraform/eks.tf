resource "aws_eks_cluster" "my_cluster" {
  name     = "${var.owner}-eks-cluster-${var.region}"
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = var.eks_version
  vpc_config {
    subnet_ids = data.aws_subnets.default.ids
  }
}

resource "aws_eks_node_group" "my_node_group" {
  cluster_name    = aws_eks_cluster.my_cluster.name
  disk_size       = var.disk_size
  instance_types  = [var.eks_nodegroup_instance_type]
  node_group_name = "${var.owner}-eks-nodegroup-${var.region}"
  node_role_arn   = aws_iam_role.eks_nodegroup_role.arn
  subnet_ids      = data.aws_subnets.default.ids
  version         = aws_eks_cluster.my_cluster.version

  labels = {
    app = "${var.owner}-eks-${var.environment}"
  }

  scaling_config {
    desired_size = 3
    max_size     = 3
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }
}

#resource "aws_eks_fargate_profile" "my_fargate_profile" {
#  cluster_name           = aws_eks_cluster.my_cluster.name
#  fargate_profile_name   = "${var.owner}-fargate-profile-${var.region}"
#  pod_execution_role_arn = ""
#  subnet_ids             = data.aws_subnets.default.ids
#}