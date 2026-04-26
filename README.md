# Database Observability Toolkit

> End-to-end observability for PostgreSQL, MySQL, MongoDB, and Redis — containerized with Docker Compose and Kubernetes, monitored via Prometheus and Grafana.

---

## Architecture

```
Databases (PG / MySQL / Mongo / Redis)
    └── Exporters (db-specific)
        └── Prometheus (scrape & store)
            └── Grafana (visualize & alert)
```

All components are orchestrated via **Docker Compose** (local dev) and **Kubernetes** (production-grade deployment).

---

## Quick Start

**Prerequisites:** Docker, Docker Compose, kubectl (for K8s)

```bash
# Clone the repo
git clone https://github.com/manavparekh211/Database-Observability.git
cd Database-Observability

# Start a stack (e.g., PostgreSQL)
cd docker-compose/postgresql
docker compose up -d

# Access Grafana
open http://localhost:3000   # admin / admin
```

For Kubernetes:

```bash
kubectl apply -f kubernetes/postgresql/
kubectl port-forward svc/grafana 3000:3000
```

---

## Stack

| Component | Role |
|-----------|------|
| PostgreSQL / MySQL / MongoDB / Redis | Target databases |
| postgres_exporter / mysqld_exporter / mongodb_exporter / redis_exporter | Metrics exposition |
| Prometheus | Metrics collection & storage |
| Grafana | Dashboards & alerting |
| Docker Compose | Local orchestration |
| Kubernetes | Production orchestration |

---

## Key Learnings

- Unified observability patterns across heterogeneous database engines
- Exporter configuration per database type (auth, TLS, scrape intervals)
- Prometheus scrape job design and label management at scale
- Grafana dashboard templating for multi-instance visibility
- Kubernetes resource design: Deployments, Services, ConfigMaps, Secrets
