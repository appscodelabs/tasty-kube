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

$ ./role-bindings.sh
+ kubectl create rolebinding psp:kube-dns --clusterrole=psp:privilged --serviceaccount=kube-system:kube-dns --namespace=kube-system
rolebinding.rbac.authorization.k8s.io "psp:kube-dns" created
+ kubectl create rolebinding psp:kube-proxy --clusterrole=psp:privilged --serviceaccount=kube-system:kube-proxy --namespace=kube-system
rolebinding.rbac.authorization.k8s.io "psp:kube-proxy" created
+ kubectl create rolebinding psp:default --clusterrole=psp:privilged --serviceaccount=kube-system:default --namespace=kube-system
rolebinding.rbac.authorization.k8s.io "psp:default" created
+ kubectl create rolebinding psp:storage-provisioner --clusterrole=psp:privilged --serviceaccount=kube-system:storage-provisioner --namespace=kube-system
rolebinding.rbac.authorization.k8s.io "psp:storage-provisioner" created
