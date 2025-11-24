# Managing Projects

Learn to create, configure, and maintain Hawkeye projects.

## What is a Project?

A Hawkeye project organizes:

- **Connections** - Cloud providers and monitoring tools
- **Instructions** - Investigation behavior and filtering
- **Sessions** - Investigation history

Most teams use one project per environment (Production, Staging, Dev).

## Creating Projects

### Basic Project Creation

```
Create a new Hawkeye project called "Production"
```

Uses `hawkeye_create_project`:

```
✓ Created project "Production"
UUID: abc-123-def-456
Status: Active
```

### With Description

```
Create a project called "Staging" for our staging environment
with description "Pre-production testing environment"
```

## Viewing Projects

### List All Projects

```
Show me all my Hawkeye projects
```

Uses `hawkeye_list_projects`:

```
Found 3 projects:

1. ⭐ Production (abc-123-def-456) [DEFAULT]
   Status: Active
   Connections: 5
   Instructions: 12

2. Staging (def-456-ghi-789)
   Status: Active
   Connections: 3
   Instructions: 8

3. Development (ghi-789-jkl-012)
   Status: Inactive
   Connections: 1
   Instructions: 2

Default project: Production
```

!!! info "Default Project"
    The ⭐ indicates your default project. All operations will use this project when you don't specify a project_uuid.

### Project Details

```
Show me details for my Production project
```

Uses `hawkeye_get_project_details`:

```
Production Project Details
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

UUID: abc-123-def-456
Status: Active
Created: 2024-01-10

Connections (5):
- Production AWS (AWS) - SYNCED
- Production Datadog (Datadog) - SYNCED
- Production PagerDuty (PagerDuty) - SYNCED
- Production Azure (Azure) - SYNCED
- Production New Relic (New Relic) - SYNCED

Instructions (12):
SYSTEM (3): Architecture context, Team info, ...
FILTER (4): Priority filter, Noise reduction, ...
RCA (5): Database steps, API latency, ...

Recent Activity:
- Last investigation: 2 hours ago
- Total investigations: 145
- Average MTTR: 8.5 minutes
```

## Switching Between Projects

### Set Default Project

Switch your active project context:

```
Switch to my Staging project
```

Or use the project name:

```
Set HTM-Azure as my default project
```

Uses `hawkeye_set_default_project`:

```
✓ Default project set to: Staging
UUID: def-456-ghi-789

All operations will now use this project by default.
```

**Benefits:**

- 🎯 **No more specifying project_uuid** - All tools use the default automatically
- 🔄 **Quick context switching** - Change between Production/Staging/Dev easily
- 💬 **Natural language** - Use project names instead of UUIDs

**When to Use:**

- Working on different environments (prod → staging → dev)
- Testing changes in a specific project
- Investigating issues in a particular environment
- Avoiding repetitive project_uuid parameters

**How It Works:**

1. Set default: `Switch to Production project`
2. All subsequent operations use Production
3. Optional: Override with explicit `project_uuid` parameter
4. Default persists for the entire MCP session

**Example Workflow:**

```
# Set context to Production
Switch to Production project

# All these commands use Production automatically
List my connections
Show recent investigations
Create a filter instruction

# Switch to Staging for testing
Switch to Staging project

# Now everything uses Staging
Test the new instruction
Check investigation results
```

## Updating Projects

### Change Project Name

```
Rename my Production project to "Production Environment"
```

Uses `hawkeye_update_project`:

```
✓ Updated project name
Old: "Production"
New: "Production Environment"
```

### Update Description

```
Update the description for Production project to:
"Primary production environment serving 10K+ users"
```

## Deleting Projects

!!! warning "Destructive Operation"
    Deleting a project removes all connections, instructions, and investigation history. This cannot be undone!

```
Delete project abc-123-def-456
```

Uses `hawkeye_delete_project`:

```
⚠️ WARNING: You are about to delete project "Old Dev Environment"

This will permanently remove:
- 2 connections
- 5 instructions
- 23 investigation sessions

Type 'confirm' to proceed:
```

After confirmation:

```
✓ Project deleted successfully
```

## Project Best Practices

### Naming Conventions

**Good names:**
- Production
- Staging
- Development
- Customer-Acme-Prod
- Region-US-East

**Avoid:**
- Proj1, Proj2 (not descriptive)
- test, testing (ambiguous)
- prod123 (unclear)

### Project Organization

**By Environment (with default project):**
```
⭐ Production (default for day-to-day operations)
   Staging (testing new features)
   Development (local development)
```

**Tips:**
- Set Production as default for normal operations
- Switch to Staging when testing new instructions
- Quickly switch back to Production after testing

**By Customer (MSP/Agency):**
```
- Customer-Acme-Production
- Customer-Beta-Production
- Internal-Tools
```

**By Region:**
```
- Production-US-East
- Production-EU-West
- Production-APAC
```

### Connection Strategy

**Start minimal:**
1. Primary cloud provider (AWS/Azure/GCP)
2. Main monitoring tool (Datadog/New Relic)
3. Alert management (PagerDuty/OpsGenie)

**Add as needed:**
- Secondary cloud providers
- Additional monitoring tools
- Specialized services

### Instruction Guidelines

**Essential instructions:**
1. SYSTEM: Architecture overview
2. FILTER: Priority thresholds
3. RCA: Common incident types

**Optional instructions:**
- GROUPING: Related alert grouping
- Additional RCA steps for specific scenarios

## Next Steps

<div class="grid cards" markdown>

-   :material-connection: __Managing Connections__

    ---

    Add cloud providers and monitoring tools

    [:octicons-arrow-right-24: Managing Connections](managing-connections.md)

-   :material-file-document-edit: __Testing Instructions__

    ---

    Create and test investigation instructions

    [:octicons-arrow-right-24: Testing Instructions](using-instructions.md)

-   :material-tools: __Advanced Workflows__

    ---

    Power user techniques

    [:octicons-arrow-right-24: Advanced Workflows](advanced-workflows.md)

</div>
