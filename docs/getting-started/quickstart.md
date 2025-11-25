# Quick Start

Get up and running with Hawkeye MCP in 5 minutes.

## Prerequisites

Before starting, ensure you have:

- [x] Node.js 20+ installed
- [x] Hawkeye account credentials
- [x] MCP client (Claude Desktop, Claude Code, etc.)

!!! tip "New to Hawkeye?"
    If you don't have an account, [book a demo](https://neubird.ai) to get started.

## 5-Minute Setup

### Step 1: Install Hawkeye MCP

=== "npx (Fastest)"

    No installation needed:

    ```bash
    npx hawkeye-mcp-server
    ```

=== "Global Install"

    Install once:

    ```bash
    npm install -g hawkeye-mcp-server
    ```

### Step 2: Configure Credentials

Create `.env` file:

```bash
HAWKEYE_EMAIL=your-email@company.com
HAWKEYE_PASSWORD=your-password
HAWKEYE_BASE_URL=https://app.neubird.ai/api
```

### Step 3: Connect to Claude Desktop

Edit `~/Library/Application Support/Claude/claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "hawkeye": {
      "command": "npx",
      "args": ["-y", "hawkeye-mcp-server"],
      "env": {
        "HAWKEYE_EMAIL": "your-email@company.com",
        "HAWKEYE_PASSWORD": "your-password",
        "HAWKEYE_BASE_URL": "https://app.neubird.ai/api"
      }
    }
  }
}
```

### Step 4: Restart Claude Desktop

1. Quit Claude Desktop completely
2. Relaunch Claude Desktop
3. Look for Hawkeye tools in the tools panel (🔨 icon)

### Step 5: Test It Out

Try these commands in Claude Desktop:

```
List my Hawkeye projects
```

```
Show me uninvestigated incidents
```

## Your First Investigation

Let's investigate an alert from start to finish.

### 1. Find Uninvestigated Alerts

Ask Claude:

```
Show me uninvestigated alerts in the last 7 days
```

This uses `hawkeye_list_sessions` with `only_uninvestigated=true`.

**Expected output:**

```
Found 3 uninvestigated alerts:

1. High CPU on prod-web-server-01
   Alert ID: /subscriptions/.../alerts/cpu-spike-123
   Severity: P1
   Time: 2024-01-15 14:23 UTC

2. Database connection timeout
   Alert ID: /subscriptions/.../alerts/db-timeout-456
   Severity: P2
   Time: 2024-01-15 13:45 UTC

3. Memory leak in api-service
   Alert ID: /subscriptions/.../alerts/memory-leak-789
   Severity: P2
   Time: 2024-01-15 12:10 UTC
```

### 2. Investigate an Alert

Ask Claude:

```
Investigate the high CPU alert
```

Claude will:

1. Extract the `alert_id` from the list
2. Call `hawkeye_investigate_alert` to start investigation
3. Monitor real-time progress updates showing current steps and data sources
4. Wait for investigation to complete (usually 30-60 seconds)
5. Retrieve the Root Cause Analysis

!!! tip "Real-Time Progress Tracking"
    When you start an investigation, Hawkeye automatically streams progress updates. You'll see live updates on what the investigation is doing, which data sources it's consulting, and how far along it is. Use `hawkeye_get_investigation_status` to check progress at any time.

**Expected output:**

```
Investigation complete! Here's what I found:

Root Cause Analysis:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Incident: High CPU on prod-web-server-01
Severity: P1
Status: Resolved

Root Cause:
A runaway cron job (backup-cleanup.sh) was consuming
excessive CPU due to an infinite loop caused by a race
condition when processing large file lists.

Timeline:
1. 14:15 UTC - Backup cleanup cron job started
2. 14:18 UTC - CPU spiked to 95% on prod-web-server-01
3. 14:23 UTC - CloudWatch alarm triggered
4. 14:25 UTC - Auto-remediation killed the process
5. 14:26 UTC - CPU returned to normal (12%)

Corrective Actions:
1. Kill the runaway process
   Status: ✓ Auto-executed

2. Add timeout to backup script
   bash:
   sed -i '1a timeout 300' /opt/scripts/backup-cleanup.sh

3. Add file count limit
   bash:
   find /backups -mtime +30 | head -n 1000 | xargs rm

Business Impact:
- API response time increased 200ms (14:18-14:26)
- No customer-facing errors
- Estimated impact: 50 users affected

Time Saved: 45 minutes
```

### 3. Get Investigation Link

Ask Claude:

```
Link for #1
```

This provides a direct URL to view the investigation in the Hawkeye web interface, making it easy to share with team members or bookmark for later reference.

### 4. Ask Follow-up Questions

Ask Claude:

