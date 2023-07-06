# PSP in k3s.io

```yaml
apiVersion: policy/v1beta1
kind: PodSecurityPolicy
metadata:
  name: permissive
  annotations:
    seccomp.security.alpha.kubernetes.io/allowedProfileNames: '*'
spec:
  privileged: true
  allowPrivilegeEscalation: true
  allowedCapabilities:
  - '*'
  volumes:
  - '*'
  hostNetwork: true
  hostPorts:
  - min: 0
    max: 65535
  hostIPC: true
  hostPID: true
  runAsUser:
    rule: 'RunAsAny'
  seLinux:
    rule: 'RunAsAny'
  supplementalGroups:
    rule: 'RunAsAny'
  fsGroup:
    rule: 'RunAsAny'
---
# A ClusterRole that allows using the permissive PSP above
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: permissive-psp
rules:
- apiGroups:
  - policy
  resourceNames:
  - permissive
  resources:
  - podsecuritypolicies
  verbs:
  - use
---
# Allow all service accounts in kube-system to use the permissive PSP
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: permissive-psp
  namespace: kube-system
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: permissive-psp
subjects:
- kind: Group
  name: system:serviceaccounts
```

```bash
curl -sfL https://get.k3s.io | INSTALL_K3S_CHANNEL=v1.22 INSTALL_K3S_EXEC="--disable=traefik --kube-apiserver-arg enable-admission-plugins=PodSecurityPolicy,NodeRestriction" sh -

sudo chown $(id -u):$(id -g) /etc/rancher/k3s/k3s.yaml
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
kubectl get nodes
kubectl get pods -A
```

```bash
/usr/local/bin/k3s-uninstall.sh
```
