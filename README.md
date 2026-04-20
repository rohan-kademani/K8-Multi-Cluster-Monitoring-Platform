# K8 Multi-Namespace Monitoring Platform (Terraform + Prometheus + Thanos + Grafana)

## Overview

This project implements a Kubernetes-based observability platform using Terraform and Helm.

It provides centralized monitoring across multiple Kubernetes namespaces using Prometheus and Thanos with Grafana for visualization.

The infrastructure is fully deployed and managed using Infrastructure as Code (Terraform).

> Note: This setup runs in a single Kubernetes cluster with multiple namespaces representing isolated environments (not multiple Kubernetes clusters).

---

## Architecture

### Namespace: monitoring-cluster-a

* Prometheus
* Thanos Sidecar
* Grafana components (optional based on deployment)

### Namespace: monitoring-cluster-b

* Prometheus
* Thanos Sidecar

### Central Observability Layer (monitoring namespace)

* Thanos Query → Aggregates metrics across namespaces via gRPC (StoreAPI)
* Grafana → Unified dashboards for all namespaces

---

## Prerequisites

### Infrastructure

* Kubernetes cluster (kubeadm / Docker Desktop / kind)
* Docker Desktop (Mac or Windows)

### Tools Required

* Terraform >= 1.5
* Helm >= 3
* kubectl configured with cluster access

---

## Deployment (Terraform-based)

### 1. Initialize Terraform

```bash
terraform init
```

---

### 2. Validate configuration

```bash
terraform plan
```

---

### 3. Apply infrastructure

```bash
terraform apply
```

This will provision:

* Prometheus in namespace `monitoring-cluster-a`
* Prometheus in namespace `monitoring-cluster-b`
* Thanos Sidecar for each Prometheus instance
* Thanos Query in `monitoring` namespace
* Required Kubernetes services and configurations via Helm

---

## Thanos Store Configuration

Thanos Query is configured with the following store endpoints:

```hcl
thanos_stores = [
  "prometheus-cluster-a-thanos-discovery.monitoring-cluster-a.svc.cluster.local:10901",
  "prometheus-cluster-b-thanos-discovery.monitoring-cluster-b.svc.cluster.local:10901"
]
```

These endpoints enable cross-namespace metric aggregation using gRPC (StoreAPI).

---

## Grafana Access

### Port Forward Grafana

```bash
kubectl port-forward svc/prometheus-a-grafana 3000:80 -n monitoring-cluster-a
```

### Access UI

```
http://localhost:3000
```

---

## Port Forwarding

### Grafana

```bash
kubectl port-forward svc/prometheus-a-grafana 3000:80 -n monitoring-cluster-a
```

### Prometheus UI

```bash
kubectl port-forward svc/prometheus-a-prometheus 9090:9090 -n monitoring-cluster-a
```

### Thanos Query

```bash
kubectl port-forward svc/thanos-query 9090:9090 -n monitoring
```

---

## Features

* Centralized observability across multiple Kubernetes namespaces
* Prometheus-based metrics collection per namespace
* Thanos-based cross-namespace metric aggregation
* gRPC StoreAPI communication between components
* Terraform-based infrastructure provisioning
* Helm-based Kubernetes application deployment
* Grafana-based visualization layer

---

## Important Note

This deployment uses a **single Kubernetes cluster with multiple namespaces** to simulate isolated environments. It does not require multiple Kubernetes clusters.

---

## Outcome

This project implements a scalable observability architecture with:

* Centralized metrics aggregation across namespaces
* Independent Prometheus instances per environment
* Unified querying layer using Thanos
* Infrastructure-as-Code based deployment using Terraform