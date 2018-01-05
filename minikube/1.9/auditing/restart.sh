#!/bin/bash

set -xeou pipefail

minikube delete || true
minikube start \
--kubernetes-version=v1.9.0 \
--bootstrapper=kubeadm --extra-config=apiserver.admission-control="NamespaceLifecycle,LimitRanger,ServiceAccount,PersistentVolumeLabel,DefaultStorageClass,ValidatingAdmissionWebhook,ResourceQuota,DefaultTolerationSeconds,MutatingAdmissionWebhook" \
--feature-gates=AdvancedAuditing=true \
--extra-config=apiserver.audit-log-path=/tmp/data/audit.log
