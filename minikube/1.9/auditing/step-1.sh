#!/bin/bash

set -xeou pipefail

cat <<EOF > ~/.minikube/files/audit-policy.yaml
# Log all requests at the Metadata level.
apiVersion: audit.k8s.io/v1beta1
kind: Policy
rules:
- level: Metadata
EOF

minikube delete || true
minikube start \
--kubernetes-version=v1.9.0 \
--bootstrapper=kubeadm --extra-config=apiserver.admission-control="NamespaceLifecycle,LimitRanger,ServiceAccount,PersistentVolumeLabel,DefaultStorageClass,ValidatingAdmissionWebhook,ResourceQuota,DefaultTolerationSeconds,MutatingAdmissionWebhook" \
--mount --mount-string="$HOME/.minikube/files:/tmp/data" \
--feature-gates=AdvancedAuditing=true \
--extra-config=apiserver.audit-log-path=/tmp/data/audit.log
