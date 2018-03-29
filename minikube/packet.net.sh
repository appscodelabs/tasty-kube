#!/bin/bash

# Get a new Ubuntu 16.04 server on packet.net
curl -fsSL --retry 5 -o /etc/apt/sources.list https://raw.githubusercontent.com/pharmer/addons/master/ubuntu/16.04/sources.list
apt-get update
apt-get upgrade

apt install dkms linux-headers-$(uname -r) virtualbox

# 1.8.0
curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.24.1/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/

wget https://dl.k8s.io/v1.8.10/kubernetes-client-linux-amd64.tar.gz \
  && tar -zxvf kubernetes-client-linux-amd64.tar.gz \
  && mv kubernetes/client/bin/* /usr/local/bin

minikube delete; minikube start
kubectl get nodes

