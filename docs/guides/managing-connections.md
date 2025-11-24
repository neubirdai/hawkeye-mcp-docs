# Managing Connections

Connect Hawkeye to your cloud providers and monitoring tools.

## Supported Connections

| Type | Use For | Setup Time |
|------|---------|------------|
| **AWS** | CloudWatch, EC2, RDS, Lambda, ECS | 10-15 min |
| **Azure** | Azure Monitor, VMs, Functions | 10-15 min |
| **GCP** | Cloud Logging, Monitoring, Compute | 10-15 min |
| **Datadog** | Logs, metrics, traces, APM | 5 min |
| **PagerDuty** | Alert management | 5 min |
| **New Relic** | APM, infrastructure | 5 min |

## AWS Connection

### Prerequisites

- AWS account with read-only access
- IAM role with permissions
- External ID for security

### Setup Steps

**1. Create IAM Role**

Ask Claude for help:

```
How do I create an AWS IAM role for Hawkeye?
```

**2. Create Connection**

```
Create an AWS connection named "Production AWS" with:
- Role ARN: arn:aws:iam::123456789012:role/HawkeyeReadOnly
- External ID: your-external-id
- Regions: us-east-1, us-west-2
```

**3. Wait for Sync**

```
Wait for my AWS connection to finish syncing
```

First sync takes 5-10 minutes.

## Datadog Connection

### Prerequisites

- Datadog API key
- Datadog Application key
- Datadog endpoint

### Setup

```
Create a Datadog connection named "Production Datadog" with:
- API Key: [your-api-key]
- App Key: [your-app-key]
- Endpoint: datadoghq.com
```

Syncs in 2-3 minutes.

## Connection Management

### List Connections

```
Show me all my connections
```

### Connection Details

```
Show me details for connection abc-123
```

### Add to Project

```
Add my AWS and Datadog connections to Production project
```

### Remove from Project

```
Remove Datadog connection from Staging project
```

## Troubleshooting

### Connection Not Syncing

**Check status:**
```
Show me connection status for abc-123
```

**Common issues:**
- Invalid credentials
- Missing permissions
- Network connectivity
- Firewall rules

### Missing Data

**Verify sync:**
```
Wait for connection abc-123 to sync
```

**Check resources:**
```
Show me available resources for Production project
```

## Next Steps

<div class="grid cards" markdown>

-   :material-file-document-edit: __Create Instructions__

    ---

    Guide investigation behavior

    [:octicons-arrow-right-24: Testing Instructions](using-instructions.md)

-   :material-alert-circle: __Investigate Alerts__

    ---

    Start investigating incidents

    [:octicons-arrow-right-24: Investigating Alerts](running-investigations.md)

</div>
