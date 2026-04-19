resource "helm_release" "thanos_query" {
  name       = var.thanos_query_name
  # Use the OCI registry as established in previous step
  repository = null 
  chart      = "oci://registry-1.docker.io/bitnamicharts/thanos"
  namespace  = var.monitoring_namespace

  # --- THE FIX ---
  set {
    name  = "global.security.allowInsecureImages"
    value = "true"
  }
  # ---------------

  set {
    name  = "query.enabled"
    value = "true"
  }

  set {
    name  = "image.registry"
    value = "quay.io"
  }

  set {
    name  = "image.repository"
    value = "thanos/thanos"
  }

  set {
    name  = "image.tag"
    value = "v0.32.5"
  }

  dynamic "set" {
    for_each = var.thanos_stores
    content {
      name  = "query.stores[${set.key}]"
      value = set.value
    }
  }

  # Local Lab Fix for Docker Desktop/Kubeadm permissions
  set {
    name  = "commonConfiguration.containerSecurityContext.enabled"
    value = "false"
  }
}

resource "helm_release" "grafana" {
  name       = var.grafana_name
  repository = var.grafana_repository
  chart      = var.grafana_chart_name
  namespace  = var.monitoring_namespace

  set {
    name  = "adminPassword"
    value = var.grafana_admin_password
  }
}