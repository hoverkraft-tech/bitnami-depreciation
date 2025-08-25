#!/bin/bash

set -eu -o pipefail

helm repo add kyverno https://kyverno.github.io/kyverno/
helm repo update kyverno

helm upgrade kyverno kyverno/kyverno \
  --install \
  --wait \
  --namespace kyverno \
  --create-namespace \
  -f values.yaml \
  --version 3.5.1
