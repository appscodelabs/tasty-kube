# metrics-server

## Install in KIND

```
helm repo add stable https://charts.helm.sh/stable
helm repo update

helm install metrics-server stable/metrics-server -n kube-system --set=args={--kubelet-insecure-tls}

kubectl top
```

## LKE

```
helm install metrics-server stable/metrics-server -n kube-system \
 --set args[0]=--kubelet-preferred-address-types=InternalIP \
 --set args[1]=--kubelet-insecure-tls
```

ref: https://github.com/kubernetes-sigs/kind/issues/398#issuecomment-699529874

## Allocatable Resource

- https://kubernetes.io/docs/tasks/administer-cluster/reserve-compute-resources/
- https://learnk8s.io/allocatable-resources
- https://kops.sigs.k8s.io/node_resource_handling/
