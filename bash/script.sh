#! /bin/bash

kubectl create ns demo
kubectl create secret generic acme-account -n demo --from-literal=ACME_EMAIL=me@gmail.com
