data "aws_iam_policy_document" "karpenter_assume_role" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    condition {
      test     = "StringEquals"
      values   = ["system:serviceaccount:karpenter:karpenter"]
      variable = "${var.cluster_oidc_url}:sub"
    }
    condition {
      test     = "StringEquals"
      values   = ["sts.amazonaws.com"]
      variable = "${var.cluster_oidc_url}:aud"
    }
    principals {
      type        = "Federated"
      identifiers = [var.cluster_oidc_arn]
    }
  }
}