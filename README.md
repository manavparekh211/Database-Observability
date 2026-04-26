# Database Observability Suite

Welcome to the **Database Observability Suite**! This repository contains a collection of resources and configurations to enable observability for various database systems. Each folder is tailored to a specific database or observability setup, providing dashboards, exporters, and Kubernetes manifests to monitor and analyze database performance effectively.

---

## Architecture Diagram

Below is a high-level architecture diagram of the repository structure:

```mermaid
graph TD
    A[Database Observability Suite] --> B[Docker Compose Observability]
    A --> C[K8s MongoDB Observability]
    A --> D[K8s MySQL Observability]
    A --> E[K8s PostgreSQL Observability]
    A --> F[K8s Redis Observability]
    B --> B1[Prometheus]
    B --> B2[Grafana]
    B --> B3[Traffic Simulation]
    C --> C1[MongoDB Exporter]
    C --> C2[Grafana Dashboard]
    C --> C3[K8s Resources]
    D --> D1[MySQL Exporter]
    D --> D2[Grafana Dashboard]
    D --> D3[K8s Resources]
    E --> E1[PostgreSQL Exporter]
    E --> E2[Grafana Dashboard]
    E --> E3[K8s Resources]
    F --> F1[Redis Exporter]
    F --> F2[Grafana Dashboard]
    F --> F3[K8s Resources]
```

---

## Folder Overview

### `docker-compose-observability/`
A Docker Compose setup for local observability. Includes configurations for:
- **Prometheus**: Metrics collection and alerting.
- **Grafana**: Visualization dashboards.
- **Traffic Simulation**: A script to generate sample traffic.

### `k8s-mongodb-observability/`
Kubernetes manifests for MongoDB observability. Includes:
- **MongoDB Exporter**: Collects metrics from MongoDB.
- **Grafana Dashboard**: Pre-configured MongoDB performance visualization.
- **Kubernetes Resources**: Secrets, services, and StatefulSets.

### `k8s-mysql-observability/`
Kubernetes manifests for MySQL observability. Includes:
- **MySQL Exporter**: Collects metrics from MySQL.
- **Grafana Dashboard**: Pre-configured MySQL performance visualization.
- **Kubernetes Resources**: Secrets, services, and StatefulSets.

### `k8s-postgres-observability/`
Kubernetes manifests for PostgreSQL observability. Includes:
- **PostgreSQL Exporter**: Collects metrics from PostgreSQL.
- **Grafana Dashboard**: Pre-configured PostgreSQL performance visualization.
- **Kubernetes Resources**: Secrets, services, and StatefulSets.

### `k8s-redis-observability/`
Kubernetes manifests for Redis observability. Includes:
- **Redis Exporter**: Collects metrics from Redis.
- **Grafana Dashboard**: Pre-configured Redis performance visualization.
- **Kubernetes Resources**: Secrets, services, and StatefulSets.

---

## Quick Start
1. Clone the repository:
   ```bash
   git clone https://github.com/your-repo/database-observability-suite.git
   ```
2. Navigate to the desired folder and follow the README instructions within.
3. Deploy the observability stack locally or on Kubernetes.
---

Happy monitoring! 🚀
