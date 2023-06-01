resource "aws_iam_role" "karpenter" {
  description        = "IAM Role for Karpenter Controller to assume"
  assume_role_policy = data.aws_iam_policy_document.karpenter_assume_role.json
  name               = "${var.cluster_name}-karpenter-controller"
  inline_policy {
    policy = data.aws_iam_policy_document.karpenter.json
    name   = "karpenter"
  }
}
