# OpenTelemetry Operator with Coralogix Integration Example

This repository contains an example application that demonstrates how to use the OpenTelemetry Operator to automatically instrument Python applications in a Kubernetes cluster and send telemetry data to Coralogix.

## Overview

The example consists of three microservices (`app1`, `app2`, and `app3`) that communicate with each other. The OpenTelemetry Operator automatically injects instrumentation into these applications, enabling distributed tracing and metrics collection without modifying the application code.

## Prerequisites

- A Kubernetes cluster (version 1.16 or later)
- `kubectl` configured to access your cluster
- OpenTelemetry Operator installed in your cluster
- Coralogix account and credentials
- Docker installed locally (for building application images)

## Architecture

The example includes:
- Three Python microservices (`app1`, `app2`, `app3`)
- Kubernetes deployments and services for each application
- OpenTelemetry instrumentation injection via annotations
- Service accounts for each application
- Automatic correlation of traces between services

## Configuration

The applications are configured to be automatically instrumented using the following annotations in the deployment manifests:

```yaml
annotations:
  instrumentation.opentelemetry.io/inject-python: "true"
```

## Verifying the Setup

1. Check that the pods are running:
   ```bash
   kubectl get pods
   ```

2. Verify that the OpenTelemetry instrumentation is injected:
   ```bash
   kubectl describe pod <pod-name>
   ```

3. Access the applications and verify that traces are being sent to Coralogix.

## Cleanup

To remove all deployed resources:
```bash
make clean
```
