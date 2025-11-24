# Testing Instructions Example

Real-world example of testing an investigation instruction.

## Scenario

**Problem:** Database investigations lack specific index recommendations

**Goal:** Add instruction that provides EXPLAIN ANALYZE output and specific CREATE INDEX commands

## Step 1: Identify the Gap

After investigating a slow query incident:

```
The RCA said "query is slow, consider adding indexes" but didn't
specify WHICH indexes or provide commands to create them.
```

## Step 2: Draft Instruction

```
For database performance issues:
1. Get EXPLAIN ANALYZE output for slow queries
2. Identify missing indexes using query plan
3. Calculate index selectivity
4. Provide specific CREATE INDEX CONCURRENTLY commands
5. Estimate performance improvement (old time → new time)
```

## Step 3: Validate Instruction

```
User: Validate this RCA instruction:

"For database performance issues:
1. Get EXPLAIN ANALYZE output for slow queries
2. Identify missing indexes using query plan
3. Calculate index selectivity
4. Provide specific CREATE INDEX CONCURRENTLY commands
5. Estimate performance improvement (old time → new time)"

Claude: ✓ Instruction validated successfully

Generated name: "Database Performance Analysis with Index Recommendations"
Type: RCA
Refined content: [AI-optimized version with added PostgreSQL-specific details]

Ready to test!
```

## Step 4: Choose Test Session

Find a past database incident to test against:

```
User: Show me database-related investigations from the last 30 days

Claude: Found 5 database investigations:

1. Slow Query - user_preferences table
   Session UUID: session-db-001
   Date: 2024-01-10
   Original RCA: Generic index recommendation

2. Connection Pool Exhaustion
   Session UUID: session-db-002
   ...
```

Save `session-db-001` as our test case.

## Step 5: Apply Instruction

```
User: Apply this database performance instruction to session session-db-001

Claude: ✓ Instruction applied to test session session-db-001

The instruction has been added as a session-specific override.
It will ONLY affect this session when rerun, not other investigations.

Next: Rerun the session to see the impact.
```

## Step 6: Rerun Investigation

```
User: Rerun session session-db-001 with the new instruction

Claude: 🔍 Rerunning investigation with new instruction...
⏳ Re-analyzing with database performance guidance... (30s)
⏳ Generating updated RCA... (15s)
✓ Investigation complete! (45s)
```

## Step 7: Compare Results

### Original RCA (Before)

```
ROOT CAUSE:
Slow query on user_preferences table causing API latency.

CORRECTIVE ACTIONS:
- Consider adding database indexes
- Optimize query structure
- Review table size and growth

PREVENTIVE MEASURES:
- Monitor query performance
- Regular index maintenance
```

### New RCA (After)

```
ROOT CAUSE:
Slow query on user_preferences table (850ms) caused by
full table scan due to missing index on user_id column.

EXPLAIN ANALYZE Output:
┌────────────────────────────────────────────────┐
│ Seq Scan on user_preferences                  │
│   Filter: (user_id = 12345)                   │
│   Rows: 500000 scanned, 1 returned            │
│   Time: 850.234 ms                            │
└────────────────────────────────────────────────┘

Missing Index Analysis:
- Column: user_id
- Selectivity: 0.0002% (1/500000)
- Cardinality: High (450K unique values)
- Recommendation: B-tree index

CORRECTIVE ACTIONS:
1. Add missing index (PRIMARY FIX)

   psql -h prod-db.rds.amazonaws.com -U admin -d production

   CREATE INDEX CONCURRENTLY idx_user_prefs_user_id
     ON user_preferences(user_id);

   Estimated improvement: 850ms → 2ms (99.8% faster)
   Index size: ~15MB
   Build time: ~30 seconds (CONCURRENTLY = no table lock)

2. Update application query to use prepared statement

3. Consider partitioning if table exceeds 1M rows

PREVENTIVE MEASURES:
- Add pg_stat_statements for query monitoring
- Set up alerts for queries >100ms
- Add index usage review to weekly maintenance
- Implement query plan analysis in code review
```

## Step 8: Analysis

**Improvements in new RCA:**

| Aspect | Before | After | Verdict |
|--------|--------|-------|---------|
| Specific index | ❌ No | ✅ Yes (user_id) | Better |
| SQL command | ❌ No | ✅ Yes (CREATE INDEX) | Better |
| EXPLAIN output | ❌ No | ✅ Yes | Better |
| Performance estimate | ❌ No | ✅ Yes (850ms → 2ms) | Better |
| Index selectivity | ❌ No | ✅ Yes (0.0002%) | Better |
| Build impact | ❌ No | ✅ Yes (CONCURRENTLY) | Better |

**Quality scores:**

- Before: 72/100
- After: 94/100
- Improvement: +22 points

**Verdict:** ✅ Instruction significantly improves RCA quality!

## Step 9: Test on Different Incident Type

Ensure instruction doesn't harm unrelated investigations:

```
User: Apply this instruction to session session-api-latency-003
(an API latency incident NOT related to database)

User: Rerun session session-api-latency-003

User: Show me the RCA
```

**Result:** RCA unchanged, instruction didn't interfere.

**Verdict:** ✅ Instruction is properly scoped to database issues only.

## Step 10: Add to Project

```
User: The instruction improved database RCAs and doesn't affect
other investigation types. Add it to my Production project.

Claude: ✓ Created RCA instruction for Production project
Name: "Database Performance Analysis with Index Recommendations"
Status: Active

All future database performance investigations will now include:
- EXPLAIN ANALYZE output
- Specific index recommendations
- CREATE INDEX commands
- Performance improvement estimates
```

## Results After 7 Days

```
User: Show me database investigations from the last 7 days

Claude: Found 3 database investigations (all using new instruction):

1. Slow JOIN query - orders table
   RCA included: CREATE INDEX on orders.customer_id
   Estimated improvement: 1200ms → 8ms
   Quality score: 96/100

2. Missing composite index - payments table
   RCA included: CREATE INDEX on (merchant_id, created_at)
   Estimated improvement: 650ms → 3ms
   Quality score: 92/100

3. Inefficient subquery - analytics table
   RCA included: Materialized view recommendation
   Estimated improvement: 5s → 100ms
   Quality score: 89/100

Average quality score: 92.3/100 (vs 72/100 before)
Improvement: +20.3 points
```

## Key Takeaways

✅ **Always validate first** - Catches syntax errors
✅ **Test on real session** - See actual impact
✅ **Compare before/after** - Quantify improvement
✅ **Test negative case** - Ensure no harm to other types
✅ **Deploy only if better** - Don't deploy "meh" improvements
✅ **Monitor after deployment** - Track quality scores

## See Also

- [Testing Instructions Guide](../guides/using-instructions.md)
- [Complete Setup Example](complete-setup.md)
- [Investigating Alerts](../guides/running-investigations.md)
