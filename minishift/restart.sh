#!/bin/bash
set -xeou pipefail

minishift delete -f || true
minishift start --vm-driver=virtualbox
