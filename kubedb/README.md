```
helm install kubedb appscode/kubedb \
  --version v2022.05.24 \
  --namespace kubedb --create-namespace \
  --set kubedb-provisioner.enabled=true \
  --set kubedb-ops-manager.enabled=false \
  --set kubedb-autoscaler.enabled=false \
  --set kubedb-dashboard.enabled=false \
  --set kubedb-schema-manager.enabled=false \
  --set-file global.license=/Users/tamal/Downloads/kubedb-enterprise-license-b0ef3184-79a8-4f8f-b105-b64d6f9ff49f.txt
```
