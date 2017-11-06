# tasty-kube

**Trigger pod restarts for a Deployment**
```console
kubectl patch deployment test-server -p '{"spec":{"template":{"metadata":{"annotations":{"myhack/timehack": "timestamp"}}}}}'
```

### FAQ
- failed to create sandbox means that the kubelet can't bring up the pause container or CNI started causing IP to change.
