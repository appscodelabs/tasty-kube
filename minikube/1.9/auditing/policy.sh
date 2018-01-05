#! /bin/bash

cat <<EOF > ~/.minikube/files/audit-policy.yaml
# Log all requests at the Metadata level.
apiVersion: audit.k8s.io/v1beta1
kind: Policy
rules:
- level: Metadata
EOF
