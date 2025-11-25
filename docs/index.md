# Hawkeye MCP Server

<div class="hero">
  <h1>AI-Powered Incident Investigation</h1>
  <p>Connect your AI assistant to Hawkeye's autonomous incident response platform through Model Context Protocol</p>
  <p>
    <a href="getting-started/installation/" class="md-button md-button--primary">Get Started</a>
    <a href="guides/onboarding/" class="md-button">Complete Guide</a>
  </p>
</div>

---

## What is Hawkeye MCP?

Hawkeye MCP Server is a **Model Context Protocol** server that enables AI assistants like Claude to interact with [NeuBird's Hawkeye platform](https://neubird.ai) for automated incident investigation and root cause analysis.

## Prerequisites

Before you begin, you'll need:

- ✅ **Active Hawkeye account** - [Contact NeuBird](https://neubird.ai/contact-us/) to get started
- ✅ **Node.js 20+** - [Download Node.js](https://nodejs.org/)
- ✅ **Connected data source** - At least one cloud provider ([AWS](https://neubird.ai/agentic-ai-for-aws/), Azure, GCP) or monitoring tool (Datadog, PagerDuty, etc.)
- ✅ **MCP-compatible client** - Claude Desktop, Claude Code, Cursor, or GitHub Copilot

## What You Can Do

With Hawkeye MCP, you can:

- 🔍 **Investigate alerts automatically** - AI-powered root cause analysis for your incidents
- 🔗 **Connect multi-cloud environments** - [AWS](https://neubird.ai/agentic-ai-for-aws/), Azure, GCP, Datadog, PagerDuty, and more
- 🎯 **Test instructions safely** - Validate and test investigation instructions before deployment
- 📊 **Track performance** - Monitor MTTR, time saved, and investigation quality
- 🤖 **Autonomous remediation** - Get actionable corrective actions with bash scripts

<div class="feature-grid">
  <a href="getting-started/installation/" class="feature-card">
    <h3>🚀 Quick Setup</h3>
    <p>Install via npm and connect to Hawkeye in minutes. Works with Claude Desktop, Claude Code, Cursor, GitHub Copilot, and any MCP-compatible client.</p>
  </a>

  <a href="reference/overview/" class="feature-card">
    <h3>🔌 43 Tools</h3>
    <p>Comprehensive API covering projects, connections, investigations, instructions, and analytics.</p>
  </a>

  <a href="faq/" class="feature-card">
    <h3>📖 Built-in Guidance</h3>
    <p>Interactive help system with embedded knowledge base. Ask questions and get instant answers.</p>
  </a>

  <a href="guides/testing-instructions/" class="feature-card">
    <h3>🧪 Test Before Deploy</h3>
    <p>Unique instruction testing workflow - validate, apply to session, rerun, and compare results.</p>
  </a>
</div>

## Quick Start

### Installation

```bash
npm install hawkeye-mcp-server
```

### Configuration

Create a `.env` file:

```bash
HAWKEYE_EMAIL=your-email@company.com
HAWKEYE_PASSWORD=your-password
HAWKEYE_BASE_URL=https://app.neubird.ai/api
```

### AI Client Setup

Configure your preferred AI client:

- **[Claude Desktop](getting-started/claude-desktop.md)** - Native Anthropic desktop app
- **[Claude Code](getting-started/claude-code.md)** - Terminal-based AI assistant
- **[Cursor](getting-started/cursor.md)** - AI-powered code editor
- **[GitHub Copilot](getting-started/github-copilot.md)** - VS Code integration

Example configuration for Claude Desktop (`~/Library/Application Support/Claude/claude_desktop_config.json`):

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

Restart your AI client and you're ready to go!

[Full Installation Guide →](getting-started/installation.md){ .md-button }

## Core Workflows

### Investigate an Alert

```
1. List uninvestigated alerts
   hawkeye_list_sessions(only_uninvestigated=true)

2. Start investigation
   hawkeye_investigate_alert(alert_id="...")

3. Get root cause analysis
   hawkeye_get_rca(session_uuid="...")

4. Ask follow-up questions
   hawkeye_continue_investigation(session_uuid="...", follow_up_prompt="...")
```

[Investigation Guide →](guides/running-investigations.md){ .md-button }
[Prompt Engineering Tips →](guides/prompt-engineering.md){ .md-button }

### Create Manual Investigation

```
1. Start investigation with custom prompt
   hawkeye_create_manual_investigation(
     prompt="Investigate high latency in payment-service between 2pm-3pm EST on Jan 15.
             Users reported slow checkout."
   )

2. Get root cause analysis
   hawkeye_get_rca(session_uuid="...")

3. Ask follow-up questions
   hawkeye_continue_investigation(session_uuid="...", follow_up_prompt="...")
```

**Use cases:**
- Proactive investigations without alerts
- Testing scenarios and "what-if" analysis
- Historical incident research
- Training and documentation

**Tip:** Be specific! Include service names, timeframes, and symptoms for best results.

[Manual Investigation Guide →](guides/running-investigations.md#manual-investigations){ .md-button }
[Prompt Engineering Tips →](guides/prompt-engineering.md){ .md-button }

### Test an Instruction

```
1. Validate instruction
   hawkeye_validate_instruction(content="...", type="...")

2. Apply to test session
   hawkeye_apply_session_instruction(session_uuid="...", content="...")

3. Rerun investigation
   hawkeye_rerun_session(session_uuid="...")

4. Compare RCA results
   hawkeye_get_rca(session_uuid="...")

5. Add to project if good
   hawkeye_create_project_instruction(content="...", type="...")
```

[Instruction Testing Guide →](guides/using-instructions.md){ .md-button }

### Complete Onboarding

```
1. Add connections ([AWS](https://neubird.ai/agentic-ai-for-aws/), Datadog, etc.)
   hawkeye_create_aws_connection(...)
   hawkeye_wait_for_connection_sync(...)

2. Create project
   hawkeye_create_project(name="Production")
   hawkeye_set_default_project(project_uuid="...")

3. Link connections to project
   hawkeye_add_connection_to_project(connection_uuids=[...])

4. Run first investigation
   hawkeye_create_manual_investigation(prompt="...")

5. Investigate real alerts
   hawkeye_list_sessions(only_uninvestigated=true)
   hawkeye_investigate_alert(alert_id="...")

6. Configure instructions
   hawkeye_create_project_instruction(type="SYSTEM", content="...")
```

[Complete Onboarding Guide →](guides/onboarding.md){ .md-button }

## Key Features

### 🧪 Unique Instruction Testing

Hawkeye MCP is the only incident investigation tool that lets you **test instructions before deploying them**:

1. Apply instruction to a single past investigation
2. Rerun that investigation with the new instruction
3. Compare the new RCA with the original
4. Only add to project if it improves results

This prevents bad instructions from affecting all your investigations.

### 📊 Comprehensive Analytics

Track your incident response performance:

- **MTTR** - Mean Time To Resolution
- **Time Saved** - Hours saved vs manual investigation
- **Investigation Quality** - Accuracy and completeness scores
- **Noise Reduction** - Grouped incidents and filtered alerts

### 🔍 Deep Investigation Insights

Every investigation provides:

- **Root Cause Analysis** - What went wrong and why
- **Timeline** - Chronological event breakdown
- **Corrective Actions** - Immediate fixes (including bash scripts)
- **Preventive Measures** - Long-term improvements
- **Chain of Thought** - How Hawkeye reasoned through the problem

## Resources

- 📚 [Full Documentation](getting-started/installation.md)
- 🎓 [Guides & Tutorials](guides/onboarding.md)
- 💡 [Examples](examples/complete-setup.md)
- 📖 [Hawkeye Platform Documentation](https://help.neubird.ai/introduction/overview/)
- ❓ [FAQ](faq.md)
- 🐛 [Troubleshooting](troubleshooting.md)

## Support

- **Documentation:** [https://neubirdai.github.io/hawkeye-mcp-docs](https://neubirdai.github.io/hawkeye-mcp-docs)
- **NeuBird Website:** [https://neubird.ai](https://neubird.ai)
- **Book a Demo:** [https://neubird.ai/contact-us/](https://neubird.ai/contact-us/)
- **GitHub:** [https://github.com/neubirdai/hawkeye-mcp-docs](https://github.com/neubirdai/hawkeye-mcp-docs)

---

<small>Made with ❤️ by [NeuBird AI](https://neubird.ai) | Copyright © 2024 NeuBird AI</small>
