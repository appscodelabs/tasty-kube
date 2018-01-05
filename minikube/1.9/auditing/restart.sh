#!/bin/bash

set -xeou pipefail

mkdir -p ~/.minikube/files
curl -fsSL https://raw.githubusercontent.com/tamalsaha/tasty-kube/master/minikube/1.9/auditing/kube-apiserver.yaml > ~/.minikube/files/kube-apiserver.yaml
curl -fsSL https://raw.githubusercontent.com/tamalsaha/tasty-kube/master/minikube/1.9/auditing/audit-policy.yaml > ~/.minikube/files/audit-policy.yaml

minikube delete || true
minikube start \
--kubernetes-version=v1.9.0 \
--bootstrapper=kubeadm --extra-config=apiserver.admission-control="NamespaceLifecycle,LimitRanger,ServiceAccount,DefaultStorageClass,ValidatingAdmissionWebhook,ResourceQuota,DefaultTolerationSeconds,MutatingAdmissionWebhook" \
--mount --mount-string="$HOME/.minikube/files:/tmp/files" \
--feature-gates=AdvancedAuditing=true \
--extra-config=apiserver.audit-log-path=/tmp/files/audit.log
