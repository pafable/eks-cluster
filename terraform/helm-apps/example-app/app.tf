resource "helm_release" "nginx" {
  chart = "../../../charts/nginx"
  name  = "nginx"
}