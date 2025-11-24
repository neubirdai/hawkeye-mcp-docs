# Daily Workflows

Common daily workflows for Hawkeye MCP users.

## Morning Review Workflow

Check overnight incidents and prepare for the day.

### Step 1: Check Overnight Incidents

```
Show me uninvestigated alerts from the last 12 hours
```

### Step 2: Prioritize

```
Show me only P1 alerts from the last 12 hours
```

### Step 3: Get Links for Sharing

```
Link for #1
Link for #2
```

Share these links with your team or add to incident tickets.

### Step 4: Investigate Critical

```
Investigate all P1 alerts
```

### Step 5: Review Results

```
For each investigation, show me:
- Root cause
- Corrective actions
- Business impact
```

### Step 6: Execute Fixes

Copy bash scripts and code snippets from RCAs and execute corrective actions.

**Time:** 15-20 minutes for 5-10 incidents

---

## Incident Response Workflow

Active incident requiring immediate investigation.

### Step 1: Find Latest Alert

```
Show me alerts from the last 30 minutes
```

### Step 2: Immediate Investigation

```
Investigate the most recent alert and wait for results
```

### Step 3: Quick RCA

```
Show me the root cause and corrective actions
```

### Step 4: Execute Fix

```
Execute the first corrective action
```

### Step 5: Verify

```
Check if the incident is resolved
```

**Time:** 2-5 minutes from alert to fix

---

## Weekly Review Workflow

Analyze patterns and optimize instructions.

### Step 1: Get Analytics

```
Show me incident statistics for the last 7 days
```

### Step 2: Review Quality

```
Show me investigations with quality score < 80
```

### Step 3: Identify Patterns

```
What are the most common incident types this week?
```

### Step 4: Refine Instructions

For recurring incident types with low scores:

```
1. Review past RCAs
2. Draft new instruction
3. Test on past session
4. Deploy if improved
```

**Time:** 30-45 minutes weekly

---

## Post-Deployment Workflow

Monitor new deployment for issues.

### Step 1: Pre-Deployment Baseline

```
Show me current incident rate and types
```

### Step 2: Deploy Application

Execute deployment via CI/CD.

### Step 3: Monitor Post-Deployment (15 min)

```
Show me any new alerts in the last 15 minutes
```

### Step 4: Quick Investigation

```
For any deployment-related alerts:
Investigate immediately
Check if deployment is the cause
Rollback if necessary
```

### Step 5: Post-Deployment Report (1 hour)

```
Show me all incidents in the hour after deployment
Compare with baseline
```

**Time:** Continuous monitoring during deployment window

---

## Monthly Optimization Workflow

Optimize Hawkeye configuration for better results.

### Step 1: Monthly Analytics

```
Show me incident report for the last 30 days
```

### Step 2: Review Instructions

```
List all active instructions
Identify unused or ineffective ones
```

### Step 3: A/B Test New Approaches

```
1. Draft alternative instruction
2. Test on multiple past sessions
3. Compare results
4. Deploy winner, disable loser
```

### Step 4: Review Connections

```
List all connections
Check sync status
Add new data sources if needed
```

### Step 5: Update Context

```
Update SYSTEM instructions with:
- Architecture changes
- New services
- Updated SLAs
```

**Time:** 1-2 hours monthly

---

## On-Call Workflow

Optimized workflow for on-call engineers.

### 1. Alert Notification

Receive alert from PagerDuty/OpsGenie.

### 2. Quick Check

```
Show me alerts for [service-name] in the last hour
```

### 3. Investigate

```
Investigate the alert and wait
```

### 4: Review RCA

```
Show me:
- Root cause
- Business impact
- Corrective actions
```

### 5: Take Action

**If auto-remediated:** Verify and close

**If manual action needed:** Execute provided bash scripts

**If escalation needed:** Page senior engineer with RCA summary

### 6: Document

```
Get link for investigation: Link for sessionID abc-123
Copy RCA to incident ticket
Add investigation link to ticket
Include time saved metric
Close incident
```

**Time:** 3-8 minutes per incident

---

## Preventive Maintenance Workflow

Proactive issue prevention based on patterns.

### Step 1: Identify Recurring Issues

```
Show me incidents grouped by type for last 30 days
```

### Step 2: Extract Preventive Measures

```
For top 3 incident types:
Show me all preventive measures recommended
```

### Step 3: Create Maintenance Tasks

```
Convert preventive measures to:
- Jira tickets
- Infrastructure improvements
- Process changes
```

### Step 4: Track Implementation

```
Monitor if recurring issues decrease after fixes
```

**Time:** 1 hour monthly, saves hours in reduced incidents

---

## New Team Member Onboarding

Training workflow for new engineers.

### Day 1: Introduction

```
1. Show me all Hawkeye projects
2. Show me project details
3. Show me connections
4. Show me active instructions
```

### Day 2: Read-Only Investigation

```
1. Show me past investigations
2. Review RCA examples
3. Ask follow-up questions
4. Learn RCA structure
```

### Day 3: Practice Investigation

```
1. Find uninvestigated alert
2. Investigate with supervision
3. Review RCA quality
4. Execute safe corrective actions
```

### Week 2: Independent Use

```
1. Investigate alerts independently
2. Create first instruction (with review)
3. Run weekly review
```

**Time:** 2 weeks to full proficiency

---

## Performance Tracking Workflow

Track and report Hawkeye ROI.

### Weekly Metrics

```
Show me:
- Total investigations this week
- Average MTTR
- Total time saved
- Quality score trend
```

### Monthly Report

```
Generate monthly incident report:
- Investigations: Count, types, quality
- Performance: MTTR, time saved
- Noise reduction: Filtered vs investigated
- Trends: Week over week changes
```

### Quarterly Review

```
Compare quarters:
- MTTR improvement
- Total time saved
- Cost avoidance (downtime prevented)
- Team efficiency gains
```

**Time:** 30 minutes weekly, 1 hour monthly, 2 hours quarterly

---

## See Also

- [Investigating Alerts](../guides/running-investigations.md)
- [Testing Instructions](../guides/using-instructions.md)
- [Advanced Workflows](../guides/advanced-workflows.md)
- [Complete Setup Example](complete-setup.md)
