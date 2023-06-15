resource "helm_release" "kube-prom-stack" {
  chart             = "kube-prometheus-stack"
  create_namespace  = true
  dependency_update = true
  name              = "kube-prom-stack"
  namespace         = "monitoring"
  repository        = "https://prometheus-community.github.io/helm-charts"
  version           = "46.8.0"
}