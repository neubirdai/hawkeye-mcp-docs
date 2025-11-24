# Authentication

Hawkeye MCP Server requires authentication to connect to your Hawkeye account.

## Getting Credentials

You'll need:

1. **Hawkeye account email** - Your registered email address
2. **Hawkeye password** - Your account password
3. **Hawkeye instance URL** - API endpoint for your instance

### Default Instance

Most users connect to the main production instance:

```
https://app.neubird.ai/api
```

### Custom Instances

Enterprise customers may have dedicated instances:

```
https://your-company.app.neubird.ai/api
```

!!! tip "Don't have a Hawkeye account?"
    Contact [NeuBird](https://neubird.ai) to request access or book a demo.

## Environment Variables

Hawkeye MCP uses environment variables for authentication:

| Variable | Required | Description |
|----------|----------|-------------|
| `HAWKEYE_EMAIL` | Yes | Your account email |
| `HAWKEYE_PASSWORD` | Yes | Your account password |
| `HAWKEYE_BASE_URL` | Yes | API endpoint URL |

## Configuration Methods

=== "Environment File (.env)"

    Create a `.env` file in your project directory:

    ```bash
    HAWKEYE_EMAIL=user@company.com
    HAWKEYE_PASSWORD=your-secure-password
    HAWKEYE_BASE_URL=https://app.neubird.ai/api
    ```

    **When to use:**

    - Development and testing
    - Running MCP server manually
    - Using with `npx`

    !!! warning "Security"
        Add `.env` to `.gitignore` - never commit credentials!

=== "Claude Desktop Config"

    Add credentials directly to Claude Desktop config:

    ```json
    {
      "mcpServers": {
        "hawkeye": {
          "command": "npx",
          "args": ["-y", "hawkeye-mcp-server"],
          "env": {
            "HAWKEYE_EMAIL": "user@company.com",
            "HAWKEYE_PASSWORD": "your-secure-password",
            "HAWKEYE_BASE_URL": "https://app.neubird.ai/api"
          }
        }
      }
    }
    ```

    **When to use:**

    - Claude Desktop integration
    - Personal development machine
    - Single user setup

    See [Claude Desktop Setup](claude-desktop.md) for full guide.

=== "System Environment Variables"

    Set in your shell profile (`~/.bashrc`, `~/.zshrc`):

    ```bash
    export HAWKEYE_EMAIL="user@company.com"
    export HAWKEYE_PASSWORD="your-secure-password"
    export HAWKEYE_BASE_URL="https://app.neubird.ai/api"
    ```

    **When to use:**

    - System-wide configuration
    - Multiple MCP clients
    - CI/CD environments

=== "Claude Code Config"

    Add to Claude Code MCP config:

    ```json
    {
      "mcpServers": {
        "hawkeye": {
          "command": "npx",
          "args": ["-y", "hawkeye-mcp-server"],
          "env": {
            "HAWKEYE_EMAIL": "user@company.com",
            "HAWKEYE_PASSWORD": "your-secure-password",
            "HAWKEYE_BASE_URL": "https://app.neubird.ai/api"
          }
        }
      }
    }
    ```

    **Locations:**

    - **User scope** (all projects): `~/.claude.json` ← Most common
    - **Project scope** (team-shared): `.mcp.json` in project root

    Use `/mcp` command in Claude Code to see which config file is being used.

## Verification

After configuring credentials, verify your connection:

### Using Claude Desktop

1. Restart Claude Desktop
2. Check for Hawkeye tools in the tools panel
3. Try: "List my Hawkeye projects"

### Using CLI

Test authentication with npx:

```bash
npx hawkeye-mcp-server
```

You should see:

```
Hawkeye MCP Server v1.4.0
Connected to: https://app.neubird.ai/api
Authentication: ✓ Success
Available tools: 39
```

## Troubleshooting

### Authentication Failed

**Error:** `401 Unauthorized` or `Invalid credentials`

**Solutions:**

1. **Verify credentials** - Check email and password are correct
2. **Check instance URL** - Ensure URL ends with `/api`
3. **Test in browser** - Try logging into Hawkeye web UI
4. **Reset password** - Use Hawkeye password reset if needed

### Connection Timeout

**Error:** `ECONNREFUSED` or `ETIMEDOUT`

**Solutions:**

1. **Check network** - Ensure you can reach Hawkeye instance
2. **Verify URL** - Confirm `HAWKEYE_BASE_URL` is correct
3. **Check firewall** - Allow outbound HTTPS connections
4. **Try ping:**
   ```bash
   curl https://app.neubird.ai/api/health
   ```

### Wrong Instance

**Error:** Account not found on this instance

**Solutions:**

1. **Verify instance URL** - Check with your Hawkeye admin
2. **Use correct environment** - Don't mix prod/dev credentials
3. **Switch instances:**
   ```
   Use hawkeye_switch_instance tool to change instance
   ```

## Security Best Practices

### Do's ✅

- **Use environment variables** - Keep credentials out of code
- **Add .env to .gitignore** - Prevent accidental commits
- **Use strong passwords** - Follow your organization's policy
- **Rotate credentials** - Change passwords periodically
- **Limit access** - Only share with authorized users

### Don'ts ❌

- **Don't hardcode credentials** - Never put passwords in source code
- **Don't commit .env files** - Always add to .gitignore
- **Don't share credentials** - Each user should have their own account
- **Don't use HTTP** - Always use HTTPS endpoints
- **Don't expose in logs** - Sanitize logs before sharing

## Multi-Instance Setup

If you work with multiple Hawkeye instances (dev, staging, prod), you can:

### Option 1: Multiple Config Files

Create separate `.env` files:

```
.env.dev
.env.staging
.env.prod
```

Load the appropriate one:

```bash
# Development
export $(cat .env.dev | xargs)
npx hawkeye-mcp-server

# Production
export $(cat .env.prod | xargs)
npx hawkeye-mcp-server
```

### Option 2: Runtime Switching

Use the `hawkeye_switch_instance` tool to change instances during runtime:

```
Switch to: https://dev.app.neubird.ai/api
```

This clears cached authentication and connects to the new instance.

## Next Steps

Now that you've configured authentication, choose your AI client:

**[Claude Desktop Setup →](claude-desktop.md)**
Complete setup guide for Claude Desktop

**[Claude Code Setup →](claude-code.md)**
Terminal-based AI assistant from Anthropic

**[Cursor Setup →](cursor.md)**
AI-powered code editor with MCP support

**[GitHub Copilot Setup →](github-copilot.md)**
VS Code integration with GitHub Copilot

**[Quick Start Guide →](quickstart.md)**
Jump into your first investigation

**[Complete Onboarding →](../guides/onboarding.md)**
Full onboarding workflow from scratch
