resource "aws_eks_cluster" "my_cluster" {
  name     = "${local.cluster_name}-${var.region}"
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = var.eks_version
  vpc_config {
    subnet_ids = data.aws_subnets.default.ids
  }
}

# Node group
resource "aws_eks_node_group" "my_node_group" {
  cluster_name    = aws_eks_cluster.my_cluster.name
  disk_size       = var.disk_size
  instance_types  = [var.eks_nodegroup_instance_type]
  node_group_name = "${local.cluster_name}-nodegroup-${var.region}"
  node_role_arn   = aws_iam_role.eks_nodegroup_role.arn
  subnet_ids      = data.aws_subnets.default.ids
  version         = aws_eks_cluster.my_cluster.version

  labels = {
    app = "${var.owner}-eks-${var.environment}"
  }

  scaling_config {
    desired_size = var.environment == "poc" ? 1 : 3
    max_size     = 3
    min_size     = 1
  }

  update_config {
    max_unavailable = var.environment == "poc" ? 0 : 2
  }
}

# Fargate
resource "aws_eks_fargate_profile" "my_fargate_profile" {
  cluster_name           = aws_eks_cluster.my_cluster.name
  fargate_profile_name   = "${local.cluster_name}-fargate-profile-${var.region}"
  pod_execution_role_arn = aws_iam_role.eks_fargate_role.arn
  subnet_ids             = data.aws_subnets.private.ids
  selector {
    namespace = var.kubernetes_namespace
    labels = {
      fargate = "true"
    }
  }
}
