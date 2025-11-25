# Troubleshooting

Common issues and solutions for Hawkeye MCP.

## Installation Issues

### Command Not Found: hawkeye-mcp

**Problem:** `hawkeye-mcp: command not found`

**Solutions:**

1. **Check installation:**
   ```bash
   npm list -g hawkeye-mcp-server
   ```

2. **Reinstall globally:**
   ```bash
   npm install -g hawkeye-mcp-server
   ```

3. **Use npx instead:**
   ```bash
   npx hawkeye-mcp-server
   ```

### Node Version Error

**Problem:** `Error: Node.js 20+ required`

**Solution:**
```bash
# Check version
node --version

# Upgrade Node.js
# macOS
brew install node@20

# Linux
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs
```

## Authentication Issues

### 401 Unauthorized

**Problem:** `Authentication failed: 401 Unauthorized`

**Solutions:**

1. **Verify credentials:**
   ```bash
   # Check environment variables
   echo $HAWKEYE_EMAIL
   echo $HAWKEYE_BASE_URL
   ```

2. **Check instance URL:**
   - Must end with `/api`
   - Use `https://` not `http://`
   - Correct: `https://app.neubird.ai/api`
   - Wrong: `https://app.neubird.ai`

3. **Test login:**
   - Try logging into Hawkeye web UI
   - Reset password if needed

4. **Check for typos:**
   - No extra spaces
   - No surrounding quotes
   - Correct email format

### Connection Timeout

**Problem:** `ECONNREFUSED` or `ETIMEDOUT`

**Solutions:**

1. **Check network:**
   ```bash
   curl https://app.neubird.ai/api/health
   ```

2. **Check firewall:**
   - Allow outbound HTTPS (443)
   - Check corporate proxy settings

3. **Verify URL:**
   - Ensure `HAWKEYE_BASE_URL` is correct
   - Check with Hawkeye admin

## Claude Desktop Issues

### Tools Not Showing

**Problem:** Can't see Hawkeye tools in Claude Desktop

**Solutions:**

1. **Verify config file location:**
   ```bash
   # macOS
   cat ~/Library/Application\ Support/Claude/claude_desktop_config.json

   # Windows
   type %APPDATA%\Claude\claude_desktop_config.json
   ```

