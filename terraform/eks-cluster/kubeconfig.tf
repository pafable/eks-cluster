resource "null_resource" "connect_eks_kube" {
  provisioner "local-exec" {
    command = <<EOF
      aws eks --region ${var.region} update-kubeconfig --name ${local.cluster_name}
    EOF
  }

  depends_on = [
    aws_eks_cluster.my_cluster
  ]
}