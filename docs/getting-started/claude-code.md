# Claude Code Setup

Complete guide to integrating Hawkeye MCP with Claude Code (Anthropic's CLI).

## Overview

Claude Code is Anthropic's command-line AI assistant that supports Model Context Protocol. This integration gives you AI-powered incident investigation directly in your terminal.

**What you'll get:**

- 39 Hawkeye tools available in Claude Code
- Terminal-based investigation workflows
- Interactive follow-up questions
- Direct command execution capabilities

## Prerequisites

- [x] Claude Code installed ([installation guide](https://docs.anthropic.com/en/docs/claude-code))
- [x] Hawkeye account credentials
- [x] Node.js 20+ installed (for npx)

## Installation Steps

Claude Code supports **three configuration scopes** for MCP servers. Choose the method that best fits your needs.

### Configuration Scopes

| Scope | Location | Use Case |
|-------|----------|----------|
| **User** | `~/.claude.json` | Available in all your projects (most common) |
| **Project** | `.mcp.json` in project root | Shared with team via version control |
| **Local** | `~/.claude.json` with project context | Private to you in specific project |

!!! tip "Which scope should I use?"
    - **User scope** (`~/.claude.json`) - Best for personal MCP servers you want everywhere
    - **Project scope** (`.mcp.json`) - Best for team-shared configurations
    - **Local scope** - Best for project-specific overrides

### Method 1: User Configuration (Recommended)

This is the **most common approach** - configure Hawkeye MCP once and use it across all your projects.

#### 1. Locate User Configuration File

The user config file is located at:

```
~/.claude.json
```

**Open or create the file:**

```bash
# Open in default text editor
nano ~/.claude.json

# Or use VS Code
code ~/.claude.json
```

!!! tip "File doesn't exist?"
    If the file doesn't exist, create it with an empty JSON object: `{}`

#### 2. Add Hawkeye Configuration

Edit `~/.claude.json` and add the Hawkeye MCP server:

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

### Method 2: Project Configuration (For Teams)

Use this method to share Hawkeye MCP configuration with your team via version control.

#### 1. Create Project Configuration File

In your project root directory, create `.mcp.json`:

```bash
# Navigate to your project
cd /path/to/your/project

# Create the config file
touch .mcp.json

# Open in editor
code .mcp.json
```

#### 2. Add Hawkeye Configuration

Add the same configuration as above to `.mcp.json`.

!!! note "Project vs User scope"
    - Project config (`.mcp.json`) can be committed to git and shared with team
    - User config (`~/.claude.json`) is personal and not shared
    - You can use both - project config takes precedence

### Method 3: CLI Installation

Use Claude Code's CLI to add servers programmatically:

```bash
# Add to user scope (all projects)
claude mcp add --scope user --transport stdio hawkeye -- npx -y hawkeye-mcp-server

# Add to project scope (current project only)
claude mcp add --scope project --transport stdio hawkeye -- npx -y hawkeye-mcp-server
```

**Note:** You'll still need to manually edit the config file to add environment variables (credentials).

## Verification

### Restart Claude Code

Restart Claude Code to load the new configuration:

```bash
# Exit Claude Code if running (Ctrl+D)
# Then restart
claude
```

### Check Installation

Run the `/mcp` command in Claude Code to verify your configuration:

```
/mcp
```

You should see:
- ✔ `hawkeye` server listed as "connected"
- Your config file location shown (either `~/.claude.json` or `.mcp.json`)

Or ask Claude to list tools:

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

### Investigate an Alert

```
List my uninvestigated alerts and investigate the most recent one
```

### Get Project Information

```
Show me all my Hawkeye projects
```

### Create Instructions

```
Help me create a filter instruction to ignore CloudWatch alarms from test environments
```

### Analyze Performance

```
Show me our incident response metrics and time saved
```

## Troubleshooting

### Tools Not Available

**Problem:** Claude Code doesn't show Hawkeye tools

**Solution:**

1. Check config file syntax (must be valid JSON)
2. Restart Claude Code completely
3. Verify credentials are correct
4. Check Claude Code logs for errors

### Authentication Failed

**Problem:** `401 Unauthorized` error

**Solution:**

1. Verify email and password in config
2. Ensure `HAWKEYE_BASE_URL` ends with `/api`
3. Test credentials at Hawkeye web UI
4. Check for typos in config file

### Command Not Found

**Problem:** `npx: command not found`

**Solution:**

1. Install Node.js 20+: [nodejs.org](https://nodejs.org)
2. Verify installation: `node --version`
3. Try global install method instead

### Slow Startup

**Problem:** Claude Code takes long to start

**Solution:**

Use global install instead of npx for faster startup:

```bash
npm install -g hawkeye-mcp-server
```

Then update config to use `hawkeye-mcp` command instead of npx.

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

Then ask Claude to use specific instance:
```
Use hawkeye-prod tools to list my projects
```

## Next Steps

Now that you've set up Claude Code, here's what to do next:

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
