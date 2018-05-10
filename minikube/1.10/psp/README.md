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

$ kubectl apply -f psp.yaml
podsecuritypolicy.extensions "default" created
podsecuritypolicy.extensions "privileged" created

$ kubectl apply -f cluster-roles.yaml
clusterrole.rbac.authorization.k8s.io "psp:privileged" created
clusterrole.rbac.authorization.k8s.io "psp:default" created

$ kubectl apply -f role-bindings.yaml
rolebinding.rbac.authorization.k8s.io "minikube" created

$ kubectl get pods -n kube-system
NAME                                    READY     STATUS    RESTARTS   AGE
kube-dns-86f4d74b45-tgwrc               3/3       Running   0          3m
kube-proxy-42lrc                        1/1       Running   0          3m
kubernetes-dashboard-5498ccf677-mp25g   1/1       Running   0          3m
storage-provisioner                     1/1       Running   3          4m

```

- https://github.com/tigera/tectonic-installer/commit/cbb466e8db57393ab0cedaac2ec0993dfcc5fb40
- https://kubernetes.slack.com/archives/C2P1JHS2E/p1525922158000046
- https://files.slack.com/files-pri/T09NY5SBT-F7RCJUKS6/ClusterRoleBindings.yaml
