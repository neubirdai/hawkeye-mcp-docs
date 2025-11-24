# Tool Reference Overview

Complete reference for all 40 Hawkeye MCP tools.

## Tool Categories

### [Projects](#projects) (5 tools)
Create and manage Hawkeye projects that organize connections and instructions.

### [Connections](#connections) (10 tools)
Connect to AWS, Azure, GCP, Datadog, PagerDuty, and other platforms.

### [Investigations](#investigations) (11 tools)
Investigate alerts, monitor real-time progress, get RCA results, and ask follow-up questions.

### [Instructions](#instructions) (7 tools)
Create, test, and manage investigation instructions.

### [Analytics](#analytics) (4 tools)
Track performance metrics, MTTR, and time saved.

### [Discovery](#discovery) (2 tools)
Explore available resources and data sources.

### [Help](#help) (1 tool)
Get interactive guidance and help.

---

## Projects

Tools for managing Hawkeye projects.

### hawkeye_list_projects

Lists all available projects.

**Parameters:**
- `include_inactive` (boolean, optional): Include inactive projects

**Example:**
```
List my Hawkeye projects
```

[Full Documentation →](tools/list-projects.md)

---

### hawkeye_create_project

Creates a new Hawkeye project.

**Parameters:**
- `name` (string, required): Project name
- `description` (string, optional): Project description
- `icon_style` (string, optional): Icon style

**Example:**
```
Create a project called "Production"
```

[Full Documentation →](tools/create-project.md)

---

### hawkeye_get_project_details

Gets detailed information about a project.

**Parameters:**
- `project_uuid` (string, optional): Project UUID (uses default if omitted)

**Example:**
```
Show me details for my Production project
```

[Full Documentation →](tools/get-project-details.md)

---

### hawkeye_update_project

Updates project properties.

**Parameters:**
- `project_uuid` (string, optional): Project UUID
- `name` (string, optional): New name
- `description` (string, optional): New description

**Example:**
```
Rename project to "Production Environment"
```

[Full Documentation →](tools/update-project.md)

---

### hawkeye_delete_project

Deletes a project (requires confirmation).

**Parameters:**
- `project_uuid` (string, required): Project UUID
- `confirm` (boolean, required): Must be true

**Example:**
```
Delete project abc-123-def-456
```

[Full Documentation →](tools/delete-project.md)

---

## Connections

Tools for managing cloud and monitoring tool connections.

### hawkeye_list_connections

Lists all available connections.

**Parameters:**
- `include_inactive` (boolean, optional): Include non-synced connections

**Example:**
```
Show me all my connections
```

[Full Documentation →](tools/list-connections.md)

---

### hawkeye_create_aws_connection

Creates an AWS connection.

**Parameters:**
- `name` (string, required): Connection name
- `aws_role_arn` (string, required): IAM role ARN
- `aws_external_id` (string, required): External ID
- `aws_regions` (array, required): AWS regions

**Example:**
```
Create AWS connection with role arn:aws:iam::123:role/Hawkeye
```

[Full Documentation →](tools/create-aws-connection.md)

---

### hawkeye_create_datadog_connection

Creates a Datadog connection.

**Parameters:**
- `name` (string, required): Connection name
- `datadog_api_key` (string, required): API key
- `datadog_app_key` (string, required): Application key
- `datadog_endpoint` (string, optional): Endpoint (default: datadoghq.com)

**Example:**
```
Create Datadog connection for Production
```

[Full Documentation →](tools/create-datadog-connection.md)

---

### hawkeye_wait_for_connection_sync

Waits for a connection to reach SYNCED state.

**Parameters:**
- `connection_uuid` (string, required): Connection UUID
- `wait_for_completion` (boolean, optional): Auto-poll until synced
- `max_wait_seconds` (number, optional): Max wait time (default: 300)

**Example:**
```
Wait for my AWS connection to sync
```

[Full Documentation →](tools/wait-for-connection-sync.md)

---

### hawkeye_add_connection_to_project

Adds connections to a project.

**Parameters:**
- `project_uuid` (string, optional): Project UUID
- `connection_uuids` (array, required): Connection UUIDs to add

**Example:**
```
Add my AWS and Datadog connections to Production
```

[Full Documentation →](tools/add-connection-to-project.md)

---

### hawkeye_list_project_connections

Lists connections for a project.

**Parameters:**
- `project_uuid` (string, optional): Project UUID

**Example:**
```
Show me connections for Production project
```

[Full Documentation →](tools/list-project-connections.md)

---

## Investigations

Tools for investigating alerts and getting RCA results.

### hawkeye_list_sessions

Lists investigation sessions with powerful filtering.

**Parameters:**
- `project_uuid` (string, optional): Project UUID
- `only_uninvestigated` (boolean, optional): **Show only uninvestigated alerts**
- `page` (number, optional): Page number
- `limit` (number, optional): Results per page (max: 100)
- `date_from` (string, optional): Start date filter
- `date_to` (string, optional): End date filter
- `search_term` (string, optional): Search by title
- `compact` (boolean, optional): Compact format

