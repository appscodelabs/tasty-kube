#!/bin/bash
set -xeou pipefail

minikube delete || true
minikube start \
  --extra-config=apiserver.feature-gates=CustomResourceSubresources=true \
  --extra-config=apiserver.admission-control="NamespaceLifecycle,LimitRanger,ServiceAccount,DefaultStorageClass,DefaultTolerationSeconds,NodeRestriction,PodSecurityPolicy,MutatingAdmissionWebhook,ValidatingAdmissionWebhook,ResourceQuota"
