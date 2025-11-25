# Prompt Engineering for Investigations

Learn how to write effective prompts for manual investigations that produce high-quality root cause analyses.

## Why Prompt Quality Matters

The quality of your investigation prompt directly affects:

- **Investigation accuracy** - Better prompts lead to more precise root cause identification
- **Time to results** - Specific prompts help Hawkeye focus on relevant data sources
- **Actionability** - Clear context produces more targeted corrective actions
- **RCA completeness** - Detailed prompts result in thorough analysis

## The Four Essential Elements

Every great investigation prompt includes these four elements:

### 1. Service/Resource Names

**Why it matters:** Tells Hawkeye exactly which components to investigate.

**✅ Good:**
```
Investigate high latency in payment-service API
```

**❌ Bad:**
```
Investigate the API
```

**Examples:**
- `user-authentication-service`
- `postgres-primary database`
- `production-web-server-01`
- `payment-processor Lambda function`
- `api-gateway in us-east-1`

### 2. Time Frame

**Why it matters:** Narrows down logs, metrics, and events to the relevant period.

**✅ Good:**
```
Between 2pm-3pm EST on January 15, 2025
```

**❌ Bad:**
```
Recently
Earlier today
```

**Examples:**
- `January 15, 2025 at 2:30pm UTC`
- `Between 8am-9am PST yesterday`
- `During the last deployment (3:15pm-3:45pm EST)`
- `Starting around 10:00am UTC today`
- `Last 30 minutes`

**Tips:**
- Always include timezone (UTC, EST, PST)
- Use specific dates and times
- Provide time ranges when the exact moment is unclear
- Reference deployment times or other known events

### 3. Symptoms

**Why it matters:** Describes what's wrong so Hawkeye knows what to look for.

**✅ Good:**
```
Users reported checkout taking 30+ seconds instead of the usual 2 seconds
```

**❌ Bad:**
```
Something is slow
```

**Examples:**
- `Response times increased from 200ms to 5 seconds`
- `Memory usage climbing from 500MB to 2GB`
- `Connection pool exhausted - max of 100 connections reached`
- `Multiple services returned 503 errors`
- `CPU spiked to 95% on all nodes`
- `Disk I/O wait time exceeded 80%`

**Tips:**
- Include specific metrics and thresholds
- Compare against normal baselines
- Describe user-facing impact when relevant

### 4. Context

**Why it matters:** Provides additional clues that help focus the investigation.

**✅ Good:**
```
This occurred immediately after deploying version 2.1.5
```

**❌ Bad:**
```
We deployed something
```

**Examples:**
- `Started after database migration to Postgres 14`
- `Coincided with Black Friday traffic spike`
- `Happened during scheduled backup window`
- `No recent deployments or configuration changes`
- `Affects only users in EU region`

## Complete Prompt Examples

### Example 1: Memory Leak

```
Investigate memory leak in user-api pods in production namespace.
Started around 8am UTC today. Memory usage climbing from 500MB to 2GB over 3 hours.
No recent deployments. Using Kubernetes 1.28.
```

**Why this works:**
- ✅ Service name: `user-api pods in production namespace`
- ✅ Time frame: `8am UTC today, over 3 hours`
- ✅ Symptoms: `Memory climbing from 500MB to 2GB`
- ✅ Context: `No recent deployments, Kubernetes 1.28`

### Example 2: Database Performance

```
Analyze database connection pool exhaustion in postgres-primary.
Between 1pm-2pm EST yesterday. Connection count hit max of 100, causing timeouts.
Started during afternoon traffic peak. Connection timeout errors in application logs.
```

**Why this works:**
- ✅ Service name: `postgres-primary`
- ✅ Time frame: `1pm-2pm EST yesterday`
- ✅ Symptoms: `Connection pool maxed at 100, timeouts`
- ✅ Context: `Afternoon traffic peak, timeout errors in logs`

### Example 3: Deployment Issue

```
Check for cascading failures in microservices during deployment.
January 15, 2025 at 3:15pm UTC. Multiple services returned 503 errors.
Deployment of api-gateway v2.3.0 triggered the issue. Auth and payment services affected.
```

**Why this works:**
- ✅ Service name: `microservices (specifically auth, payment, api-gateway)`
- ✅ Time frame: `January 15, 2025 at 3:15pm UTC`
- ✅ Symptoms: `503 errors across multiple services`
- ✅ Context: `api-gateway v2.3.0 deployment triggered it`

### Example 4: Latency Spike

```
Investigate API latency spike in checkout-service.
January 20, 2025 between 2pm-3pm EST. Response time increased from 200ms to 8 seconds.
Users reported slow checkout during promotion campaign. Database queries appear normal.
```

**Why this works:**
- ✅ Service name: `checkout-service`
- ✅ Time frame: `January 20, 2025, 2pm-3pm EST`
- ✅ Symptoms: `200ms to 8 seconds response time`
- ✅ Context: `Promotion campaign, DB queries normal`

## Common Mistakes and How to Fix Them

### Mistake 1: Too Vague

**❌ Bad:**
```
Something is wrong with the payment service
```

