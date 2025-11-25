s# Hawkeye MCP Documentation

Documentation site for the Hawkeye MCP Server - AI-powered incident investigation through Model Context Protocol.

**Live Site:** https://neubirdai.github.io/hawkeye-mcp-docs

## For Developers

### Prerequisites

- Python 3.8 or higher
- Git
- (Optional) Virtual environment tool

### Initial Setup

1. Clone the repository:
```bash
git clone https://github.com/neubirdai/hawkeye-mcp-docs.git
cd hawkeye-mcp-docs
```

2. Create and activate a virtual environment (recommended):
```bash
python3 -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

3. Install dependencies:
```bash
pip install -r requirements.txt
```

### Local Development

Start the local development server:
```bash
mkdocs serve
```

The site will be available at http://127.0.0.1:8000 with live reload enabled.

### Project Structure

```
hawkeye-mcp-docs/
├── docs/                      # Documentation content
│   ├── assets/               # Images, logos, icons
│   ├── stylesheets/          # Custom CSS
│   ├── getting-started/      # Installation and setup guides
│   ├── guides/               # User guides and tutorials
│   ├── examples/             # Example configurations
│   ├── reference/            # API reference (if applicable)
│   ├── index.md              # Homepage
│   ├── faq.md                # Frequently asked questions
│   └── troubleshooting.md    # Troubleshooting guide
├── mkdocs.yml                # MkDocs configuration
├── requirements.txt          # Python dependencies
├── deploy.sh                 # Deployment script
└── README.md                 # This file
```

### Making Changes

1. Create a new branch for your changes:
```bash
git checkout -b feature/your-feature-name
```

2. Edit documentation files in the `docs/` directory (all content is in Markdown)

3. Preview your changes locally with `mkdocs serve`

4. Commit your changes:
```bash
git add .
git commit -m "Description of changes"
git push origin feature/your-feature-name
```

5. Create a pull request on GitHub

### Deploying

The documentation is deployed to GitHub Pages. To deploy:

```bash
./deploy.sh
```

This script will:
- Validate the mkdocs.yml configuration
- Build the static site
- Deploy to the `gh-pages` branch
- Make the site live at https://neubirdai.github.io/hawkeye-mcp-docs

**Note:** Only maintainers with push access should deploy to production.

### Configuration

Key configuration is in `mkdocs.yml`:
- **Site metadata:** name, URL, description
- **Theme settings:** Material theme with custom colors and features
- **Navigation structure:** Controls the sidebar menu
- **Markdown extensions:** Enhanced Markdown features
- **Plugins:** Search, minification, git dates

### Styling

Custom styles are in `docs/stylesheets/extra.css`. The site uses the Material for MkDocs theme with custom branding colors.

### Adding New Pages

1. Create a new `.md` file in the appropriate `docs/` subdirectory
2. Add the page to the `nav` section in `mkdocs.yml`
3. Use existing pages as templates for formatting

### Markdown Features

The site supports enhanced Markdown via PyMdown Extensions:
- Admonitions (notes, warnings, tips)
- Code blocks with syntax highlighting
- Tabs and tabbed content
- Task lists
- Tables
- Emoji
- And more

See the [Material for MkDocs documentation](https://squidfunk.github.io/mkdocs-material/) for full feature list.

### Troubleshooting

**Issue:** MkDocs not found
- **Solution:** Ensure you've activated your virtual environment and installed dependencies

**Issue:** Changes not showing up
- **Solution:** Check that `mkdocs serve` is running and refresh your browser

**Issue:** Deployment fails
- **Solution:** Ensure you have push access to the repository and the `gh-pages` branch exists

## Contributing

Contributions are welcome! Please:
1. Follow the existing documentation style and structure
2. Test your changes locally before submitting
3. Write clear commit messages
4. Create focused pull requests

## License

Copyright © 2025 NeuBird AI

## Support

For questions or issues:
- Create an issue on GitHub
- Contact the NeuBird team at https://neubird.ai/contact-us
