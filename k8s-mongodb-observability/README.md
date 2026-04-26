# MongoDB Observability

This directory contains the Kubernetes manifests and configurations for setting up MongoDB observability using Prometheus and Grafana.

## Components

### 1. MongoDB StatefulSet
- **File**: `mongodb/mongodb-statefulset.yaml`
- Deploys a MongoDB instance with persistent storage.
- Uses a Kubernetes Secret (`mongodb-secret`) for credentials and connection URI.

### 2. MongoDB Exporter
- **File**: `mongodb-exporter/mongodb-exporter-values.yaml`
- Prometheus exporter for MongoDB metrics.
- Collects database stats, collection stats, and diagnostic data.
- Configured to use the `mongodb-secret` for the connection URI.

### 3. Prometheus ServiceMonitor
- **File**: `mongodb-exporter/mongodb-exporter-values.yaml`
- Configures Prometheus to scrape metrics from the MongoDB exporter.

### 4. Grafana Dashboard

To better understand the MongoDB observability setup, refer to the dashboard image below. It provides a clear visualization of the metrics and insights available for monitoring MongoDB:

![MongoDB Dashboard](assets/mongodb-dashboard.png)

---

## Prerequisites

1. **Kubernetes Cluster**:
   - Ensure you have a running Kubernetes cluster.

2. **Helm**:
   - Install Helm for managing the MongoDB exporter.

3. **Prometheus and Grafana**:
   - Ensure Prometheus and Grafana are deployed in your cluster.

## Setup Instructions

### 1. Deploy MongoDB
```bash
kubectl apply -f mongodb/mongodb-statefulset.yaml
kubectl apply -f mongodb/mongodb-service.yaml
kubectl apply -f mongodb/mongodb-secret.yaml
```

### 2. Deploy MongoDB Exporter
```bash
helm upgrade --install mongodb-exporter prometheus-community/prometheus-mongodb-exporter \
  -n mongodb -f mongodb-exporter/mongodb-exporter-values.yaml
```

### 3. Configure Prometheus
- Ensure Prometheus is configured to scrape the MongoDB exporter metrics.
- Verify the `ServiceMonitor` is applied:
```bash
kubectl describe servicemonitor mongodb-exporter-prometheus-mongodb-exporter -n mongodb
```

### 4. Import Grafana Dashboard
- Import the MongoDB dashboard JSON file from the `grafana/` directory into Grafana.

## Verification

1. **Check MongoDB Exporter Logs**:
```bash
kubectl logs -n mongodb -l app.kubernetes.io/name=prometheus-mongodb-exporter
```

2. **Test Metrics Endpoint**:
```bash
kubectl port-forward svc/mongodb-exporter-prometheus-mongodb-exporter 9216:9216 -n mongodb
curl http://127.0.0.1:9216/metrics
```

3. **View Metrics in Grafana**:
- Open Grafana and navigate to the MongoDB dashboard.

## Troubleshooting

- **Invalid DSN Error**:
  - Ensure the `CONNECTION_URI` in `mongodb-secret` is correctly formatted.
  - Recreate the secret if necessary:
```bash
kubectl delete secret mongodb-secret -n mongodb
kubectl create secret generic mongodb-secret -n mongodb \
  --from-literal=MONGO_INITDB_ROOT_USERNAME=admin \
  --from-literal=MONGO_INITDB_ROOT_PASSWORD=password123 \
  --from-literal=CONNECTION_URI="mongodb://admin:password123@mongodb.mongodb.svc.cluster.local:27017"
```

- **No Metrics in Grafana**:
  - Verify Prometheus is scraping the MongoDB exporter metrics.
  - Check the MongoDB exporter logs for errors.

## References
- [Prometheus MongoDB Exporter](https://github.com/percona/mongodb_exporter)
- [Helm Chart for MongoDB Exporter](https://artifacthub.io/packages/helm/prometheus-community/prometheus-mongodb-exporter)