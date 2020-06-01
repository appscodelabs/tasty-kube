#!/bin/bash

kubectl apply -f https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/policy/privileged-psp.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/policy/baseline-psp.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/policy/restricted-psp.yaml

kubectl apply -f https://github.com/appscodelabs/tasty-kube/raw/master/minikube/psp/cluster-roles.yaml
kubectl apply -f https://github.com/appscodelabs/tasty-kube/raw/master/minikube/psp/role-bindings.yaml