**✅ Good:**
```
Investigate payment-api service returning 500 errors.
Started at 2:30pm UTC today. Error rate jumped from 0.1% to 15%.
Coincided with deployment of v3.2.1.
```

### Mistake 2: Missing Time Frame

**❌ Bad:**
```
Check why the database is slow
```

**✅ Good:**
```
Investigate slow database queries in postgres-primary.
Between 9am-10am PST on January 18, 2025.
Query response time increased from 50ms to 3 seconds.
```

### Mistake 3: No Specific Metrics

**❌ Bad:**
```
The API is having problems
```

**✅ Good:**
```
Investigate API errors in user-service.
January 16, 2025 at 4:45pm EST.
Error rate at 23% (up from baseline of 0.5%). Returning 504 Gateway Timeout.
```

### Mistake 4: Unclear Component Names

**❌ Bad:**
```
Check the server issue
```

**✅ Good:**
```
Investigate high CPU usage on prod-web-server-03.
Started at 11:30am UTC today. CPU usage at 92% (normal is 20-30%).
Running nginx 1.24 and serving API traffic.
```

## Advanced Prompt Techniques

### For Complex Multi-Service Issues

When investigating issues affecting multiple services:

```
Investigate cascading failures across microservices architecture.
January 22, 2025 between 5pm-6pm UTC.

Symptoms:
- api-gateway: 503 errors (50% of requests)
- auth-service: increased latency (500ms to 3s)
- user-db: connection pool at 95% capacity
- payment-service: timeouts communicating with Stripe API

Context: Started during evening traffic peak. No deployments in last 24 hours.
Auth-service appears to be the bottleneck.
```

### For Historical Analysis

When investigating past incidents:

```
Analyze the incident from last week's outage for post-mortem.
January 15, 2025 from 2:15pm-2:45pm EST.

What happened: Complete service outage affecting all customers.
Services impacted: All production services in us-east-1.
Resolution: Service restored after reverting deployment.

Please provide detailed timeline, root cause, and prevention recommendations.
```

### For Proactive Investigations

When investigating potential issues before they become incidents:

```
Investigate gradual memory increase trend in worker-service pods.
Over the last 7 days. Memory usage growing from 1GB to 2.5GB steadily.
Not yet causing issues but approaching pod memory limit of 3GB.
Want to understand if this is a leak or expected growth from increased load.
```

## Agent Behavior with Poor Prompts

If your prompt is too vague, Claude will ask clarifying questions:

**Your vague prompt:**
```
Investigate the payment issue
```

**Claude's response:**
```
I need more details to create an effective investigation:

1. Which payment service? (payment-api, payment-processor, payment-gateway, etc.)
2. When did this occur? (specific date/time or time range)
3. What symptoms did you observe?
   - Error messages?
   - Slow response times?
   - Failed transactions?
4. Any additional context?
   - Recent deployments?
   - Traffic changes?
   - Related system changes?

Please provide these details for a more accurate investigation.
```

## Prompt Templates

### Template: Service Performance Issue

```
Investigate [performance issue type] in [service-name].
[Specific date and time with timezone].
[Metric] increased/decreased from [baseline] to [current value].
[Any relevant context about deployments, traffic, or changes].
```

### Template: Error Rate Spike

```
Investigate error spike in [service-name].
[Date and time range with timezone].
Error rate at [X]% (normal baseline is [Y]%).
[Error type/code]. [User impact description].
[Context about what changed or was happening].
```

### Template: Resource Exhaustion

```
Investigate [resource type] exhaustion in [service/component].
[Date and time with timezone].
[Resource metric] reached [X] (limit is [Y], normal is [Z]).
[Symptoms observed]. [Related services or impacts].
[Context about load, deployments, or configuration].
```

## Testing Your Prompts

Before creating an investigation, mentally check:

- [ ] Can someone unfamiliar with the issue understand what happened?
- [ ] Is the time frame specific enough to narrow down logs?
- [ ] Are service names exact (as they appear in your systems)?
- [ ] Do metrics include actual numbers, not just "high" or "slow"?
- [ ] Is there enough context to guide the investigation?

## Quality Indicators

Signs of a **good prompt**:
- 2-4 sentences with specific details
- Includes all four essential elements
- Uses exact service names from your infrastructure
- Provides quantitative metrics
- Gives enough context without being overly long

Signs of a **poor prompt**:
- Single vague sentence
- Uses relative terms ("recently", "the service", "something")
- No specific times or metrics
- Missing context about what's abnormal

## Best Practices Summary

1. **Be specific** - Use exact service names, not generic terms
2. **Include timestamps** - Always specify timezone
3. **Quantify symptoms** - Use actual metrics and thresholds
4. **Provide context** - Mention deployments, traffic, or related changes
5. **Keep it focused** - One issue per investigation
6. **Use your monitoring terms** - Match names from your dashboards and alerts

## Next Steps

Ready to start investigating? Check out these guides:

- [Running Investigations](running-investigations.md) - Complete investigation workflows
- [Manual Investigations](running-investigations.md#manual-investigations) - Deep dive into manual investigations
- [Using Instructions](using-instructions.md) - Customize investigation behavior

---

**Pro tip:** Save your best prompts as templates. When similar issues occur, you can quickly adapt proven prompts for faster, more consistent investigations.
