#!/bin/bash
set -xeou pipefail

minikube delete || true
# https://github.com/kubernetes/kubeadm/issues/629
minikube start \
  --kubernetes-version=v1.9.0 \
  --bootstrapper=kubeadm \
  --extra-config=apiserver.admission-control="NamespaceLifecycle,LimitRanger,ServiceAccount,PersistentVolumeLabel,DefaultStorageClass,ValidatingAdmissionWebhook,ResourceQuota,DefaultTolerationSeconds,MutatingAdmissionWebhook"
 
