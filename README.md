# tasty-kube

**Trigger pod restarts for a Deployment**
```console
kubectl patch deployment test-server -p '{"spec":{"template":{"metadata":{"annotations":{"myhack/timehack": "timestamp"}}}}}'
```
