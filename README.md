# tasty-kube

**Trigger pod restarts for a Deployment**
```console
kubectl patch deployment test-server -p '{"spec":{"template":{"metadata":{"annotations":{"myhack/timehack": "timestamp"}}}}}'
```

**sort pods by node names**
```
kubectl get pods --all-namespaces -o=custom-columns=NAME:.metadata.name,NAMESPACE:.metadata.namespace,NODE:.spec.nodeName --sort-by=.spec.nodeName
```

### FAQ
- `failed to create sandbox` means that the kubelet can't bring up the pause container or CNI started causing IP to change.
