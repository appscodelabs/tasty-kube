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

$ kubectl get pods -n kube-system
NAME                               READY   STATUS    RESTARTS   AGE
coredns-86c58d9df4-rktbt           1/1     Running   0          2m29s
coredns-86c58d9df4-vpw8x           1/1     Running   0          2m29s
etcd-minikube                      1/1     Running   0          84s
kube-addon-manager-minikube        1/1     Running   0          84s
kube-apiserver-minikube            1/1     Running   0          96s
kube-controller-manager-minikube   1/1     Running   0          96s
kube-proxy-mn2qm                   1/1     Running   0          2m29s
kube-scheduler-minikube            1/1     Running   0          93s
storage-provisioner                1/1     Running   0          2m24s

$ kubectl create -f psp.yaml
podsecuritypolicy.extensions "default" created
podsecuritypolicy.extensions "privileged" created
```