```
Why did this happen now? Has it happened before?
```

This uses `hawkeye_continue_investigation` to dig deeper.

**Expected output:**

```
Looking deeper into the history...

This is the 3rd occurrence in the past month:
- Jan 15: High CPU (this incident)
- Dec 28: Similar CPU spike, manually resolved
- Dec 12: CPU spike, auto-resolved

Pattern Analysis:
All incidents occurred when backup directory
contained >10,000 files. The script lacks proper
file count handling.

Recommendation:
Implement the corrective actions to prevent
recurrence. The auto-remediation worked, but
fixing the root cause will eliminate these
incidents entirely.
```

### 5. Get Actionable Insights

The RCA includes ready-to-execute bash scripts:

```bash
# Add timeout to prevent infinite loops
sed -i '1a timeout 300' /opt/scripts/backup-cleanup.sh

# Add file count limit
find /backups -mtime +30 | head -n 1000 | xargs rm

# Add this to crontab for daily cleanup
echo "0 2 * * * timeout 300 /opt/scripts/backup-cleanup.sh" | crontab -
```

## Common Workflows

### List Projects

```
Show me all my Hawkeye projects
```

### List Connections

```
What connections do I have set up?
```

### Get Investigation History

```
Show me investigations from the last 30 days
```

### Check Performance Metrics

```
What's our MTTR and time saved?
```

This uses `hawkeye_get_incident_report` for organization-wide analytics.

## What's Next?

Now that you've completed your first investigation, choose your next step:

**[Managing Connections →](../guides/managing-connections.md)**
Connect [AWS](https://neubird.ai/agentic-ai-for-aws/), Azure, Datadog, and more

**[Using Instructions →](../guides/using-instructions.md)**
Guide Hawkeye's investigation behavior

**[Complete Onboarding →](../guides/onboarding.md)**
Full setup from scratch to production

**[Examples →](../examples/complete-setup.md)**
See real-world examples and workflows

## Tips for Success

### Start Simple

Don't try to configure everything at once. Start with:

1. One project
2. One connection (your primary monitoring tool)
3. A few basic instructions

### Use the Guidance System

Ask Hawkeye for help directly:

```
How do I create a filter instruction?
```

This uses `hawkeye_get_guidance` for interactive help.

### Test Instructions Before Deploying

Always test instructions on past sessions before adding to your project:

1. Validate instruction
2. Apply to test session
3. Rerun investigation
4. Compare results
5. Add to project if improved

See [Using Instructions](../guides/using-instructions.md) for details.

### Monitor Your Analytics

Check your incident statistics regularly:

```
Show me our incident report
```

Track:
- MTTR (Mean Time To Resolution)
- Time saved vs manual investigation
- Investigation quality scores
- Noise reduction from filtering

## Troubleshooting

### No Tools Available

**Problem:** Claude says Hawkeye tools aren't available

**Solution:**

1. Check Claude Desktop config is correct
2. Restart Claude Desktop completely
3. Check for errors in Claude Desktop logs:
   ```
   ~/Library/Logs/Claude/mcp*.log
   ```

### Authentication Failed

**Problem:** `401 Unauthorized` error

**Solution:**

1. Verify credentials are correct
2. Check `HAWKEYE_BASE_URL` ends with `/api`
3. Test login at Hawkeye web UI

See [Authentication](authentication.md#troubleshooting) for more help.

### Investigation Taking Too Long

**Problem:** Investigation running for several minutes

**Solution:**

This is normal for first investigation on a new project while Hawkeye:

1. Syncs your connections (may take 5-10 minutes)
2. Indexes your data sources
3. Builds correlation models

Subsequent investigations are much faster (30-60 seconds).

### No Uninvestigated Alerts

**Problem:** List shows no uninvestigated alerts

**Solution:**

This is actually good news! It means:

1. All alerts have been investigated, or
2. Filters are working and removing noise, or
3. No alerts in the time period

Try expanding the date range:

```
Show uninvestigated alerts from the last 30 days
```

## Getting Help

- **Documentation:** Full guides at [guides section](../guides/onboarding.md)
- **Examples:** Real-world examples in [examples section](../examples/complete-setup.md)
- **Troubleshooting:** Common issues at [troubleshooting](../troubleshooting.md)
- **Support:** Contact [NeuBird](https://neubird.ai) for help

## Next Steps

Choose your path:

=== "I want the complete setup"

    Follow the comprehensive onboarding guide:

    [:octicons-arrow-right-24: Complete Onboarding](../guides/onboarding.md){ .md-button .md-button--primary }

=== "I want to see examples"

    See practical examples and workflows:

    [:octicons-arrow-right-24: Examples](../examples/complete-setup.md){ .md-button .md-button--primary }
