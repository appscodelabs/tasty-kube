#!/bin/bash

kubectl create -f https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/policy/privileged-psp.yaml
kubectl create -f https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/policy/baseline-psp.yaml
kubectl create -f https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/policy/restricted-psp.yaml

kubectl create -f ./cluster-roles.yaml
kubectl create -f ./role-bindings.yaml
