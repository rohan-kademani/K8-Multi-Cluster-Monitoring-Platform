resource "helm_release" "prometheus" {
  name       = var.release_name
  repository = var.prometheus_repository
  chart      = var.prometheus_chart_name
  namespace  = var.namespace

  values = [
    templatefile("${path.module}/values.yaml", {
      cluster_name = var.cluster_name
      retention    = var.retention
    })
  ]
}