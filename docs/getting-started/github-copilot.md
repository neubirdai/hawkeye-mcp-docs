# GitHub Copilot Setup

Complete guide to integrating Hawkeye MCP with GitHub Copilot in VS Code.

## Overview

GitHub Copilot in VS Code supports Model Context Protocol through extensions. This integration gives you AI-powered incident investigation directly in Visual Studio Code.

**What you'll get:**

- 39 Hawkeye tools available in VS Code
- Investigation workflows in your editor
- Context-aware incident analysis
- Integration with your development workflow

## Prerequisites

- [x] VS Code installed ([download here](https://code.visualstudio.com))
- [x] GitHub Copilot subscription
- [x] Hawkeye account credentials
- [x] Node.js 20+ installed (for npx)

## Installation Steps

### 1. Install Required Extensions

Install the MCP extension for VS Code:

1. Open VS Code
2. Go to Extensions (Cmd+Shift+X / Ctrl+Shift+X)
3. Search for "Model Context Protocol"
4. Install the **"MCP for GitHub Copilot"** extension

!!! info "Extension Name"
    The exact extension name may vary. Look for extensions that enable MCP support in GitHub Copilot.

### 2. Configure MCP Servers

Open VS Code settings and configure MCP:

**Method 1: Using Settings UI**

1. Open Settings (Cmd+, / Ctrl+,)
2. Search for "MCP"
3. Find "MCP: Servers" setting
4. Click "Edit in settings.json"

**Method 2: Direct Edit**

Press `Cmd+Shift+P` (Mac) or `Ctrl+Shift+P` (Windows/Linux), type "Preferences: Open User Settings (JSON)"

### 3. Add Hawkeye Configuration

Add the following to your `settings.json`:

=== "Using npx (Recommended)"

    ```json
    {
      "mcp.servers": {
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

    **Pros:**

    - ✅ No installation required
    - ✅ Always uses latest version
    - ✅ Fastest to set up

=== "Using Global Install"

    First install globally:

    ```bash
    npm install -g hawkeye-mcp-server
    ```

    Then configure:

    ```json
    {
      "mcp.servers": {
        "hawkeye": {
          "command": "hawkeye-mcp",
          "env": {
            "HAWKEYE_EMAIL": "your-email@company.com",
            "HAWKEYE_PASSWORD": "your-password",
            "HAWKEYE_BASE_URL": "https://app.neubird.ai/api"
          }
        }
      }
    }
    ```

    **Pros:**

    - ✅ Faster startup time
    - ✅ Works offline (once installed)
    - ✅ Version control

!!! warning "Replace credentials"
    Don't forget to replace the example email, password, and URL with your actual Hawkeye credentials!

### 4. Reload VS Code

Reload VS Code to activate the MCP server:

1. Press `Cmd+Shift+P` / `Ctrl+Shift+P`
2. Type "Reload Window"
3. Press Enter

### 5. Verify Installation

Open GitHub Copilot Chat and verify:

```
@mcp list available tools
```

You should see 39 Hawkeye tools in the list, including:
- `hawkeye_list_projects`
- `hawkeye_investigate_alert`
- `hawkeye_get_rca`
- And 36 more...

## Configuration Options

### Environment Variables

| Variable | Required | Description |
|----------|----------|-------------|
| `HAWKEYE_EMAIL` | Yes | Your Hawkeye account email |
| `HAWKEYE_PASSWORD` | Yes | Your Hawkeye password |
| `HAWKEYE_BASE_URL` | Yes | API endpoint (usually `https://app.neubird.ai/api`) |

### Custom Instance

For enterprise customers with dedicated instances:

```json
{
  "mcp.servers": {
    "hawkeye": {
      "command": "npx",
      "args": ["-y", "hawkeye-mcp-server"],
      "env": {
        "HAWKEYE_EMAIL": "your-email@company.com",
        "HAWKEYE_PASSWORD": "your-password",
        "HAWKEYE_BASE_URL": "https://your-company.app.neubird.ai/api"
      }
    }
  }
}
```

## Usage Examples

### Investigate While Coding

Open Copilot Chat and ask:

```
@mcp Check Hawkeye for recent alerts related to the payment service
```

### Get RCA for Current Code

```
@mcp Get the root cause analysis for the latest database-related incident
```

### Review Investigation History

```
@mcp Show me all investigations from the last 7 days
```

### Context-Aware Analysis

```
@mcp This code handles user authentication. Check Hawkeye for any auth-related incidents in the past week
```

## Troubleshooting

### Extension Not Found

**Problem:** Can't find MCP extension in VS Code marketplace

**Solution:**

As of now, MCP support in GitHub Copilot may be in preview. Check:

1. GitHub Copilot Labs extension
2. VS Code Insiders build
3. Alternative: Use **Continue** extension which has MCP support

### Tools Not Available

**Problem:** Copilot doesn't recognize Hawkeye tools

**Solution:**

1. Verify MCP extension is installed and enabled
2. Check `settings.json` syntax (must be valid JSON)
3. Reload VS Code window
4. Check Output panel for MCP errors: `View > Output > Select "MCP"`

### Authentication Failed

**Problem:** `401 Unauthorized` error

**Solution:**

1. Verify email and password in settings.json
2. Ensure `HAWKEYE_BASE_URL` ends with `/api`
3. Test credentials at Hawkeye web UI
4. Check for typos in settings file

### Command Not Found

**Problem:** `npx: command not found`

**Solution:**

1. Install Node.js 20+: [nodejs.org](https://nodejs.org)
2. Verify installation: `node --version`
3. Restart VS Code after installing Node.js
4. Try global install method instead

## Alternative: Continue Extension

If GitHub Copilot's MCP support is not available yet, use the **Continue** extension:

### 1. Install Continue

1. Open VS Code Extensions
2. Search for "Continue"
3. Install **"Continue - AI Code Assistant"**

### 2. Configure Continue

Open Continue settings (`.continue/config.json` in your home directory):

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

### 3. Use Continue with Hawkeye

Open Continue sidebar (Cmd+L / Ctrl+L) and ask:

```
List my Hawkeye projects
```

## Advanced Configuration

### Multiple Instances

To work with different Hawkeye instances:

```json
{
  "mcp.servers": {
    "hawkeye-prod": {
      "command": "npx",
      "args": ["-y", "hawkeye-mcp-server"],
      "env": {
        "HAWKEYE_EMAIL": "user@company.com",
        "HAWKEYE_PASSWORD": "password",
        "HAWKEYE_BASE_URL": "https://app.neubird.ai/api"
      }
    },
    "hawkeye-staging": {
      "command": "npx",
      "args": ["-y", "hawkeye-mcp-server"],
      "env": {
        "HAWKEYE_EMAIL": "user@company.com",
        "HAWKEYE_PASSWORD": "password",
        "HAWKEYE_BASE_URL": "https://staging.app.neubird.ai/api"
      }
    }
  }
}
```

### Workspace-Specific Configuration

For project-specific settings, add to `.vscode/settings.json` in your project:

```json
{
  "mcp.servers": {
    "hawkeye": {
      "command": "npx",
      "args": ["-y", "hawkeye-mcp-server"],
      "env": {
        "HAWKEYE_EMAIL": "${env:HAWKEYE_EMAIL}",
        "HAWKEYE_PASSWORD": "${env:HAWKEYE_PASSWORD}",
        "HAWKEYE_BASE_URL": "https://app.neubird.ai/api"
      }
    }
  }
}
```

Then set environment variables in your shell.

## Tips for Using Hawkeye in VS Code

### 1. Correlate Code with Incidents

When debugging:
```
@mcp Check Hawkeye for incidents related to this database query in the last week
```

### 2. Quick Investigation

Use keyboard shortcuts:
1. Highlight code
2. Open Copilot Chat
3. Ask about related incidents

### 3. Generate Fix Scripts

```
@mcp Get corrective actions for session abc-123 and format as executable bash scripts
```

### 4. Review Before Merge

```
@mcp Check if there are any recent incidents related to the authentication service before I merge this PR
```

## Next Steps

Now that you've set up GitHub Copilot with Hawkeye, here's what to do next:

**[Quick Start Guide →](quickstart.md)**
Try your first investigation

**[Complete Onboarding →](../guides/onboarding.md)**
Full setup from scratch

**[Guides →](../guides/onboarding.md)**
Explore comprehensive guides and workflows

## See Also

- [Authentication Guide](authentication.md) - Detailed credential setup
- [Troubleshooting](../troubleshooting.md) - Common issues and solutions
- [FAQ](../faq.md) - Frequently asked questions
- [Continue Extension](https://continue.dev) - Alternative MCP client for VS Code
