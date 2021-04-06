
## create custom /etc/hosts file

```
$ kubectl create configmap customhosts --from-literal=hosts="$(cat hosts.txt)"

$ kubectl get configmap customhosts -o yaml > customhosts.yaml
```


https://kubernetes.io/docs/concepts/services-networking/add-entries-to-pod-etc-hosts-with-host-aliases/

