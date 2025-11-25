# Installation

Let your AI agents interact with Hawkeye's autonomous incident investigation platform using the Model Context Protocol.

## Prerequisites

Node.js >= 20.0.0 is required. Download from [nodejs.org](https://nodejs.org/) or use your package manager:

```bash
# macOS
brew install node@20

# Linux (Ubuntu/Debian)
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs
```

Check your Node.js version:

```bash
node --version
# Should output v20.0.0 or higher
```

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

    Add this configuration within `.mcp.json` file of your project directory:

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

    Add this configuration to `.vscode/mcp.json`:

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

    [View GitHub Copilot setup documentation →](github-copilot.md)

=== "OpenAI"

    Add this configuration to your OpenAI MCP settings:

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

    [View OpenAI setup documentation →](installation.md)

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
