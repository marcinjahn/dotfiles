---
name: check-production-logs
description: Checks app logs and/or metrics to see what issues are present with app on Production
environment. Use when some issue needs to be investigated based on logs, metrics or traces.
---

# Accessing Production Observability Sources

Use the esky-mcp-proxy to access:

- application logs (es*logs_pro\*\*set of tools) - shows logs produced by app containers in
  kubernetes, ALWAYS USE THE "apps_filebeat-*" INDEX FOR THAT!
  Ignore the "dotnet-apps-filebeat\*" index, we don't use it in our team.
- HTTP-level logs (es_logs_pro*set of tools) - every app we have has envoy sidecar, which
  intercepts all incoming requests to a given app. It will show URL of the request, headers, response
  status, etc. Use the "accesslog-filebeat-*" index for that.
- traces - our backend apps use opentelemetry for tracing, and you can find them in apm.
- metrics - use the "grafana_sre\*" tools

For backend apps, use `kubernetes.labels.app` to filter proper app in kibana/es. For frontend apps' (HOT and JAN)
client-side logs, use `app_name` with value either "nx-jan" or "nx-hot"

Ignore the "wiki" set of tools - it's useless.

## Timezone

When I give you time information, ALWAYS ASSUME CES timezone.
