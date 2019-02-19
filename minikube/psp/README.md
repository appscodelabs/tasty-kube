# How to create a PSP-enabled Minikube cluster?

```console
$ ./restart.sh
+ minikube delete
🔥  Deleting "minikube" from virtualbox ...
💔  The "minikube" cluster has been deleted.
+ minikube start --kubernetes-version=v1.13.3 --extra-config=apiserver.enable-admission-plugins=NamespaceLifecycle,LimitRanger,ServiceAccount,DefaultStorageClass,DefaultTolerationSeconds,MutatingAdmissionWebhook,ValidatingAdmissionWebhook,Priority,ResourceQuota
😄  minikube v0.34.1 on linux (amd64)
🔥  Creating virtualbox VM (CPUs=2, Memory=2048MB, Disk=20000MB) ...
📶  "minikube" IP address is 192.168.99.100
🐳  Configuring Docker as the container runtime ...
✨  Preparing Kubernetes environment ...
    ▪ apiserver.enable-admission-plugins=NamespaceLifecycle,LimitRanger,ServiceAccount,DefaultStorageClass,DefaultTolerationSeconds,MutatingAdmissionWebhook,ValidatingAdmissionWebhook,Priority,ResourceQuota
🚜  Pulling images required by Kubernetes v1.13.3 ...
🚀  Launching Kubernetes v1.13.3 using kubeadm ...
🔑  Configuring cluster permissions ...
🤔  Verifying component health .....
💗  kubectl is now configured to use "minikube"
🏄  Done! Thank you for using minikube!

$ kubectl create -f psp.yaml
podsecuritypolicy.policy/default created
podsecuritypolicy.policy/privileged created

$ kubectl auth reconcile -f cluster-roles.yaml
clusterrole.rbac.authorization.k8s.io/psp:privileged reconciled
clusterrole.rbac.authorization.k8s.io/psp:default reconciled

$ kubectl auth reconcile -f role-bindings.yaml
rolebinding.rbac.authorization.k8s.io/minikube reconciled

$ kubectl get pods -n kube-system
NAME                               READY   STATUS    RESTARTS   AGE
coredns-86c58d9df4-7f6k6           1/1     Running   0          91s
coredns-86c58d9df4-wb9r7           1/1     Running   0          91s
etcd-minikube                      1/1     Running   0          63s
kube-addon-manager-minikube        1/1     Running   0          28s
kube-apiserver-minikube            1/1     Running   0          99s
kube-controller-manager-minikube   1/1     Running   0          70s
kube-proxy-2pbzz                   1/1     Running   0          90s
kube-scheduler-minikube            1/1     Running   0          103s
storage-provisioner                1/1     Running   3          3m13s
```

## Additional Info
- https://github.com/tigera/tectonic-installer/commit/cbb466e8db57393ab0cedaac2ec0993dfcc5fb40
- https://kubernetes.slack.com/archives/C2P1JHS2E/p1525922158000046
- https://files.slack.com/files-pri/T09NY5SBT-F7RCJUKS6/ClusterRoleBindings.yaml
