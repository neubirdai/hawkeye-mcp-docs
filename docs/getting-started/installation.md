# Installation

Get started with Hawkeye MCP Server in minutes.

## Prerequisites

- **Node.js** >= 20.0.0
- **npm** >= 9.0.0
- **Hawkeye Account** with API access

Check your Node.js version:

```bash
node --version
# Should output v20.0.0 or higher
```

!!! tip "Need to install Node.js?"
    Download from [nodejs.org](https://nodejs.org/) or use your package manager:

    ```bash
    # macOS
    brew install node@20

    # Linux (Ubuntu/Debian)
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
    sudo apt-get install -y nodejs
    ```

## Install Hawkeye MCP Server

=== "npx (Recommended)"

    No installation required - run directly:

    ```bash
    npx hawkeye-mcp-server
    ```

    **Pros:**

    - ✅ No installation step
    - ✅ Always latest version
    - ✅ Perfect for getting started

=== "Global Install"

    Install once, use anywhere:

    ```bash
    npm install -g hawkeye-mcp-server
    ```

    Verify:

    ```bash
    hawkeye-mcp --version
    ```

    **Pros:**

    - ✅ Faster startup
    - ✅ Available system-wide
    - ✅ Easy updates: `npm update -g hawkeye-mcp-server`

## Configuration

### Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `HAWKEYE_EMAIL` | Your Hawkeye account email | `user@company.com` |
| `HAWKEYE_PASSWORD` | Your Hawkeye password | `your-password` |
| `HAWKEYE_BASE_URL` | Hawkeye API endpoint | `https://app.neubird.ai/api` |

!!! warning "Keep credentials secure"
    Never expose your credentials in configuration files that might be committed to version control. Use secure methods to store and access your credentials.

## Verify Installation

After configuring your AI client, verify the installation works:

**Test command:**
```
List my Hawkeye projects
```

**Expected response:**
- If you see a list of projects (even if empty), installation is successful!
- If you see an error, check the [Troubleshooting Guide](../troubleshooting.md)

## Next Steps

### Configure Your AI Client

Choose your AI client to complete the setup:

<div class="grid cards" markdown>

-   :material-application: __Claude Desktop__

    ---

    Native Anthropic desktop app (recommended for beginners)

    [:octicons-arrow-right-24: Claude Desktop Setup](claude-desktop.md)

-   :material-console: __Claude Code__

    ---

    Terminal-based AI assistant from Anthropic

    [:octicons-arrow-right-24: Claude Code Setup](claude-code.md)

-   :material-cursor-default-click: __Cursor__

    ---

    AI-powered code editor with MCP support

    [:octicons-arrow-right-24: Cursor Setup](cursor.md)

-   :material-microsoft-visual-studio-code: __GitHub Copilot__

    ---

    VS Code integration with GitHub Copilot

    [:octicons-arrow-right-24: GitHub Copilot Setup](github-copilot.md)

</div>

### Start Using Hawkeye

Once your client is configured:

**[📚 Complete Onboarding Guide →](../guides/onboarding.md)**
Complete step-by-step guide to add connections, create projects, and run your first investigation

**[⚡ Quick Start →](quickstart.md)**
Jump straight to basic usage if you're familiar with MCP
