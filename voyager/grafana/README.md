**Grafana Password**
```console
kubectl create secret generic grafana-grafana --from-literal=user=admin --from-literal=password=admin
```


**Ingress Basic Auth Secret**
```console
kubectl create secret generic ing-pass --from-literal=auth=admin::admin
```


**Deploy Grafana**
```console
kubectl apply -f https://raw.githubusercontent.com/tamalsaha/tasty-kube/master/voyager/grafana/deploy.yaml
```


```console
minikube service list
```
