# Installation

Let your AI agents interact with Hawkeye's autonomous incident investigation platform using the Model Context Protocol.

## Prerequisites

Before you begin, you'll need:

- ✅ **Active Hawkeye account** - [Contact NeuBird](https://neubird.ai/contact-us/) to get started
- ✅ **Node.js 20+** - [Download Node.js](https://nodejs.org/)
- ✅ **Connected data source** - At least one cloud provider ([AWS](https://neubird.ai/agentic-ai-for-aws/), Azure, GCP) or monitoring tool (Datadog, PagerDuty, etc.)
- ✅ **MCP-compatible client** - Claude Code, Cursor, or GitHub Copilot

## MCP Configuration

Set your Hawkeye environment variables:

```bash
export HAWKEYE_EMAIL="your-email@company.com"
export HAWKEYE_PASSWORD="your-password"
export HAWKEYE_BASE_URL="https://<env>.app.neubird.ai/api"
```

Configure your MCP client to use `hawkeye-mcp-server`:

=== "Cursor"

    Create `.cursor/mcp.json` in your project with the following content:

    ```json
    {
      "mcpServers": {
        "hawkeye": {
          "command": "npx",
          "args": ["-y", "hawkeye-mcp-server"],
          "env": {
            "HAWKEYE_EMAIL": "${env:HAWKEYE_EMAIL}",
            "HAWKEYE_PASSWORD": "${env:HAWKEYE_PASSWORD}",
            "HAWKEYE_BASE_URL": "${env:HAWKEYE_BASE_URL}"
          }
        }
      }
    }
    ```

    [View Cursor MCP documentation →](https://cursor.com/docs/context/mcp)

=== "Claude Code"

    Add this configuration in `.mcp.json` file of your project directory:

    ```json
    {
      "mcpServers": {
        "hawkeye": {
          "command": "npx",
          "args": ["-y", "hawkeye-mcp-server"],
          "env": {
            "HAWKEYE_EMAIL": "${HAWKEYE_EMAIL}",
            "HAWKEYE_PASSWORD": "${HAWKEYE_PASSWORD}",
            "HAWKEYE_BASE_URL": "${HAWKEYE_BASE_URL}"
          }
        }
      }
    }
    ```

    [View Claude Code MCP documentation →](https://code.claude.com/docs/en/mcp)

=== "GitHub Copilot"

    Add the `.vscode/mcp.json` file to your workspace:

    ```json
    {
      "servers": {
        "hawkeye": {
          "command": "npx",
          "args": ["-y", "hawkeye-mcp-server"],
          "env": {
            "HAWKEYE_EMAIL": "${HAWKEYE_EMAIL}",
            "HAWKEYE_PASSWORD": "${HAWKEYE_PASSWORD}",
            "HAWKEYE_BASE_URL": "${HAWKEYE_BASE_URL}"
          }
        }
      }
    }
    ```

    [View GitHub Copilot MCP documentation →](https://code.visualstudio.com/docs/copilot/customization/mcp-servers)

## What You Can Do

- **Investigate alerts automatically** - AI-powered root cause analysis for your incidents
- **Connect multi-cloud environments** - AWS, Azure, GCP, Datadog, PagerDuty, and more
- **Test instructions safely** - Validate investigation instructions before deployment
- **Track performance** - Monitor MTTR, time saved, and investigation quality

## Next Steps

Once your client is configured:

- [Complete Onboarding Guide](../guides/onboarding.md) - Step-by-step guide to add connections, create projects, and run your first investigation
- [API Reference](../reference/overview.md) - Full list of available tools and capabilities
- [Hawkeye Platform Documentation](https://help.neubird.ai/introduction/overview/) - Learn more about the Hawkeye platform
- [FAQ](../faq.md) - Common questions and answers
