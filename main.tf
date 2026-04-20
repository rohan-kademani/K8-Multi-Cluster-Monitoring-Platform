module "prometheus_cluster_a" {
  depends_on = [kubernetes_namespace.monitoring_cluster_a]
  source     = "./modules/prometheus"

  release_name = "prometheus-a"
  namespace    = var.monitoring_namespaces["cluster_a"]
  cluster_name = var.cluster_a_label

  retention = var.prometheus_retention
}

module "prometheus_cluster_b" {
  depends_on = [kubernetes_namespace.monitoring_cluster_b]
  source     = "./modules/prometheus"

  release_name = "prometheus-b"
  namespace    = var.monitoring_namespaces["cluster_b"]
  cluster_name = var.cluster_b_label

  retention = var.prometheus_retention
}


module "monitoring" {
  source = "./modules/monitoring"

  monitoring_namespace = var.monitoring_namespaces["global"]

thanos_stores = [
  "prometheus-cluster-a-thanos-discovery.monitoring-cluster-a.svc.cluster.local:10901",
  "prometheus-cluster-b-thanos-discovery.monitoring-cluster-b.svc.cluster.local:10901"
]

  grafana_admin_password = var.grafana_admin_password

}

