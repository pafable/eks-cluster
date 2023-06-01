resource "helm_release" "nginx" {
  chart     = "../../../charts/nginx"
  name      = "example-app"
  namespace = "default"
}