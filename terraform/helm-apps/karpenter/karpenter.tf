data "aws_iam_role" "karpenter_role" {
  name = "${var.owner}-${var.environment}-karpenter-controller-role-${var.region}"
}

resource "helm_release" "karpenter" {
  namespace        = "karpenter"
  create_namespace = true
  name             = "karpenter"
  repository       = "https://charts.karpenter.sh"
  chart            = "karpenter"
  version          = "v0.16.3"

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = data.aws_iam_role.karpenter_role.arn
  }

  set {
    name  = "clusterName"
    value = data.aws_eks_cluster.tf_eks_cluster.id
  }

  set {
    name  = "aws.defaultInstanceProfile"
    value = "KarpenterNodeInstanceProfile"
  }

  set {
    name  = "clusterEndpoint"
    value = data.aws_eks_cluster.tf_eks_cluster.endpoint
  }

  set {
    name  = "fargate"
    value = "true"
  }
}