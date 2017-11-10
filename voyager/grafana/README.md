**Grafana Password**
```console
kubectl create secret generic grafana-grafana --from-literal=user=admin --from-literal=password=admin
```


**Ingress Basic Auth Secret**
```console
kubectl create secret generic ing-pass --from-literal=auth=admin::admin
```
