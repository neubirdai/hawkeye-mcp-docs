#!/bin/bash

# Hawkeye MCP Documentation Deployment Script
# Deploys documentation to GitHub Pages

set -e  # Exit on error

echo "🚀 Deploying Hawkeye MCP Documentation"
echo "========================================"

# Use virtual environment if it exists
if [ -d "venv" ]; then
    MKDOCS="venv/bin/mkdocs"
else
    MKDOCS="mkdocs"
fi

# Check if mkdocs is installed
if ! command -v $MKDOCS &> /dev/null; then
    echo "❌ MkDocs is not installed"
    echo "Installing dependencies..."
    if [ -d "venv" ]; then
        venv/bin/pip install -r requirements.txt
    else
        pip install -r requirements.txt
    fi
fi

# Validate configuration
echo "📝 Validating mkdocs.yml..."
$MKDOCS build --clean

# Deploy to GitHub Pages
echo "🌐 Deploying to GitHub Pages..."
$MKDOCS gh-deploy --force

echo "✅ Deployment complete!"
echo "📍 Site URL: https://neubirdai.github.io/hawkeye-mcp-docs"
