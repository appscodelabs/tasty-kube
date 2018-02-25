#!/bin/bash
set -xeou pipefail

minishift delete || true
minishift start --vm-driver=virtualbox
