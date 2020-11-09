# metrics-server

## Install in KIND

```
helm install metrics-server stable/metrics-server -n kube-system --set=args={--kubelet-insecure-tls}

kubectl top
```

ref: https://github.com/kubernetes-sigs/kind/issues/398#issuecomment-699529874
