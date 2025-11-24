# Cursor Setup

Complete guide to integrating Hawkeye MCP with Cursor (AI-powered code editor).

## Overview

Cursor is an AI-first code editor built on VS Code that supports Model Context Protocol. This integration gives you AI-powered incident investigation directly in your development environment.

**What you'll get:**

- 39 Hawkeye tools available in Cursor
- Investigation workflows while coding
- Context-aware incident analysis
- Direct integration with your codebase

## Prerequisites

- [x] Cursor installed ([download here](https://cursor.sh))
- [x] Hawkeye account credentials
- [x] Node.js 20+ installed (for npx)

## Installation Steps

### 1. Open Cursor Settings

Access MCP settings in Cursor:

1. Open Cursor
2. Press `Cmd+Shift+P` (Mac) or `Ctrl+Shift+P` (Windows/Linux)
3. Type "MCP" and select **"MCP: Open Settings"**

Or manually locate the file:

=== "macOS"

    ```
    ~/Library/Application Support/Cursor/User/globalStorage/saoudrizwan.claude-dev/settings/cline_mcp_settings.json
    ```

=== "Windows"

    ```
    %APPDATA%\Cursor\User\globalStorage\saoudrizwan.claude-dev\settings\cline_mcp_settings.json
    ```

=== "Linux"

    ```
    ~/.config/Cursor/User/globalStorage/saoudrizwan.claude-dev/settings/cline_mcp_settings.json
    ```

!!! tip "File doesn't exist?"
    If the file doesn't exist, create the directory structure and file with an empty JSON object: `{}`

### 2. Add Hawkeye Configuration

Edit the MCP settings file and add the Hawkeye server:

=== "Using npx (Recommended)"

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
      "mcpServers": {
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

### 3. Restart Cursor

Restart Cursor to load the new configuration:

1. Close all Cursor windows
2. Reopen Cursor
3. Open the Cursor AI chat panel

### 4. Verify Installation

Check that Hawkeye tools are available in Cursor's AI chat:

```
List available MCP tools
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
  "mcpServers": {
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

```
I'm seeing errors in the logs - can you check Hawkeye for recent alerts related to this service?
```

### Create Fix Scripts

```
Get the RCA for session abc-123 and generate the corrective action scripts I can run
```

### Review Investigation History

```
Show me all investigations from the last 7 days
```

### Context-Aware Analysis

```
This code handles payment processing. Check Hawkeye for any payment-related incidents and show me the root causes
```

## Troubleshooting

### Tools Not Available

**Problem:** Cursor's AI doesn't show Hawkeye tools

**Solution:**

1. Check MCP settings file syntax (must be valid JSON)
2. Restart Cursor completely (close all windows)
3. Verify credentials are correct
4. Check Cursor's developer console for errors: `Help > Toggle Developer Tools`

### Authentication Failed

**Problem:** `401 Unauthorized` error

**Solution:**

1. Verify email and password in settings
2. Ensure `HAWKEYE_BASE_URL` ends with `/api`
3. Test credentials at Hawkeye web UI
4. Check for typos in MCP settings file

### Command Not Found

**Problem:** `npx: command not found`

**Solution:**

1. Install Node.js 20+: [nodejs.org](https://nodejs.org)
2. Verify installation: `node --version`
3. Restart Cursor after installing Node.js
4. Try global install method instead

### Settings File Not Found

**Problem:** Can't find MCP settings file

**Solution:**

1. Use `Cmd/Ctrl+Shift+P` and search for "MCP"
2. If MCP option doesn't appear, ensure Cursor is updated to latest version
3. Manually create the directory structure
4. Create empty `{}` JSON file

## Advanced Configuration

### Multiple Instances

To work with different Hawkeye instances (dev, staging, prod):

```json
{
  "mcpServers": {
    "hawkeye-prod": {
      "command": "npx",
      "args": ["-y", "hawkeye-mcp-server"],
      "env": {
        "HAWKEYE_EMAIL": "user@company.com",
        "HAWKEYE_PASSWORD": "password",
        "HAWKEYE_BASE_URL": "https://app.neubird.ai/api"
      }
    },
    "hawkeye-dev": {
      "command": "npx",
      "args": ["-y", "hawkeye-mcp-server"],
      "env": {
        "HAWKEYE_EMAIL": "user@company.com",
        "HAWKEYE_PASSWORD": "password",
        "HAWKEYE_BASE_URL": "https://dev.app.neubird.ai/api"
      }
    }
  }
}
```

### Integration with Codebase

Cursor can provide context-aware incident analysis by combining:
- Your current code file
- Git history
- Hawkeye investigation data

Example prompt:
```
Review this payment processing code. Check Hawkeye for payment-related incidents in the last 30 days and identify if any recent changes might have caused issues.
```

## Tips for Using Hawkeye in Cursor

### 1. Correlate Code with Incidents

When debugging, ask Cursor to check Hawkeye for related incidents:
```
I'm looking at this database query. Are there any Hawkeye investigations about slow queries in the last week?
```

### 2. Generate Fix Scripts

Get executable remediation scripts:
```
Get the corrective actions for the latest alert and format them as bash scripts I can review
```

### 3. Review Before Deployment

Check for similar past incidents:
```
I'm about to deploy changes to the auth service. Check Hawkeye for any auth-related incidents that might inform my deployment strategy
```

### 4. Learn from History

Understand patterns:
```
Show me all database-related RCAs from the past month and summarize common root causes
```

## Next Steps

Now that you've set up Cursor, here's what to do next:

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
