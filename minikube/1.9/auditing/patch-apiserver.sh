#!/bin/bash
set -xeuo pipefail

wget https://dl.k8s.io/v1.9.0/kubernetes-client-linux-amd64.tar.gz \
  && tar -xzvf kubernetes-client-linux-amd64.tar.gz
