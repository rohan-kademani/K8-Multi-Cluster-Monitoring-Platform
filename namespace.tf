resource "kubernetes_namespace" "monitoring_cluster_a" {
  metadata {
    name = var.monitoring_namespaces["cluster_a"]
  }
}

resource "kubernetes_namespace" "monitoring_cluster_b" {
  metadata {
    name = var.monitoring_namespaces["cluster_b"]
  }
}

resource "kubernetes_namespace" "monitoring_global" {
  metadata {
    name = var.monitoring_namespaces["global"]
  }
}