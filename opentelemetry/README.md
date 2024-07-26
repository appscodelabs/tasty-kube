### Setup ClickHouse:

#### Install Zookeeper

```bash
helm install zookeeper -n monitoring oci://registry-1.docker.io/bitnamicharts/zookeeper \
    --set zookeeper.enabled=false \
    --set persistence.size=100Mi \
    --set replicaCount=1  
```

#### Install ClickHouse Operator

```bash
 helm install clickhouse-operator clickhouse-operator/altinity-clickhouse-operator -n monitoring
```

#### Deploy ClickHouse DB

```bash
kubectl apply -f ./clickhouse.yaml
```

#### Create Database

```
kubectl exec -it -n monitoring chi-clickhouse-cluster-0-0-0 -- bash

chi-clickhouse-cluster-0-0-0:/# clickhouse-client
> create database otel;
```
### Install OpenTelemetry

```bash
helm install opentelemetry-kube-stack -n monitoring open-telemetry/opentelemetry-kube-stack \
    --set opentelemetry-operator.admissionWebhooks.certManager.enabled=false \
    --set admissionWebhooks.autoGenerateCert.enabled=true \
    --values=./values.yaml

```