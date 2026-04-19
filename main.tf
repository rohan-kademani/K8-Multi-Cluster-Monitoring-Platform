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
  "${kubernetes_service.thanos_a.metadata[0].name}.monitoring-cluster-a.svc.cluster.local:10901",
  "${kubernetes_service.thanos_b.metadata[0].name}.monitoring-cluster-b.svc.cluster.local:10901"
]

  grafana_admin_password = var.grafana_admin_password

}

resource "kubernetes_service" "thanos_a" {
  metadata {
    name      = "prometheus-cluster-a-thanos"
    namespace = var.monitoring_namespaces["cluster_a"]
  }

  spec {
    selector = {
      "app.kubernetes.io/name"       = "prometheus"
      "operator.prometheus.io/name"  = "prometheus-cluster-a-prometheus"
    }

    port {
      name        = "grpc"
      port        = 10901
      target_port = 10901
    }

    type = "ClusterIP"
  }
}

resource "kubernetes_service" "thanos_b" {
  metadata {
    name      = "prometheus-cluster-b-thanos"
    namespace = var.monitoring_namespaces["cluster_b"]
  }

  spec {
    selector = {
      "app.kubernetes.io/name"       = "prometheus"
      "operator.prometheus.io/name"  = "prometheus-cluster-b-prometheus"
    }

    port {
      name        = "grpc"
      port        = 10901
      target_port = 10901
    }

    type = "ClusterIP"
  }
}