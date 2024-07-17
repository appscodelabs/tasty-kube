# dnstools

- https://coredns.io/2017/05/08/custom-dns-entries-for-kubernetes/
- https://coredns.io/manual/configuration/
- https://github.com/k3s-io/k3s/pull/4397

```
envsubst < custom-dns.yaml  | kubectl apply -f -
kubectl delete pods -n kube-system -l k8s-app=kube-dns

kubectl run -it --rm --restart=Never --image=infoblox/dnstools:latest dnstools

dig +short ace.internal
```
