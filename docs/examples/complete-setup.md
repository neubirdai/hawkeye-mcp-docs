# Complete Setup Example

End-to-end example of setting up Hawkeye MCP from scratch.

## Scenario

**Company:** Acme Corp
**Environment:** Production AWS + Datadog
**Goal:** Autonomous incident investigation with <10 minute MTTR

## Step 1: Install Hawkeye MCP

```bash
npm install -g hawkeye-mcp-server
hawkeye-mcp --version
# Output: 1.4.0
```

## Step 2: Configure Claude Desktop

Edit `~/Library/Application Support/Claude/claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "hawkeye": {
      "command": "hawkeye-mcp",
      "args": [],
      "env": {
        "HAWKEYE_EMAIL": "ops@acmecorp.com",
        "HAWKEYE_PASSWORD": "SecurePassword123!",
        "HAWKEYE_BASE_URL": "https://app.neubird.ai/api"
      }
    }
  }
}
```

Restart Claude Desktop.

## Step 3: Create Project

**Claude conversation:**
```
User: Create a new Hawkeye project called "Production" for our AWS production environment

Claude: ✓ Created project "Production"
UUID: 550e8400-e29b-41d4-a716-446655440000
Status: Active
```

## Step 4: Add AWS Connection

**Prepare AWS Role:**
```bash
# CloudFormation template for IAM role
aws cloudformation create-stack \
  --stack-name hawkeye-readonly-role \
  --template-body file://hawkeye-role.yaml
```

**Create connection:**
```
User: Create an AWS connection named "Production AWS" with:
- Role ARN: arn:aws:iam::123456789012:role/HawkeyeReadOnly
- External ID: acme-prod-hawkeye-2024
- Regions: us-east-1, us-west-2

Claude: ✓ Created AWS connection "Production AWS"
UUID: conn-aws-550e8400
Status: SYNCING

Syncing your AWS resources...
This may take 5-10 minutes for first sync.
```

**Wait for sync:**
```
User: Wait for my AWS connection to finish syncing

Claude: ⏳ Syncing... (2 minutes elapsed)
⏳ Syncing... (4 minutes elapsed)
⏳ Syncing... (6 minutes elapsed)
✓ Sync complete! (7 minutes total)

Discovered resources:
- 52 EC2 instances
- 8 RDS databases
- 35 Lambda functions
- 180 CloudWatch log groups
- 600+ CloudWatch metrics
```

## Step 5: Add Datadog Connection

```
User: Create a Datadog connection named "Production Datadog" with:
- API Key: a1b2c3d4e5f6g7h8i9j0
- App Key: k1l2m3n4o5p6q7r8s9t0
- Endpoint: datadoghq.com

Claude: ✓ Created Datadog connection "Production Datadog"
UUID: conn-dd-660f9511
Status: SYNCING

Syncing... (1 minute)
✓ Sync complete!

Discovered resources:
- 500+ Datadog metrics
- 200+ APM services
- 150 log pipelines
```

## Step 6: Link Connections to Project

```
User: Add my AWS and Datadog connections to the Production project

Claude: ✓ Added connections to Production project:
  - Production AWS (AWS)
  - Production Datadog (Datadog)

Your project can now access:
- AWS CloudWatch logs & metrics
- EC2, RDS, Lambda resources
- Datadog logs, metrics & traces
```

## Step 7: Create System Instruction

```
User: Create a SYSTEM instruction for my Production project:

"Our production environment:
- Microservices architecture on AWS EKS
- 5 main services: api-gateway, user-service, order-service, payment-service, notification-service
- PostgreSQL RDS 13 for primary database with 2 read replicas
- Redis ElastiCache for session storage and caching
- All services instrumented with Datadog APM
- Logging: CloudWatch + Datadog (centralized)
- Deployment: Rolling updates via ArgoCD
- Peak traffic: 1200 req/sec weekdays 2-6pm EST
- SLA: 99.9% uptime, <200ms p95 API latency"

Claude: ✓ Created SYSTEM instruction
Name: "Production Architecture Context"
Status: Active

This context will be included in all investigations.
```

