# FastAPI Observability with Docker Compose

Monitor a FastAPI application in real-time using **Prometheus** + **Grafana**, all spun up with a single Docker Compose command.

---

## Architecture

```
FastAPI App (:8000)
    └── /metrics endpoint
          └── Prometheus (:9090) — scrapes every 10s
                └── Grafana (:3000) — visualizes metrics
```

---

## Setup

```bash
docker-compose up -d
```

Open Grafana at `http://localhost:3000` — login with `admin` / `admin`.

The **FastAPI Python Application Dashboard** auto-loads with panels for:
- Request Rate
- Average Response Time
- Memory Usage
- CPU Usage

---

## Simulate Traffic

Run the traffic simulation script to generate realistic metrics:

```bash
chmod +x simulate_traffic.sh
./simulate_traffic.sh
```

This runs 20 rounds of:
- **CRUD requests** — GET, POST, PUT, DELETE against `/items`
- **Errors** — 404s and 422s to simulate failure conditions
- **Memory pressure** — allocates ~200MB incrementally in the background

Watch the Grafana panels update in real-time as traffic flows through.

---

## File Structure

```
docker-compose-observability/
├── docker-compose.yaml               # All three services
├── prometheus.yml                    # Scrape config for FastAPI + Prometheus
├── grafana-dashboard.json            # FastAPI dashboard definition
├── grafana/
│   └── provisioning/
│       ├── datasources/
│       │   └── prometheus.yaml       # Auto-configures Prometheus datasource
│       └── dashboards/
│           └── dashboard.yaml        # Auto-loads dashboard on startup
├── simulate_traffic.sh               # Traffic + memory simulation script
└── fastapi-collection.json           # Postman collection for manual testing
```

---

## Useful Commands

```bash
# Check all containers are running
docker-compose ps

# View FastAPI logs
docker-compose logs fastapi-app

# Check Prometheus targets
open http://localhost:9090/targets

# Tear down
docker-compose down
```
