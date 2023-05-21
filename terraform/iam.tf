resource "aws_iam_role" "eks_nodegroup_role" {
  name               = "${var.owner}-eks-nodegroup-role-${var.region}"
  assume_role_policy = data.aws_iam_policy_document.eks_nodegroup_policy.json
  managed_policy_arns = [
    data.aws_iam_policy.eks_nodegroup_ec2_policy.arn,
    data.aws_iam_policy.eks_nodegroup_ecr_policy.arn,
    data.aws_iam_policy.eks_nodegroup_eksworker_policy.arn
  ]
}

resource "aws_iam_role" "eks_cluster_role" {
  name                = "${var.owner}-eks-cluster-role-${var.region}"
  assume_role_policy  = data.aws_iam_policy_document.eks_cluster_policy.json
  managed_policy_arns = [data.aws_iam_policy.eks_cluster_policy.arn]
}