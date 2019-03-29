# How to create a Audit Sink-enabled Minikube cluster?

```console
$ minikube start \
      --kubernetes-version=v1.14.0 \
      --extra-config=apiserver.audit-dynamic-configuration=true \
      --extra-config=apiserver.feature-gates=DynamicAuditing=true \
      --extra-config=apiserver.runtime-config=auditregistration.k8s.io/v1alpha1=true

😄  minikube v1.0.0 on linux (amd64)
🤹  Downloading Kubernetes v1.14.0 images in the background ...
🔥  Creating virtualbox VM (CPUs=2, Memory=2048MB, Disk=20000MB) ...
📶  "minikube" IP address is 192.168.99.100
🐳  Configuring Docker as the container runtime ...
🐳  Version of container runtime is 18.06.2-ce
⌛  Waiting for image downloads to complete ...
✨  Preparing Kubernetes environment ...
    ▪ apiserver.audit-dynamic-configuration=true
    ▪ apiserver.feature-gates=DynamicAuditing=true
    ▪ apiserver.runtime-config=auditregistration.k8s.io/v1alpha1=true
🚜  Pulling images required by Kubernetes v1.14.0 ...
🚀  Launching Kubernetes v1.14.0 using kubeadm ... 
⌛  Waiting for pods: apiserver proxy etcd scheduler controller dns
🔑  Configuring cluster permissions ...
🤔  Verifying component health .....
💗  kubectl is now configured to use "minikube"
🏄  Done! Thank you for using minikube!


$ kubectl api-resources | grep audit
auditsinks                                     auditregistration.k8s.io       false        AuditSink
```


## Audit Sink
https://github.com/kubernetes/enhancements/blob/master/keps/sig-auth/0014-dynamic-audit-configuration.md#story-4

### API Objects:
https://github.com/kubernetes/api/blob/kubernetes-1.14.0/auditregistration/v1alpha1/types.go#L60

https://github.com/kubernetes/apiserver/blob/kubernetes-1.14.0/pkg/apis/audit/v1/types.go#L69

### Video Explainer
https://youtu.be/7woxnh1lv0w