**Example:**
```
Show me uninvestigated alerts from the last 24 hours
```

[Full Documentation →](tools/list-sessions.md)

---

### hawkeye_investigate_alert

**START** a new investigation for an uninvestigated alert.

**Parameters:**
- `alert_id` (string, required): Alert ID from `incident_info.id`
- `project_uuid` (string, optional): Project UUID

**Example:**
```
Investigate alert /aws/alerts/cpu-spike-123
```

**Important:** Use `alert_id` from uninvestigated incidents list.

**Real-Time Progress:** After starting an investigation, use `hawkeye_get_investigation_status` to monitor real-time progress. The investigation streams updates as it runs, showing you each step and data source consultation.

[Full Documentation →](tools/investigate-alert.md)

---

### hawkeye_continue_investigation

Ask follow-up questions on an **already investigated** session.

**Parameters:**
- `session_uuid` (string, required): Session UUID from completed investigation
- `follow_up_prompt` (string, required): Your question

**Example:**
```
Why did this happen? Has it happened before?
```

**Important:** Use `session_uuid` from investigated sessions, not `alert_id`.

[Full Documentation →](tools/continue-investigation.md)

---

### hawkeye_get_investigation_status

Gets the current status and real-time progress of an investigation.

**Parameters:**
- `session_uuid` (string, required): Session UUID

**Returns:**
For in-progress investigations, this tool automatically connects to the live progress stream and provides:
- Current step being executed
- Progress percentage based on completed steps
- Data sources being consulted
- Step-by-step breakdown with chain of thought IDs
- Total steps completed vs estimated total
- Unique data sources consulted

For completed investigations, returns final status and summary.

**Example:**
```
Show me the status of this investigation
```

**Output includes:**
- `progress_percentage` (0-100): Completion percentage
- `current_step`: Human-readable description of current action
- `investigation_summary.unique_sources`: List of data sources consulted
- `investigation_summary.steps[].step_id`: Chain of thought ID for detailed lookup
- `investigation_summary.steps[].sources_consulted`: Sources used for each step
- `investigation_summary.steps[].category`: Step type (discovery, analysis, diagnosis, etc.)

---

### hawkeye_get_rca

Gets the complete Root Cause Analysis for an investigation.

**Parameters:**
- `session_uuid` (string, required): Session UUID

**Returns:**
- Incident summary
- Root cause
- Timeline
- Corrective actions (with bash scripts)
- Preventive measures
- Business impact
- Time saved

**Example:**
```
Show me the RCA for this investigation
```

**Recommended:** Use this FIRST after listing sessions.

[Full Documentation →](tools/get-rca.md)

---

### hawkeye_get_chain_of_thought

Gets investigation reasoning steps.

**Parameters:**
- `session_uuid` (string, required): Session UUID
- `category_filter` (string, optional): Filter by category

**Example:**
```
Show me the chain of thought for this investigation
```

[Full Documentation →](tools/get-chain-of-thought.md)

---

### hawkeye_get_investigation_queries

Gets detailed query execution logs.

**Parameters:**
- `session_uuid` (string, required): Session UUID

**Example:**
```
What queries were run during this investigation?
```

[Full Documentation →](tools/get-investigation-queries.md)

---

### hawkeye_get_investigation_sources

Gets data sources consulted during investigation.

**Parameters:**
- `session_uuid` (string, required): Session UUID

**Example:**
```
What data sources were checked?
```

[Full Documentation →](tools/get-investigation-sources.md)

---

### hawkeye_get_follow_up_suggestions

Gets suggested follow-up questions.

**Parameters:**
- `session_uuid` (string, required): Session UUID

**Example:**
```
What follow-up questions should I ask?
```

[Full Documentation →](tools/get-follow-up-suggestions.md)

---

### hawkeye_get_rca_score

Gets quality score for an RCA investigation.

**Parameters:**
- `session_uuid` (string, required): Session UUID

**Returns:**
- Accuracy scores (root cause, impact, timeline)
- Completeness scores (data sources, remediation, prevention)
- Qualitative feedback

**Example:**
```
Show me the quality score for this investigation
```

[Full Documentation →](tools/get-rca-score.md)

---

## Instructions

Tools for creating and testing investigation instructions.

### hawkeye_list_project_instructions

Lists instructions for a project.

**Parameters:**
- `project_uuid` (string, optional): Project UUID
- `instruction_type` (string, optional): Filter by type
- `status` (string, optional): Filter by status

**Example:**
```
Show me all active RCA instructions
```

[Full Documentation →](tools/list-project-instructions.md)

---

### hawkeye_create_project_instruction

Creates a new project instruction.

**Parameters:**
- `project_uuid` (string, optional): Project UUID
- `type` (enum, required): `INSTRUCTION_TYPE_FILTER | SYSTEM | GROUPING | RCA`
- `content` (string, required): Instruction content
- `enabled` (boolean, optional): Enable immediately

**Instruction Types:**
- **FILTER:** Filter out noise
- **SYSTEM:** Investigation context
- **GROUPING:** Group related alerts
- **RCA:** Investigation steps

**Example:**
```
Create a SYSTEM instruction about our architecture
```

