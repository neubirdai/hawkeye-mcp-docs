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
          "args": ["-y", "hawkeye-mcp-server@latest"],
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
          "args": ["-y", "hawkeye-mcp-server@latest"],
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
          "args": ["-y", "hawkeye-mcp-server@latest"],
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

## Next Steps

Once your client is configured, head over to [Quick Start](./quickstart.md) to verify 
connectivity with Hawkeye and run sample commands.
