variable "monitoring_namespace" {
  description = "Namespace where global monitoring stack (Thanos Query + Grafana) is deployed"
  type        = string
}

variable "thanos_query_name" {
  description = "Helm release name for Thanos Query"
  type        = string
  default     = "thanos-query"
}

variable "thanos_repository" {
  description = "Helm repository for Thanos chart"
  type        = string
  default     = "https://thanos-io.github.io/thanos-helm-chart"
}

variable "thanos_chart_name" {
  description = "Helm chart name for Thanos"
  type        = string
  default     = "thanos"
}

variable "thanos_stores" {
  description = "List of Prometheus Thanos sidecar gRPC endpoints"
  type        = list(string)
}

variable "grafana_name" {
  description = "Helm release name for Grafana"
  type        = string
  default     = "grafana"
}

variable "grafana_admin_password" {
  description = "Admin password for Grafana (should be overridden in production)"
  type        = string
  sensitive   = true
  default     = "admin123"
}

variable "grafana_repository" {
  description = "Helm repository for Grafana chart"
  type        = string
  default     = "https://grafana.github.io/helm-charts"
}

variable "grafana_chart_name" {
  description = "Helm chart name for Grafana"
  type        = string
  default     = "grafana"
}