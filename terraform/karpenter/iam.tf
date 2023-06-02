locals {
  cluster_name                     = "${var.owner}-${var.environment}-eks-${var.region}"
  karpenter_controller_role_name   = "${var.owner}-${var.environment}-karpenter-controller-role-${var.region}"
  karpenter_controller_policy_name = "${var.owner}-${var.environment}-karpenter-controller-policy-${var.region}"
  node_group_role_name             = "${local.cluster_name}-nodegroup-role"

}
data "aws_eks_cluster" "tf_eks_cluster" {
  name = local.cluster_name
}

data "tls_certificate" "eks" {
  url = data.aws_eks_cluster.tf_eks_cluster.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "tf_eks" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks.certificates[0].sha1_fingerprint]
  url             = data.aws_eks_cluster.tf_eks_cluster.identity[0].oidc[0].issuer
}

data "aws_iam_policy_document" "karpenter_controller_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      values   = ["system:serviceaccount:karpenter:karpenter"]
      variable = "${replace(aws_iam_openid_connect_provider.tf_eks.url, "https://", "")}:sub"
    }

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.tf_eks.arn]
    }
  }
}

resource "aws_iam_role" "karpenter_controller_role" {
  assume_role_policy = data.aws_iam_policy_document.karpenter_controller_assume_role_policy.json
  name               = local.karpenter_controller_role_name
}

resource "aws_iam_policy" "karpenter_controller_policy" {
  policy = file("./controller-trust-policy.json")
  name   = local.karpenter_controller_policy_name
}

resource "aws_iam_role_policy_attachment" "aws_lb_controller_attach" {
  policy_arn = aws_iam_policy.karpenter_controller_policy.arn
  role       = aws_iam_role.karpenter_controller_role.name
}

resource "aws_iam_instance_profile" "tf_karpenter" {
  name = "KarpenterNodeInstanceProfile"
  role = local.node_group_role_name
}