[Full Documentation →](tools/create-project-instruction.md)

---

### hawkeye_validate_instruction

Validates an instruction before applying.

**Parameters:**
- `content` (string, required): Instruction content
- `type` (enum, required): Instruction type
- `project_uuid` (string, optional): Project context

**Returns:** Validated instruction with generated name and refined content

**Example:**
```
Validate this RCA instruction: "For database issues, check slow queries first"
```

[Full Documentation →](tools/validate-instruction.md)

---

### hawkeye_apply_session_instruction

Applies an instruction to a specific session for testing.

**Parameters:**
- `session_uuid` (string, required): Session UUID
- `content` (string, required): Instruction content
- `type` (enum, required): Instruction type
- `validate_first` (boolean, optional): Validate first (default: true)

**Example:**
```
Apply this instruction to session abc-123 for testing
```

[Full Documentation →](tools/apply-session-instruction.md)

---

### hawkeye_rerun_session

Re-runs an investigation with applied instructions.

**Parameters:**
- `session_uuid` (string, required): Session UUID

**Example:**
```
Rerun this session with the new instruction
```

[Full Documentation →](tools/rerun-session.md)

---

## Analytics

Tools for tracking performance and metrics.

### hawkeye_inspect_session

Gets session metadata.

**Parameters:**
- `session_uuid` (string, required): Session UUID

**Example:**
```
Inspect session metadata for abc-123
```

[Full Documentation →](tools/inspect-session.md)

---

### hawkeye_get_session_report

Gets summary reports for sessions.

**Parameters:**
- `session_uuids` (array, required): Session UUIDs
- `project_uuid` (string, required): Project UUID

**Example:**
```
Show me reports for these 3 sessions
```

[Full Documentation →](tools/get-session-report.md)

---

### hawkeye_get_session_summary

Gets detailed analysis and scoring.

**Parameters:**
- `session_uuid` (string, required): Session UUID

**Example:**
```
Show me the session summary
```

[Full Documentation →](tools/get-session-summary.md)

---

### hawkeye_get_incident_report

Gets comprehensive incident statistics across ALL investigations.

**Parameters:** None

**Returns:**
- MTTR
- Time saved
- Noise reduction
- Organization-wide analytics

**Example:**
```
Show me our incident statistics
```

[Full Documentation →](tools/get-incident-report.md)

---

## Discovery

Tools for exploring available resources.

### hawkeye_discover_project_resources

Aggregates ALL available resources across project connections.

**Parameters:**
- `project_uuid` (string, optional): Project UUID
- `telemetry_type_filter` (string, optional): Filter by telemetry type
- `connection_type_filter` (string, optional): Filter by connection type

**Example:**
```
Show me all available log sources
```

[Full Documentation →](tools/discover-project-resources.md)

---

### hawkeye_list_connection_resource_types

Gets resource types for a connection type + telemetry type combination.

**Parameters:**
- `connection_type` (string, required): Connection type
- `telemetry_type` (string, required): Telemetry type

**Example:**
```
Show me AWS log resource types
```

[Full Documentation →](tools/list-connection-resource-types.md)

---

## Help

### hawkeye_get_guidance

Interactive help system with embedded knowledge base.

**Parameters:**
- `question` (string, required): Your question
- `topic` (enum, optional): Specific topic area

**Topics:**
- `connections` - Setup and configuration
- `projects` - Project management
- `investigations` - How to investigate alerts
- `instructions` - Creating and testing instructions
- `onboarding` - Getting started
- `troubleshooting` - Common issues

**Example:**
```
How do I create an AWS connection?
```

---

## Quick Workflows

### Investigate an Alert
```
1. hawkeye_list_sessions (only_uninvestigated=true)
2. hawkeye_investigate_alert (with alert_id)
3. hawkeye_get_investigation_status (monitor real-time progress)
4. hawkeye_get_rca (get results when complete)
5. hawkeye_continue_investigation (optional follow-up)
```

### Test an Instruction
```
1. hawkeye_validate_instruction
2. hawkeye_apply_session_instruction
3. hawkeye_rerun_session
4. hawkeye_get_rca (compare results)
5. hawkeye_create_project_instruction (if improved)
```

### Complete Onboarding
```
1. hawkeye_create_project
2. hawkeye_create_aws_connection
3. hawkeye_wait_for_connection_sync
4. hawkeye_add_connection_to_project
5. hawkeye_create_project_instruction (SYSTEM)
6. hawkeye_list_sessions (only_uninvestigated=true)
7. hawkeye_investigate_alert
```

## Tool Count Summary

- **Projects:** 5 tools
- **Connections:** 10 tools
- **Investigations:** 11 tools
- **Instructions:** 7 tools
- **Analytics:** 4 tools
- **Discovery:** 2 tools
- **Help:** 1 tool

**Total: 40 tools**

## See Also

- [Complete Onboarding Guide](../guides/onboarding.md)
- [Running Investigations Guide](../guides/running-investigations.md)
- [Using Instructions Guide](../guides/using-instructions.md)
- [Examples](../examples/complete-setup.md)
