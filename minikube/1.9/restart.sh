#!/bin/bash
set -xeou pipefail

minikube delete || true
# https://github.com/kubernetes/kubeadm/issues/629
minikube start \
  --extra-config=apiserver.Admission.PluginNames="NamespaceLifecycle,LimitRanger,ServiceAccount,PersistentVolumeLabel,DefaultStorageClass,DefaultTolerationSeconds,MutatingAdmissionWebhook,ValidatingAdmissionWebhook,ResourceQuota"
 
