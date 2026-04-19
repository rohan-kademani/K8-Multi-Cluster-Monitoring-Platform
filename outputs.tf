output "grafana_namespace" {
  value = kubernetes_namespace.monitoring_global.metadata[0].name
}