## Step 8: Create Filter Instruction

```
User: Create a FILTER instruction for Production:

"Only investigate incidents with:
- Severity P1 (critical) or P2 (high)
- Not from automated testing systems
- Not during scheduled maintenance windows
- Affecting production workloads (not canary/staging)"

Claude: ✓ Created FILTER instruction
Name: "Production Priority Filter"
Status: Active

This will reduce noise by filtering P3+ alerts automatically.
```

## Step 9: Create RCA Instructions

### Database Issues
```
User: Create an RCA instruction:

"For database-related incidents:
1. Check PostgreSQL slow query log (queries >100ms)
2. Get EXPLAIN ANALYZE output for slow queries
3. Identify missing indexes using pg_stat_user_tables
4. Review connection pool metrics (max: 100 connections)
5. Check for table locks and lock wait times
6. Provide specific CREATE INDEX CONCURRENTLY commands
7. Estimate performance improvement"

Claude: ✓ Created RCA instruction
Name: "Database Performance Investigation"
Status: Active
```

### API Latency
```
User: Create an RCA instruction:

"For API latency issues:
1. Check Datadog APM traces for affected endpoints
2. Identify slowest span in the trace
3. Review database query performance within spans
4. Check external API call timeouts
5. Examine Redis cache hit rates
6. Review EKS pod resource utilization (CPU/memory)
7. Provide specific optimization recommendations"

Claude: ✓ Created RCA instruction
Name: "API Latency Investigation Steps"
Status: Active
```

## Step 10: First Investigation

```
User: Show me uninvestigated alerts from the last 24 hours

Claude: Found 3 uninvestigated incidents:

1. High API Latency - payment-service
   Alert ID: /aws/cloudwatch/alerts/latency-spike-20240115-1430
   Severity: P1
   Time: 2024-01-15 14:30 UTC
   Source: Datadog

2. Database Connection Pool Warning
   Alert ID: /aws/cloudwatch/alerts/db-pool-20240115-1315
   Severity: P2
   Time: 2024-01-15 13:15 UTC
   Source: CloudWatch

3. Memory Usage High - user-service
   Alert ID: /aws/cloudwatch/alerts/memory-20240115-1210
   Severity: P2
   Time: 2024-01-15 12:10 UTC
   Source: CloudWatch
```

```
User: Investigate the payment-service latency issue

Claude: 🔍 Starting investigation...
Using instructions:
- Production Architecture Context
- Database Performance Investigation
- API Latency Investigation Steps

⏳ Analyzing Datadog APM traces... (20s)
⏳ Checking CloudWatch logs... (15s)
⏳ Reviewing RDS metrics... (12s)
⏳ Correlating events... (18s)

✓ Investigation complete! (65s total)
```

## Step 11: Review RCA

