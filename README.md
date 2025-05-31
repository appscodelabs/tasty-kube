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

### Docker Hub login for KIND

```
docker login

for node_name in $(docker ps | awk 'NR>1 {print $NF}'); do
  # copy the config to where kubelet will look
  docker cp "$HOME/.docker/config.json" "${node_name}:/var/lib/kubelet/config.json"
  # restart kubelet to pick up the config
  docker exec "${node_name}" systemctl restart kubelet.service
done
```
