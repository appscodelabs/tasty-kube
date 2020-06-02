# How to create a PSP-enabled KIND cluster?

1. Create cluster

```console
kind create cluster --config https://raw.githubusercontent.com/appscodelabs/tasty-kube/master/kind/psp/kind-psp.yaml
```

2. Create PSP and rbac.

```console
kubectl apply -f https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/policy/privileged-psp.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/policy/baseline-psp.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/policy/restricted-psp.yaml

kubectl apply -f https://github.com/appscodelabs/tasty-kube/raw/master/minikube/psp/cluster-roles.yaml
kubectl apply -f https://github.com/appscodelabs/tasty-kube/raw/master/minikube/psp/role-bindings.yaml
```
