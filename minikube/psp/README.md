```console
$ ./restart.sh
+ minikube delete
Deleting local Kubernetes cluster...
Machine deleted.
+ minikube start --extra-config=apiserver.feature-gates=CustomResourceSubresources=true --extra-config=apiserver.admission-control=NamespaceLifecycle,LimitRanger,ServiceAccount,DefaultStorageClass,DefaultTolerationSeconds,NodeRestriction,PodSecurityPolicy,MutatingAdmissionWebhook,ValidatingAdmissionWebhook,ResourceQuota
Starting local Kubernetes v1.10.0 cluster...
Starting VM...
Getting VM IP address...
Moving files into cluster...
Setting up certs...
Connecting to cluster...
Setting up kubeconfig...
Starting cluster components...
Kubectl is now configured to use the cluster.
Loading cached images from config file.

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
