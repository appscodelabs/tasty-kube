#!/bin/bash
set -x

kubectl create rolebinding psp:kube-dns --clusterrole=psp:privilged --serviceaccount=kube-system:kube-dns --namespace=kube-system
kubectl create rolebinding psp:kube-proxy --clusterrole=psp:privilged --serviceaccount=kube-system:kube-proxy --namespace=kube-system
kubectl create rolebinding psp:default --clusterrole=psp:privilged --serviceaccount=kube-system:default --namespace=kube-system
kubectl create rolebinding psp:storage-provisioner --clusterrole=psp:privilged --serviceaccount=kube-system:storage-provisioner --namespace=kube-system
