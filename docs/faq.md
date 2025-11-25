# Frequently Asked Questions

Common questions about Hawkeye MCP Server.

## General

### What is Hawkeye MCP?

Hawkeye MCP Server is a Model Context Protocol server that connects AI assistants (like Claude) to NeuBird's Hawkeye platform for autonomous incident investigation and root cause analysis.

### What can I do with Hawkeye MCP?

- Investigate alerts automatically with AI-powered RCA
- Get actionable corrective actions your coding agent can execute
- Track MTTR and time saved metrics
- Test investigation instructions before deployment
- Connect multi-cloud environments (AWS, Azure, GCP)
- Integrate with monitoring tools (Datadog, PagerDuty, etc.)

### How much does it cost?

Hawkeye MCP Server is free to use. You need a Hawkeye account, which is a commercial product. [Contact NeuBird](https://neubird.ai) for Hawkeye pricing.

### Is my data secure?

Yes. Hawkeye MCP uses read-only access to your cloud resources and telemetry. All credentials are stored securely by Hawkeye and Neubird is SOC2 certified so you can trust them with security.

## Installation & Setup

### Which AI clients are supported?

- **Claude Desktop** - Anthropic's native desktop app 
- **Claude Code** - Terminal-based AI assistant
- **Cursor** - AI-powered code editor
- **GitHub Copilot** - VS Code with MCP extension
- **Continue** - VS Code extension with MCP support
- Any MCP-compatible client

See [Installation Guide](getting-started/installation.md) for setup instructions for each client.

### Do I need Node.js?

Yes, Node.js 20 or higher is required.

### Can I use it without installing globally?

Yes, use `npx hawkeye-mcp-server` to run without installation.

### Where are credentials stored?

In your MCP client configuration file:
- **Claude Desktop:** `~/Library/Application Support/Claude/claude_desktop_config.json` (macOS)
- **Claude Code:**
  - `~/.claude.json` (user scope - most common)
  - `.mcp.json` in project root (project scope - for teams)
  - Use `/mcp` command to see which file is being used

## Features

### How many tools are available?

43 tools across 7 categories:
- Projects (5)
- Connections (10)
- Investigations (11)
- Instructions (7)
- Analytics (4)
- Discovery (2)
- Help (1)

### What makes Hawkeye MCP unique?

The **instruction testing workflow** - you can test investigation instructions on past incidents before deploying them, preventing bad instructions from affecting all investigations.

### How long does an investigation take?

- **Typical:** 30-90 seconds
- **First investigation:** 5-10 minutes (initial connection sync)
- **Complex incidents:** Up to 2 minutes

### Can I investigate past incidents?

Yes! Use `hawkeye_list_sessions` to find past incidents, then `hawkeye_continue_investigation` to ask follow-up questions.

### Can I get a link to share an investigation?

Yes! After listing investigations, you can request a direct link to view them in the Hawkeye web interface:

```
Link for #2
Link for sessionID abc-123-def-456
```

This is useful for:
- Sharing investigations with team members
- Adding to incident tickets
- Viewing in the full web interface
- Bookmarking important investigations

## Connections

### Which cloud providers are supported?

- AWS (CloudWatch, EC2, RDS, Lambda, ECS)
- Azure (Azure Monitor, VMs, Functions)
- GCP (Cloud Logging, Monitoring, Compute)

### Which monitoring tools are supported?

- Datadog
- PagerDuty
- New Relic
- And more...

Ask Claude: "What connection types are available?"

### Do I need to connect all my cloud providers?

No, start with your primary cloud provider and main monitoring tool. Add others as needed.

### How long does connection sync take?

- **First sync:** 5-15 minutes depending on resource count
- **Subsequent syncs:** Automatic, real-time
- **Large environments:** Up to 15 minutes initial sync

### What permissions do connections need?

- **AWS:** ReadOnlyAccess IAM policy
- **Azure:** Reader role
- **GCP:** Viewer role
- **Datadog:** Read-only API and app keys

## Investigations

### How do I investigate an alert?

```
1. Show me uninvestigated alerts
2. Investigate [alert-id or "the first one"]
3. Show me the RCA
```

### Can I create investigations without alerts?

**Yes!** Use manual investigations to analyze issues without existing alerts:

```
Investigate high latency in payment-service between 2pm-3pm EST on Jan 15.
Users reported checkout taking 30+ seconds.
```

**Use cases:**
- Proactive analysis before alerts fire
- Historical incident research
- Testing "what-if" scenarios
- Training and documentation

**Tip:** Be specific! Include service names, timeframes, and symptoms. Vague prompts like "something broke" won't work well.

See [Manual Investigations Guide](guides/running-investigations.md#manual-investigations) for details.

### What's the difference between alert_id and session_uuid?

- **alert_id:** For NEW uninvestigated alerts (use with `hawkeye_investigate_alert`)
- **session_uuid:** For EXISTING investigations (use with `hawkeye_continue_investigation`)

### Can I ask follow-up questions?

Yes! After getting an RCA, ask:
- "Why did this happen?"
- "Has this happened before?"
- "How can we prevent this?"

### What if the RCA is wrong?

1. Ask clarifying follow-up questions
2. Add instructions to guide future investigations
3. Test instructions on past sessions
4. Only deploy if RCA improves

### Can I investigate multiple alerts at once?

Yes, in separate Claude conversations. Each conversation can handle one investigation at a time.

## Instructions

### What are instructions?

Instructions guide Hawkeye's investigation behavior:
- **FILTER:** Reduce noise
- **SYSTEM:** Provide context
- **GROUPING:** Group related alerts
- **RCA:** Investigation steps

### How do I test an instruction?

```
1. Validate instruction
2. Apply to test session
3. Rerun session
4. Compare new vs old RCA
5. Add to project if improved
```

### Can I modify instructions after creating them?

You can enable/disable them using `hawkeye_update_project_instruction_status`. To modify content, delete and recreate.

### How many instructions should I have?

**Start with:**
- 1-2 SYSTEM instructions (architecture context)
- 1 FILTER instruction (priority threshold)
- 2-3 RCA instructions (common incident types)

**Add more as needed** based on incident patterns.

## Analytics

### What metrics can I track?

- MTTR (Mean Time To Resolution)
- Time saved vs manual investigation
- Investigation quality scores
- Noise reduction from filtering
- Incident patterns and trends

### How is "time saved" calculated?

Compares estimated manual investigation time vs actual Hawkeye investigation time.

**Example:**
- Manual estimate: 45 minutes
- Hawkeye time: 60 seconds
- Time saved: 44 minutes

### What's a good quality score?

- **85-100:** Excellent
- **70-84:** Good
- **<70:** Needs improvement (add more instructions)

## Troubleshooting

### Tools not showing in Claude Desktop

1. Check config file syntax (JSON valid?)
2. Verify file location
3. Restart Claude Desktop completely
4. Check logs: `~/Library/Logs/Claude/mcp*.log`

### Authentication failed

1. Verify email and password correct
2. Check `HAWKEYE_BASE_URL` ends with `/api`
3. Test login at Hawkeye web UI
4. No extra spaces in credentials

### Investigation taking too long

- First investigation: Normal (5-10 min sync)
- Complex incidents: Normal (up to 2 min)
- Check connection sync status

### Connection won't sync

1. Wait longer (first sync takes time)
2. Verify credentials correct
3. Check permissions (ReadOnly access)
4. Check network connectivity

See [Troubleshooting](troubleshooting.md) for more solutions.

## Best Practices

### What's the recommended onboarding flow?

1. Install Hawkeye MCP
2. Create one project
3. Add 1-2 connections (primary cloud + monitoring)
4. Wait for sync
5. Add basic instructions (SYSTEM + FILTER)
6. Investigate first alert
7. Refine instructions based on results

### How often should I review instructions?

- **Weekly:** Review investigation quality scores
- **Bi-weekly:** Update instructions based on patterns
- **Monthly:** Clean up unused instructions

### Should I create separate projects for each environment?

Yes, recommended:
- Production/Staging/Development projects
- Application specific projects
- Team specific projects
- Alert specific projects

Each can have different connections and instructions. You can use the same connections in multiple projects and by using investigation instructions you can control which alerts gets investigated in each project. This makes it possible to have specialized instructions in separate projects.

### How do I switch between projects?

Use `hawkeye_set_default_project` to switch your active project context:

```
Switch to my Staging project
```

Or use the project UUID directly:

```
hawkeye_set_default_project(project_uuid="abc-123...")
```

**Benefits:**
- No need to specify `project_uuid` in every command
- Quick context switching between environments
- Natural language support (use project names)
- Default persists for entire MCP session

**Example workflow:**
```
# Set Production as default
Switch to Production project

# All commands now use Production
List my project's connections
Show recent investigations

# Switch to Staging for testing
Switch to Staging project

# Now everything uses Staging
Test the new instruction
```

The default project is shown with a ⭐ emoji when you list projects.

### What's the fastest way to get started?

Follow the [Quick Start Guide](getting-started/quickstart.md) - takes 5 minutes.

## Advanced

### Can I use multiple Hawkeye instances?

Yes! Use `hawkeye_switch_instance` to switch between dev/staging/prod instances or different customer instances.

### Can I integrate with CI/CD?

Yes, you can trigger investigations from deployment pipelines and extract corrective actions programmatically.

### Can I export investigation results?

Yes, RCA results are returned as formatted text that you can copy, export, or integrate with ticketing systems.

### What's the API rate limit?

Hawkeye MCP respects Hawkeye API rate limits. For high-volume usage, contact NeuBird support.

## Support

### Where can I get help?

1. **Documentation:** [Full docs](https://neubirdai.github.io/hawkeye-mcp-docs)
2. **Inline help:** Ask Claude "How do I..." using the guidance system
3. **Troubleshooting:** [Common issues](troubleshooting.md)
4. **Support:** Email support@neubird.ai

### How do I report a bug?

Email support@neubird.ai with:
- Error message
- Steps to reproduce
- MCP server version
- Logs (if available)

### Where's the source code?

The MCP server is distributed as an npm package. The code is currently private.

### How do I request a feature?

Contact support@neubird.ai or your NeuBird account representative.

## See Also

- [Installation Guide](getting-started/installation.md)
- [Quick Start](getting-started/quickstart.md)
- [Complete Onboarding](guides/onboarding.md)
- [Troubleshooting](troubleshooting.md)
- [Guides](guides/onboarding.md)
