# Kyverno Bitnami Image Replacement Workaround

This directory contains a Kyverno policy that automatically replaces Bitnami Docker images with their legacy equivalents to work around Docker Hub rate limiting and deprecation issues.

## Overview

The policy intercepts Pod creation and mutates container images that use the `bitnami/` namespace, replacing them with `bitnamilegacy/` alternatives. This ensures continued functionality while Bitnami transitions their image distribution strategy.

## Files

- `replace-image-bitnami.yaml` - Main Kyverno ClusterPolicy
- `setup.sh` - Installation script
- `values.yaml` - Kyverno Helm chart values
- `tests/` - Test cases for validation

## How It Works

The policy uses a precise regex pattern `(^|/)bitnami/` to match:

- Images starting with `bitnami/` (e.g., `bitnami/postgresql:15`)
- Images with registry prefixes (e.g., `docker.io/bitnami/mysql:8.0`)

**Transformations:**

- `bitnami/postgresql:15` → `bitnamilegacy/postgresql:15`
- `registry.com/bitnami/nginx:latest` → `registry.com/bitnamilegacy/nginx:latest`
- `notbitnami/custom` → `notbitnami/custom` (unchanged - avoids false positives)

## Installation

1. Install Kyverno if not already present:

```bash
helm repo add kyverno https://kyverno.github.io/kyverno/
helm install kyverno kyverno/kyverno -n kyverno --create-namespace -f values.yaml
```

2. Apply the image replacement policy:

```bash
kubectl apply -f replace-image-bitnami.yaml
```

Or use the setup script:

```bash
./setup.sh
```

## Testing

Test the policy with the provided test cases:

```bash
# Test legitimate Bitnami images (should be replaced)
kubectl apply -f tests/bitnami.yaml
kubectl get pods -o jsonpath='{.items[*].spec.containers[*].image}'

# Test edge cases (should NOT be replaced)
kubectl apply -f tests/edge-case.yaml
kubectl apply -f tests/other.yaml

# Cleanup
kubectl delete -f tests/
```

## Policy Scope

- **Applies to:** Pod containers and init containers
- **Background processing:** Disabled (only affects new Pods)
- **Matching:** All Pods in all namespaces

## Limitations

- Only affects new Pod creation, not existing running Pods
- Requires the `bitnamilegacy/` images to be available in the target registry
- Does not modify Deployment/StatefulSet templates directly (only the resulting Pods)

## Troubleshooting

Check policy status:

```bash
kubectl get clusterpolicy replace-image-bitnami-legacy
kubectl describe clusterpolicy replace-image-bitnami-legacy
```

View Kyverno logs:

```bash
kubectl logs -n kyverno -l app.kubernetes.io/name=kyverno
```
