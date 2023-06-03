resource "helm_release" "kube-prom-stack" {
  chart            = "kube-prometheus-stack"
  create_namespace = true
  name             = "kube-prom-stack"
  namespace        = "monitoring"
  repository       = "https://prometheus-community.github.io/helm-charts"
}