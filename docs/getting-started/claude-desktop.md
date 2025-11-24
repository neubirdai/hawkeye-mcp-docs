# Claude Desktop Setup

Complete guide to integrating Hawkeye MCP with Claude Desktop.

## Overview

Claude Desktop is Anthropic's official desktop application that supports Model Context Protocol. This integration gives you AI-powered incident investigation directly in Claude's conversational interface.

**What you'll get:**

- 39 Hawkeye tools available in Claude
- Natural language investigation workflows
- Interactive follow-up questions
- Copy-paste ready corrective actions

## Prerequisites

- [x] Claude Desktop installed ([download here](https://claude.ai/download))
- [x] Hawkeye account credentials
- [x] Node.js 20+ installed (for npx)

## Installation Steps

### 1. Locate Configuration File

The Claude Desktop config file location varies by operating system:

=== "macOS"

    ```
    ~/Library/Application Support/Claude/claude_desktop_config.json
    ```

    **How to open:**

    ```bash
    # Open in default text editor
    open ~/Library/Application\ Support/Claude/claude_desktop_config.json

    # Or use nano
    nano ~/Library/Application\ Support/Claude/claude_desktop_config.json

    # Or VS Code
    code ~/Library/Application\ Support/Claude/claude_desktop_config.json
    ```

=== "Windows"

    ```
    %APPDATA%\Claude\claude_desktop_config.json
    ```

    **Full path:**

    ```
    C:\Users\YourUsername\AppData\Roaming\Claude\claude_desktop_config.json
    ```

    **How to open:**

    1. Press `Win + R`
    2. Type: `%APPDATA%\Claude`
    3. Open `claude_desktop_config.json` in Notepad

=== "Linux"

    ```
    ~/.config/Claude/claude_desktop_config.json
    ```

    **How to open:**

    ```bash
    nano ~/.config/Claude/claude_desktop_config.json
    ```

!!! tip "File doesn't exist?"
    If the file doesn't exist, create it with an empty JSON object: `{}`

### 2. Add Hawkeye Configuration

Edit the config file and add the Hawkeye MCP server:

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
    - ✅ Always uses latest version
    - ✅ No separate installation needed
    - ✅ Easy to update (automatic)

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
          "args": [],
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
    - ✅ Faster startup (no npx overhead)
    - ✅ Works offline after install
    - ✅ Pinned version (update manually)

=== "Multiple MCP Servers"

    If you already have other MCP servers configured:

    ```json
    {
      "mcpServers": {
        "existing-server": {
          "command": "some-other-mcp-server",
          "args": []
        },
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

### 3. Configure Credentials

Replace the placeholder values:

| Field | Replace With | Example |
|-------|--------------|---------|
| `HAWKEYE_EMAIL` | Your Hawkeye account email | `john@acme.com` |
| `HAWKEYE_PASSWORD` | Your account password | `SecurePass123!` |
| `HAWKEYE_BASE_URL` | Your Hawkeye instance URL | `https://app.neubird.ai/api` |

!!! warning "Custom Instances"
    Enterprise customers with dedicated instances should use their custom URL:
    ```
    https://your-company.app.neubird.ai/api
    ```

### 4. Restart Claude Desktop

**Important:** You must completely quit and restart Claude Desktop.

=== "macOS"

    1. Quit Claude Desktop (`Cmd+Q`)
    2. Wait 2-3 seconds
    3. Relaunch Claude Desktop

    **Or use Terminal:**

    ```bash
    # Quit Claude
    osascript -e 'quit app "Claude"'

    # Wait and relaunch
    sleep 2 && open -a Claude
    ```

=== "Windows"

    1. Right-click Claude in system tray
    2. Click "Quit"
    3. Relaunch Claude from Start menu

    **Or use Task Manager:**

    1. Press `Ctrl+Shift+Esc`
    2. Find "Claude" process
    3. Click "End task"
    4. Relaunch Claude

=== "Linux"

    ```bash
    # Kill Claude process
    pkill -f claude

    # Relaunch
    claude &
    ```

!!! tip "Restart not reload"
    Simply closing the window is not enough - you must quit the application completely.

### 5. Verify Installation

After restarting Claude Desktop, verify Hawkeye tools are available:

#### Check Tools Panel

1. Look for the 🔨 tools icon in Claude Desktop
2. Click to open tools panel
3. You should see "hawkeye" listed
4. Should show "39 tools available"

#### Test with Commands

Try these test commands:

**Test 1: List Projects**

```
List my Hawkeye projects
```

**Expected response:**

```
I found X Hawkeye projects:

1. Production (UUID: abc-123...)
   - Status: Active
   - Connections: 5
   - Instructions: 12

2. Development (UUID: def-456...)
   - Status: Active
   - Connections: 2
   - Instructions: 3
```

**Test 2: Check Tools**

```
What Hawkeye tools are available?
```

**Expected response:**

```
I have 39 Hawkeye MCP tools available across 7 categories:

- Projects (5 tools)
- Connections (10 tools)
- Investigations (10 tools)
- Instructions (9 tools)
- Analytics (3 tools)
- Discovery (1 tool)
- Help (1 tool)
```

## Configuration Options

### Optional Environment Variables

You can add these optional variables to the `env` section:

```json
{
  "mcpServers": {
    "hawkeye": {
      "command": "npx",
      "args": ["-y", "hawkeye-mcp-server"],
      "env": {
        "HAWKEYE_EMAIL": "your-email@company.com",
        "HAWKEYE_PASSWORD": "your-password",
        "HAWKEYE_BASE_URL": "https://app.neubird.ai/api",
        "HAWKEYE_DEFAULT_PROJECT_UUID": "your-project-uuid",
        "HAWKEYE_LOG_LEVEL": "info"
      }
    }
  }
}
```

| Variable | Description | Default |
|----------|-------------|---------|
| `HAWKEYE_DEFAULT_PROJECT_UUID` | Default project for operations | First available project |
| `HAWKEYE_LOG_LEVEL` | Logging verbosity | `info` |
| `HAWKEYE_TIMEOUT` | API request timeout (ms) | `30000` |

### Using System Environment Variables

Instead of putting credentials in the config file, you can use system environment variables:

```json
{
  "mcpServers": {
    "hawkeye": {
      "command": "npx",
      "args": ["-y", "hawkeye-mcp-server"]
    }
  }
}
```

Then set environment variables:

=== "macOS/Linux"

    Add to `~/.bashrc` or `~/.zshrc`:

    ```bash
    export HAWKEYE_EMAIL="your-email@company.com"
    export HAWKEYE_PASSWORD="your-password"
    export HAWKEYE_BASE_URL="https://app.neubird.ai/api"
    ```

    Restart your terminal or run `source ~/.bashrc`.

=== "Windows"

    Set in System Properties:

    1. Search for "Environment Variables"
    2. Click "Edit system environment variables"
    3. Add user variables:
       - `HAWKEYE_EMAIL`
       - `HAWKEYE_PASSWORD`
       - `HAWKEYE_BASE_URL`

## Troubleshooting

### Hawkeye Tools Not Showing

**Problem:** Can't see Hawkeye in tools panel

**Solutions:**

1. **Check config file syntax**
   - Ensure valid JSON (use [JSONLint](https://jsonlint.com/))
   - Check for missing commas or brackets

2. **Verify file location**
   - Make sure you edited the correct config file
   - Check file permissions (should be readable)

3. **Check Claude Desktop logs**

   === "macOS"
       ```bash
       tail -f ~/Library/Logs/Claude/mcp*.log
       ```

   === "Windows"
       ```
       %LOCALAPPDATA%\Claude\logs\mcp*.log
       ```

4. **Try MCP Inspector**

   ```bash
   npx @modelcontextprotocol/inspector npx hawkeye-mcp-server
   ```

   This opens a debug interface showing if the server starts correctly.

### Authentication Errors

**Problem:** `401 Unauthorized` or authentication failed

**Solutions:**

1. **Verify credentials**
   - Double-check email and password
   - No extra spaces or quotes

2. **Check instance URL**
   - Must end with `/api`
   - Use `https://` not `http://`

3. **Test credentials**
   - Try logging into Hawkeye web UI
   - Reset password if needed

### Slow Startup

**Problem:** Takes 30+ seconds to load Hawkeye tools

**Solutions:**

1. **Use global install** instead of npx:
   ```bash
   npm install -g hawkeye-mcp-server
   ```

2. **Check network** - Ensure good connection to Hawkeye instance

3. **Update Node.js** - Use latest LTS version

### Tools Disabled

**Problem:** Tools show as disabled or grayed out

**Solutions:**

1. **Check project status** - Ensure default project is active
2. **Verify connections** - Project needs at least one synced connection
3. **Check permissions** - Ensure account has proper access

## Usage Tips

### Natural Language Commands

Claude Desktop supports natural language - you don't need exact tool names:

**Instead of:**
```
Use hawkeye_list_sessions with only_uninvestigated=true
```

**Just say:**
```
Show me uninvestigated alerts
```

### Multi-Step Workflows

Claude can chain multiple Hawkeye tools together:

```
Find uninvestigated P1 alerts from the last 24 hours,
investigate the most recent one, and give me the root
cause and corrective actions.
```

Claude will:
1. List sessions with filters
2. Pick the most recent P1
3. Investigate it
4. Extract RCA
5. Present corrective actions

### Follow-Up Questions

After an investigation, you can ask follow-ups:

```
Why did this happen?
Has this happened before?
What can we do to prevent it?
Show me the exact queries that were run
```

### Copy-Paste Actions

RCA results include ready-to-execute bash scripts and code snippets:

```
Give me the corrective actions as bash commands I can run
```

## Advanced Configuration

### Per-Window Settings

Claude Desktop doesn't support per-window MCP configs, but you can:

1. Create separate Claude Desktop profiles (requires reinstall)
2. Use different system accounts
3. Switch instances at runtime using `hawkeye_switch_instance`

### Debug Mode

Enable verbose logging:

```json
{
  "mcpServers": {
    "hawkeye": {
      "command": "npx",
      "args": ["-y", "hawkeye-mcp-server"],
      "env": {
        "HAWKEYE_EMAIL": "your-email@company.com",
        "HAWKEYE_PASSWORD": "your-password",
        "HAWKEYE_BASE_URL": "https://app.neubird.ai/api",
        "HAWKEYE_LOG_LEVEL": "debug"
      }
    }
  }
}
```

Check logs for detailed output.

### Updating Hawkeye MCP

=== "Using npx"

    No action needed - always uses latest version automatically.

=== "Using Global Install"

    Update manually:

    ```bash
    npm update -g hawkeye-mcp-server
    ```

    Check current version:

    ```bash
    hawkeye-mcp --version
    ```

## Next Steps

<div class="grid cards" markdown>

-   :material-run-fast: __Quick Start__

    ---

    Try your first investigation

    [:octicons-arrow-right-24: Quick Start Guide](quickstart.md)

-   :material-book-open: __Complete Onboarding__

    ---

    Set up projects and connections

    [:octicons-arrow-right-24: Onboarding Guide](../guides/onboarding.md)

-   :material-lightbulb: __Learn Workflows__

    ---

    Common investigation patterns

    [:octicons-arrow-right-24: Daily Workflows](../examples/daily-workflows.md)

</div>

## See Also

- [Authentication Guide](authentication.md) - Detailed credential setup
- [Troubleshooting](../troubleshooting.md) - Common issues and solutions
- [FAQ](../faq.md) - Frequently asked questions
