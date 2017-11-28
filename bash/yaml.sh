#!/bin/bash

set -x

echo "
apiVersion: v1
kind: Namespace
metadata:
  name: concat
" | kubectl create -f -

ACME_EMAIL=$(echo -n 'me@gmail.com' | base64)
echo "
kind: Secret
apiVersion: v1
metadata:
  name: acme-account
  namespace: concat
data:
  ACME_EMAIL: $ACME_EMAIL
" | kubectl create -f -