2. **Check JSON syntax:**
   - Use [JSONLint](https://jsonlint.com/)
   - Look for missing commas
   - Check bracket matching

3. **Restart Claude Desktop:**
   - Completely quit (Cmd+Q on macOS)
   - Wait 3 seconds
   - Relaunch

4. **Check logs:**
   ```bash
   # macOS
   tail -f ~/Library/Logs/Claude/mcp*.log

   # Look for errors
   ```

### MCP Server Crashes

**Problem:** MCP server keeps crashing

**Solutions:**

1. **Test server directly:**
   ```bash
   npx @modelcontextprotocol/inspector npx hawkeye-mcp-server
   ```

2. **Check credentials:**
   - Ensure all env vars are set
   - No special characters causing issues

3. **Update package:**
   ```bash
   npm update -g hawkeye-mcp-server
   ```

## Investigation Issues

### Investigation Takes Too Long

**Problem:** Investigation running for several minutes

**Normal Duration:** 30-90 seconds

**If Longer:**

1. **First investigation on new project:**
   - Initial sync takes 5-10 minutes
   - Subsequent investigations faster

2. **Check connection sync:**
   ```
   Show me connection status
   ```

3. **Complex incident:**
   - Many data sources = longer time
   - This is normal

### Investigation Progress Issues

#### Status Shows 'unknown'

**Problem:** Investigation status returns 'unknown' or no progress data

**Solutions:**

1. **Investigation just started:**
   - Wait 5-10 seconds for stream to initialize
   - Check again: `Show me the investigation status`

2. **Stream connection initializing:**
   - Normal during first few seconds
   - Progress data will appear shortly

3. **Investigation hasn't started yet:**
   - Verify investigation was created successfully
   - Check session UUID is correct

#### No Steps Showing

**Problem:** `investigation_summary.steps` is empty or undefined

**Solutions:**

1. **Early initialization phase:**
   - Investigation may be in early setup
   - Chain of thought messages haven't arrived yet
   - Wait 30 seconds and check again

2. **Investigation just completed:**
   - Use `hawkeye_get_chain_of_thought` for full step details
   - Use `hawkeye_get_rca` for final results

3. **Check investigation age:**
   - Progress data is cleaned up after 1 hour
   - For older investigations, use other tools like `get_chain_of_thought`

#### Progress Stuck at Same Percentage

**Problem:** Progress percentage hasn't changed in several minutes

**This is Normal When:**

1. **Complex data queries:**
   - Some steps require heavy database queries
   - Analysis phase often takes longer
   - May pause at 30-60% during correlation analysis

2. **Large data sets:**
   - Processing many logs or metrics
   - Normal for thorough investigations

3. **Pattern detection:**
   - ML-based analysis can take time
   - Expected behavior

**Concerning If:**

1. **Stuck at 0% for >2 minutes:**
   - Investigation may have failed to start
   - Check connection sync status
   - Try creating a new investigation

2. **Stuck at same % for >5 minutes:**
   - Check investigation status for errors
   - Look for error messages in status response
   - Contact support if issue persists

#### Very Few Data Sources

**Problem:** `unique_sources` only shows 1-2 sources, expected more

**Solutions:**

1. **Check connection sync:**
   ```
   Show me project connections
   # Ensure all are in SYNCED state
   ```

2. **Verify data availability:**
   ```
   Show me available resources for this project
   # Check if expected log/metric sources exist
   ```

3. **Time range issues:**
   - Incident may be outside data retention period
   - Check if data exists for the incident timeframe

4. **Connection permissions:**
   - Verify IAM/API key permissions
   - Ensure connections can access all resources

#### Current Step Not Updating

**Problem:** `current_step` field shows same message for several checks

**Solutions:**

1. **Check progress_percentage:**
   - If increasing, investigation is progressing
   - current_step updates at major milestones only
   - Check completed_steps instead

2. **Long-running step:**
   - Some steps naturally take longer
   - Analysis and diagnosis phases especially
   - Normal behavior

3. **Investigation may be done:**
   - Check status field for "completed"
   - Get final RCA: `Show me the RCA`

### Incomplete RCA

**Problem:** RCA lacks details or specific recommendations

**Solutions:**

1. **Add context instructions:**
   ```
   Create a SYSTEM instruction with our architecture details
   ```

2. **Add investigation steps:**
   ```
   Create RCA instructions for common incident types
   ```

3. **Verify connections:**
   ```
   Show me project connections
   # Ensure all are SYNCED
   ```

4. **Check data availability:**
   ```
   Show me available resources for this project
   ```

### Incorrect Root Cause

**Problem:** RCA identifies wrong root cause

**Solutions:**

1. **Ask follow-up questions:**
   ```
   Why do you think that's the root cause?
   What other possibilities exist?
   ```

2. **Add clarifying instruction:**
   ```
   Create an instruction to guide this type of investigation better
   ```

3. **Test instruction first:**
   - Apply to past session
   - Rerun investigation
   - Compare results

## Connection Issues

### Connection Won't Sync

**Problem:** Connection stuck in SYNCING state

**Solutions:**

1. **Check status:**
   ```
   Show me connection details for [connection-uuid]
   ```

2. **Verify credentials:**
   - AWS: Check role ARN and external ID
   - Datadog: Check API/app keys
   - Azure: Check all 4 credentials

3. **Check permissions:**
   - AWS: ReadOnlyAccess policy
   - Ensure trust relationship correct

4. **Wait longer:**
   - First sync: 5-10 minutes normal
   - Large environments: up to 15 minutes

### Missing Resources

**Problem:** Expected resources not showing in discoveries

**Solutions:**

1. **Check sync status:**
   ```
   Wait for connection to sync completely
   ```

2. **Verify region:**
   - AWS: Ensure region included in connection
   - Resources in unconfigured regions won't show

3. **Check permissions:**
   - Missing permissions = missing resources
   - Verify IAM policies

## Performance Issues

### Slow Responses

**Problem:** Claude responses taking long time

**Solutions:**

1. **Use compact mode:**
   ```
   Show me sessions in compact format
   ```

2. **Limit results:**
   ```
   Show me only last 10 sessions
   ```

3. **Use global install:**
   ```bash
   npm install -g hawkeye-mcp-server
   # Faster than npx
   ```

### High Memory Usage

**Problem:** MCP server using too much memory

**Solutions:**

1. **Restart MCP server:**
   - Restart Claude Desktop

2. **Limit concurrent operations:**
   - Investigate one alert at a time

3. **Update to latest version:**
   ```bash
   npm update -g hawkeye-mcp-server
   ```

## Error Messages

### "No uninvestigated incidents found"

**Meaning:** All alerts have been investigated OR filters are removing them

**Solutions:**

1. **Expand time range:**
   ```
   Show uninvestigated alerts from last 30 days
   ```

2. **Check filters:**
   ```
   Show me active FILTER instructions
   ```

3. **Include all severities:**
   - Your filter might be too aggressive

### "Session not found"

**Problem:** `Session UUID not found`

**Solutions:**

1. **Verify UUID:**
   - Check for typos
   - Use correct UUID format

2. **Check project:**
   - Ensure using correct project
   - Session might be in different project

3. **List sessions:**
   ```
   Show me all sessions
   ```

### "Connection not synced"

**Problem:** `Connection not ready for use`

**Solution:**
```
Wait for connection [uuid] to finish syncing
```

## Debug Mode

### Enable Verbose Logging

**In Claude Desktop config:**
```json
{
  "mcpServers": {
    "hawkeye": {
      "command": "npx",
      "args": ["-y", "hawkeye-mcp-server"],
      "env": {
        "HAWKEYE_EMAIL": "...",
        "HAWKEYE_PASSWORD": "...",
        "HAWKEYE_BASE_URL": "...",
        "HAWKEYE_LOG_LEVEL": "debug"
      }
    }
  }
}
```

### Using MCP Inspector

Test server in isolation:

```bash
npx @modelcontextprotocol/inspector npx hawkeye-mcp-server
```

Opens web interface showing:
- Available tools
- Tool execution
- Request/response logs
- Errors

## Getting Help

If issues persist:

1. **Check logs:**
   ```bash
   # macOS
   tail -100 ~/Library/Logs/Claude/mcp*.log
   ```

2. **Test with inspector:**
   ```bash
   npx @modelcontextprotocol/inspector npx hawkeye-mcp-server
   ```

3. **Contact support:**
   - Email: support@neubird.ai
   - Include: Error message, logs, MCP version

4. **Documentation:**
   - [Installation Guide](getting-started/installation.md)
   - [FAQ](faq.md)
