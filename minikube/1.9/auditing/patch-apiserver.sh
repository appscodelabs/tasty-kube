#!/bin/bash
set -xeuo pipefail

curl -o kubernetes-client-linux-amd64.tar.gz https://dl.k8s.io/v1.9.0/kubernetes-client-linux-amd64.tar.gz \
  && tar -xzvf kubernetes-client-linux-amd64.tar.gz
