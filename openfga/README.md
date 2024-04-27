# openfga

- https://github.com/openfga/helm-charts

```bash
$ helm repo add openfga https://openfga.github.io/helm-charts

$ helm install openfga openfga/openfga \
  --values=values.yaml --wait
```


```bash
flux install \
--namespace=flux-system \
--network-policy=false \
--components=source-controller,helm-controller

k apply -f hr.yaml
```
