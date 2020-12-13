# metrics-server

## Install in KIND

```
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
