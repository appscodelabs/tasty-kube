#!/bin/bash

kubectl apply -f https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/policy/privileged-psp.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/policy/baseline-psp.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/policy/restricted-psp.yaml

kubectl apply -f ./cluster-roles.yaml
kubectl apply -f ./role-bindings.yaml
