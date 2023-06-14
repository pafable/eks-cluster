resource "helm_release" "istio" {
  chart            = "istio"
  create_namespace = true
  name             = "my-istio"
  namespace        = "istio-mesh"
  repository       = "https://istio-release.storage.googleapis.com/charts"

  set {
    name = "global.istioNamespace"
    value = "istio-mesh"
  }
}

resource "helm_release" "istiod" {
  chart = "istiod"
  create_namespace = true
  name  = "my-istiod"
  namespace        = "istio-mesh"
  repository       = "https://istio-release.storage.googleapis.com/charts"

  set {
    name = "telemetetry.enabled"
    value = "true"
  }

  set {
    name = "global.istioNamespace"
    value = "istio-mesh"
  }

  set {
    name = "meshConfig.ingressService"
    value = "istio-gateway"
  }

  set {
    name = "meshConfig.ingressSelector"
    value = "gateway"
  }

  depends_on = [helm_release.istio]
}