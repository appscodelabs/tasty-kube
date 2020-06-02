# How to create a PSP-enabled KIND cluster?

1. Create cluster

```console
curl -sL https://github.com/appscodelabs/tasty-kube/raw/master/kind/psp/kind-psp.yaml > /tmp/kind-psp.yaml
kind create cluster --config /tmp/kind-psp.yaml
```

2. Create PSP and rbac.

```console
kubectl apply -f https://github.com/appscodelabs/tasty-kube/raw/master/psp/privileged-psp.yaml
kubectl apply -f https://github.com/appscodelabs/tasty-kube/raw/master/psp/baseline-psp.yaml
kubectl apply -f https://github.com/appscodelabs/tasty-kube/raw/master/psp/restricted-psp.yaml

kubectl apply -f https://github.com/appscodelabs/tasty-kube/raw/master/kind/psp/cluster-roles.yaml
kubectl apply -f https://github.com/appscodelabs/tasty-kube/raw/master/kind/psp/role-bindings.yaml
```

3. Wait until all pods are RUNNING.

```console
```

4. Create a test pod to check everything is working.

```console
kubectl apply -f https://github.com/appscodelabs/tasty-kube/raw/master/kind/pod.yaml
```
