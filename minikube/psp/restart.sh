#!/bin/bash
set -xeou pipefail

minikube delete || true
minikube start \
  --kubernetes-version=v1.13.3 \
  --extra-config=apiserver.enable-admission-plugins="NamespaceLifecycle,LimitRanger,ServiceAccount,DefaultStorageClass,DefaultTolerationSeconds,MutatingAdmissionWebhook,ValidatingAdmissionWebhook,Priority,ResourceQuota"