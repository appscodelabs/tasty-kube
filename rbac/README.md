## Disable RBAC (by giving unauthenticated cluster-admin permission)
```
kubectl create clusterrolebinding anon-admin-binding --clusterrole=cluster-admin --group=system:unauthenticated
```
