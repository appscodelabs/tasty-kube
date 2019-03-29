#!/bin/bash
set -xeou pipefail

minikube delete || true
minikube start \
  --kubernetes-version=v1.14.0 \
  --extra-config=apiserver.audit-dynamic-configuration=true \
  --extra-config=apiserver.feature-gates=DynamicAuditing=true \
  --extra-config=apiserver.runtime-config=auditregistration.k8s.io/v1alpha1=true

