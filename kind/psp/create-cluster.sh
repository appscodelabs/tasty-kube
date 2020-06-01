#!/bin/bash

# kind create cluster --config kind-psp.yaml

# https://kubernetes.io/docs/concepts/security/pod-security-standards/

kubectl create -f https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/policy/privileged-psp.yaml
kubectl create -f https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/policy/baseline-psp.yaml
kubectl create -f https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/policy/restricted-psp.yaml
