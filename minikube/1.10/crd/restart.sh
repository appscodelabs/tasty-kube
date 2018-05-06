#!/bin/bash
set -xeou pipefail

minikube delete || true
minikube start \
  --extra-config=apiserver.feature-gates=CustomResourceSubresources=true
