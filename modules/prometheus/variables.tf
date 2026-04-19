variable "release_name" {
  description = "Name of the Helm release for the Prometheus stack"
}

variable "namespace" {
  description = "Kubernetes namespace where Prometheus will be deployed"
}

variable "cluster_name" {
  description = "Cluster identifier used for Prometheus external labels (used by Thanos for federation)"
  type        = string
}

variable "prometheus_repository" {
  description = "Helm repository URL for Prometheus community charts"
  default     = "https://prometheus-community.github.io/helm-charts"
}

variable "prometheus_chart_name" {
  description = "Helm chart name used to deploy Prometheus stack"
  default     = "kube-prometheus-stack"
}

variable "retention" {
  description = "Prometheus data retention period (e.g., 2d, 7d). Controls how long metrics are stored locally."
  default     = "2d"
}