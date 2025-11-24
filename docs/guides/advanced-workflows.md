# Advanced Workflows

Expert-level techniques for power users.

## Multi-Instance Management

### Switch Between Instances

```
Switch to instance: https://staging.app.neubird.ai/api
```

Use cases:
- Dev/staging/prod environments
- Multiple customer instances
- Testing vs production

### Instance Best Practices

**Development workflow:**
1. Test on staging instance
2. Validate changes
3. Switch to production
4. Deploy changes

## Multi-Project Management

Switch between projects without specifying project_uuid every time.

### Quick Context Switching

```
Switch to Production project
List my connections
Show recent investigations

Switch to Staging project
Test the new instruction
```

All operations automatically use the current default project.

### Multi-Environment Workflow

**Testing changes across environments:**

```
# 1. Test in Development
Switch to Development project
Create a new filter instruction
Test on past incidents

# 2. Validate in Staging
Switch to Staging project
Create the same instruction
Verify it works as expected

# 3. Deploy to Production
Switch to Production project
Create the instruction
Monitor first few investigations
```

### Project-Specific Operations

Different projects can have different configurations:

```
# Production - conservative settings
Switch to Production project
Create FILTER instruction: "Only investigate P1 and P2"
Create SYSTEM instruction: "Always suggest safe rollback first"

# Staging - experimental settings
Switch to Staging project
Create FILTER instruction: "Investigate all severities"
Create SYSTEM instruction: "Allow experimental fixes"
```

### Natural Language Switching

Use project names instead of UUIDs:

```
Switch to HTM-Azure
Switch to Customer-Acme-Prod
Switch to my staging environment
```

The MCP server will find matching projects by name.

## Batch Operations

### Investigate Multiple Alerts

```
Show me all P1 alerts from the last hour
Investigate each one
Provide a summary of all root causes
```

### Bulk Instruction Updates

```
Disable all RCA instructions temporarily
Test new investigation approach
Re-enable instructions
```

## Advanced Filtering

### Complex Session Queries

```
Show me uninvestigated database alerts from us-east-1
in the last 7 days with severity P1 or P2
```

### Search by Pattern

```
Find all incidents related to "payment" or "transaction"
in the last 30 days
```

## Performance Optimization

### Use Compact Mode

For large result sets:

```
Show me all sessions from last month in compact mode
```

Reduces token usage and speeds up responses.

### Parallel Investigations

Investigate multiple incidents simultaneously using separate Claude conversations.

## Analytics and Reporting

### Custom Time Ranges

```
Show me incident statistics from January 1-15
```

### Quality Trends

```
Show me average RCA quality scores by week
```

### Time Saved Analysis

```
Calculate total time saved this quarter
```

## Instruction Patterns

### Conditional Instructions

```
For incidents during business hours (9am-5pm EST):
- Page on-call engineer immediately
- Include business impact in RCA

For incidents outside business hours:
- Queue for morning review
- Focus on auto-remediation
```

### Environment-Specific Instructions

```
For production incidents:
- Always suggest safe rollback first
- Require confirmation before changes
- Include customer impact analysis

For staging incidents:
- Allow experimental fixes
- Focus on learning
- Test remediation thoroughly
```

## Real-Time Investigation Monitoring

### Tracking Investigation Progress

Monitor investigations in real-time to understand what Hawkeye is doing:

```
# Start investigation
Investigate the high latency alert

# Monitor progress (check every 10-15 seconds)
Show me the investigation status
```

**What you'll see:**
- Current step description
- Progress percentage (0-100)
- Data sources being consulted
- Completed vs total steps

### Understanding Investigation Steps

Each investigation progresses through categorized steps:

**Discovery phase:**
```
Current step: "🔍 Discovery: Identifying affected services and hosts"
Progress: 15%
Sources: ["log_datadog.datadog_logs", "monitor_datadog.monitor_events"]
```

**Analysis phase:**
```
Current step: "📊 Analysis: Correlating latency spikes with database queries"
Progress: 45%
Sources: ["metric_aws.cloudwatch_metrics", "log_aws.rds_logs"]
```

**Diagnosis phase:**
```
Current step: "🔬 Diagnosis: Identifying root cause of connection pool exhaustion"
Progress: 70%
Sources: ["log_datadog.datadog_logs", "metric_datadog.custom_metrics"]
```

### Verifying Data Coverage

Check which data sources were consulted:

```
Show me the investigation status

# Look for unique_sources field:
unique_sources: [
  "log_datadog.datadog_logs",
  "monitor_datadog.monitor_events",
  "alarm_aws_prod.alarm_history",
  "metric_aws_prod.cloudwatch_metrics"
]
```

**Use this to:**
- Verify all relevant systems were checked
- Identify missing data sources
- Understand investigation thoroughness
- Debug incomplete investigations

### Step-by-Step Investigation Review

Get detailed breakdown of investigation reasoning:

```
# After investigation completes
Show me the chain of thought

# Or get specific step details
Show me step details for step ID 69247c6b517e7056d602abd1
```

**Each step shows:**
- Question being answered
- Category (discovery, analysis, diagnosis, etc.)
- Data sources consulted for that step
- Status (completed, in_progress)

### Progress Patterns to Watch

**Normal patterns:**

1. **Fast discovery, slower analysis**
   - 0% → 30% in 30 seconds
   - 30% → 70% in 90 seconds
   - 70% → 100% in 30 seconds

2. **Steady progression**
   - Even progress across all phases
   - Indicates straightforward incident

3. **Long analysis phase**
   - Quick to 30%, then slower
   - Normal for complex correlations

**Concerning patterns:**

1. **Stuck at 0%**
   - Investigation may not have started
   - Check connection sync status

2. **No progress after 5 minutes**
   - Possible timeout or error
   - Check investigation status for errors

3. **Very few data sources**
   - May indicate connection issues
   - Verify connections are synced

## Integration Workflows

### CI/CD Integration

Use Hawkeye investigations in CI/CD:

```bash
# In deployment pipeline
if deployment fails:
  trigger hawkeye investigation
  extract corrective actions
  attempt auto-remediation
```

### Slack/Teams Integration

Forward RCA results to team channels:

```
Investigate this alert
Send RCA summary to #incidents channel
Include corrective actions and time saved
```

### Ticket System Integration

Create tickets from investigations:

```
Investigate alert
Extract preventive measures
Create Jira ticket for each measure
Assign to appropriate team
```

## Next Steps

<div class="grid cards" markdown>

-   :material-book-open: __More Guides__

    ---

    Browse comprehensive guides

    [:octicons-arrow-right-24: All Guides](onboarding.md)

-   :material-lightbulb: __Examples__

    ---

    Real-world workflows

    [:octicons-arrow-right-24: Examples](../examples/complete-setup.md)

</div>