```
User: Show me the RCA

Claude: Root Cause Analysis
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Incident: High API Latency - payment-service
Severity: P1
Duration: 15 minutes (14:30-14:45 UTC)
Status: Auto-resolved

ROOT CAUSE:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
New payment validation query introduced in v2.1.0 deployment
was missing index on payments.merchant_id column. This caused
full table scans on 5M row table, resulting in:
- Query time: 850ms (vs normal 5ms)
- Database CPU spike: 45% → 85%
- Connection pool saturation: 95/100
- API latency increase: 50ms → 900ms

TIMELINE:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
14:25 - Deployment v2.1.0 completed via ArgoCD
14:30 - Payment API latency increased to 900ms
14:32 - Database CPU spiked to 85%
14:33 - Connection pool 95/100 connections used
14:35 - Datadog APM alarm triggered (p95 >500ms)
14:40 - Auto-scaling added 2 more RDS read replicas
14:42 - Database CPU distributed, dropped to 60%
14:45 - API latency returned to normal (55ms)

CORRECTIVE ACTIONS:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Immediate (AUTO-EXECUTED):
✓ Added 2 RDS read replicas
✓ Distributed query load

Required:
1. Add missing database index

   psql -h prod-db.us-east-1.rds.amazonaws.com \\
     -U admin -d production

   CREATE INDEX CONCURRENTLY idx_payments_merchant_id
     ON payments(merchant_id);

   Estimated improvement: 850ms → 5ms (99.4% faster)

2. (Optional) Rollback deployment v2.1.0

   argocd app rollback payment-service --revision 2.0.9

3. Review PR #456 query optimization before redeploying

PREVENTIVE MEASURES:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
1. Add database query performance tests to CI/CD pipeline
2. Enable pg_stat_statements for query monitoring
3. Add pre-deployment query plan review to checklist
4. Configure proactive connection pool alerts (>80%)
5. Implement query timeout guards (<100ms) in application

BUSINESS IMPACT:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
- Payment API requests degraded: 50ms → 900ms
- Duration: 15 minutes
- Affected requests: ~3,000 (200 req/sec × 15 min × 100 payment requests/sec)
- Failed requests: 0 (degraded but not failing)
- Estimated affected users: ~800
- No financial loss (all payments eventually processed)

TIME SAVED:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Manual investigation estimate: 45 minutes
- Check logs: 10 min
- Query Datadog APM: 10 min
- Database analysis: 15 min
- Correlation & RCA: 10 min

Hawkeye investigation time: 65 seconds
Time saved: 43 minutes 55 seconds ⚡
```

## Step 12: Execute Fix

```bash
# Connect to RDS
psql -h prod-db.us-east-1.rds.amazonaws.com -U admin -d production

# Add index (uses CONCURRENTLY to avoid locking)
CREATE INDEX CONCURRENTLY idx_payments_merchant_id
  ON payments(merchant_id);

# Verify index
\d payments

# Output shows new index:
# idx_payments_merchant_id btree (merchant_id)
```

## Step 13: Verify Fix

```
User: Test payment API latency now

# Direct query to database
SELECT merchant_id, COUNT(*)
FROM payments
WHERE merchant_id = 'merch_123'
GROUP BY merchant_id;

# Time: 4.8ms (was 850ms) ✓
```

## Results After 30 Days

```
User: Show me incident statistics for the last 30 days

Claude: Incident Analytics - Production Project
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

INVESTIGATIONS:
- Total incidents: 67
- Auto-investigated: 67 (100%)
- Average quality score: 91/100
- Perfect RCAs (95-100): 52 (78%)

PERFORMANCE:
- MTTR: 7.2 minutes (vs 40min manual baseline)
- Time saved: 36.7 hours (82% reduction)
- Fastest resolution: 1.5 minutes
- Slowest resolution: 22 minutes

NOISE REDUCTION:
- Alerts received: 340
- Filtered by instructions: 273 (80%)
- Investigated: 67 (20%)
- Grouped incidents: 15 groups

TOP INCIDENT TYPES:
1. API Latency (18 incidents)
2. Database Issues (15 incidents)
3. Memory Leaks (12 incidents)
4. Deployment Failures (10 incidents)
5. External API Timeouts (7 incidents)
6. Other (5 incidents)

BUSINESS IMPACT:
- Prevented downtime: 4.2 hours
- Maintained SLA: 99.92% (target: 99.9%)
- Cost avoidance: $125,000 (downtime cost prevented)
```

## Key Takeaways

✅ **Setup time:** 45 minutes
✅ **MTTR:** 7.2 minutes (82% improvement)
✅ **Time saved:** 36.7 hours in first month
✅ **Noise reduction:** 80% of alerts auto-filtered
✅ **SLA maintenance:** Exceeded 99.9% target

## Next Steps

- Add more RCA instructions for edge cases
- Integrate with Slack for notifications
- Set up weekly review process
- Train team on Hawkeye workflows
