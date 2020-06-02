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
$ kubectl get pods --all-namespaces

NAMESPACE            NAME                                         READY   STATUS    RESTARTS   AGE
kube-system          coredns-66bff467f8-77mn6                     1/1     Running   0          46s
kube-system          coredns-66bff467f8-qsvhl                     1/1     Running   0          46s
kube-system          kindnet-5hrg2                                1/1     Running   0          67s
kube-system          kindnet-7jl9t                                1/1     Running   0          66s
kube-system          kube-apiserver-kind-control-plane            1/1     Running   0          59s
kube-system          kube-controller-manager-kind-control-plane   1/1     Running   0          59s
kube-system          kube-proxy-cxr7f                             1/1     Running   0          67s
kube-system          kube-proxy-z7w5j                             1/1     Running   0          66s
kube-system          kube-scheduler-kind-control-plane            1/1     Running   0          12s
local-path-storage   local-path-provisioner-bd4bb6b75-x4zmq       1/1     Running   0          46s
```

4. Create a test pod to check everything is working.

```console
kubectl apply -f https://github.com/appscodelabs/tasty-kube/raw/master/kind/pod.yaml
```

## PSP enabled KIND cluster in GitHub Actions

https://github.com/tamalsaha/psp-kind-actions-demo

