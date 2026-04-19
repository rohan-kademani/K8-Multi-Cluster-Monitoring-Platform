variable "cluster_a_label" {
  description = "Logical label used to identify metrics from Prometheus instance A in Thanos/Grafana dashboards"
  default     = "cluster-a"
}

variable "cluster_b_label" {
  description = "Logical label used to identify metrics from Prometheus instance B in Thanos/Grafana dashboards"
  default     = "cluster-b"
}

variable "prometheus_retention" {
  description = "Prometheus data retention period (e.g., 2d, 7d). Controls how long metrics are stored locally before being deleted"
  default     = "2d"
}


variable "monitoring_namespaces" {
  description = "Map of namespace names for different monitoring stacks"
  type        = map(string)

  default = {
    cluster_a = "monitoring-cluster-a"
    cluster_b = "monitoring-cluster-b"
    global    = "monitoring-global"
  }
}

variable "grafana_admin_password" {
  description = "Admin password for Grafana dashboard access (should be overridden in production)"
  type        = string
  default     = "admin123"
  sensitive   = true
}