# Claude Code Custom Agents and Reference Documentation

This directory contains custom agent definitions and reference documentation for use with Claude Code.

## Overview

This collection provides 14 specialized agents for software development tasks, along with comprehensive reference documentation for multiple programming languages and frameworks.

## Directory Structure

```
claude-code/
├── agents/                    # Custom agent definitions
│   ├── development/          # Code implementation roles
│   ├── quality/              # Testing and QA roles
│   ├── architecture/         # System design roles
│   ├── data/                 # Data and database roles
│   ├── devops/               # Infrastructure roles
│   ├── product/              # Product and project management
│   └── documentation/        # Documentation roles
├── reference-documentation/  # Language-specific coding guides
│   ├── golang/               # Go patterns and project layout
│   ├── python/               # Python patterns
│   ├── typescript/           # TypeScript/Vue patterns
│   └── tailwind/             # Tailwind CSS patterns
└── templates/                # Template files (if any)
```

## Installation

### First-Time Setup

**Step 1: Clone the repository**
```bash
git clone https://github.com/shapestone/llm-guides.git
cd llm-guides/claude-code
```

**Step 2: Run the update script**

macOS/Linux:
```bash
./update-agents.sh
```

Windows:
```cmd
update-agents.bat
```

This will:
1. Pull latest changes from GitHub
2. Create `~/.claude/agents/` and `~/.claude/reference-documentation/` directories
3. Copy all 14 agent files to `~/.claude/agents/`
4. Copy all reference documentation to `~/.claude/reference-documentation/`
5. Update reference paths in agent files to use absolute paths

**Step 3: Restart Claude Code**
- Agents are discovered at startup
- After restart, run `/agents` to see available agents
- Agents are ready to use!

### Dry Run

To see what would be installed without making changes:

**macOS/Linux:**
```bash
./install-agents.sh --dry-run
```

**Windows:**
```cmd
install-agents.bat --dry-run
```

### Manual Installation (Alternative)

If you prefer to install without pulling from git:

**macOS/Linux:**
```bash
cd claude-code
./install-agents.sh
```

**Windows:**
```cmd
cd claude-code
install-agents.bat
```

## Available Agents (14 Total)

### Development & Implementation
- **full-stack-engineer** - Implements features end-to-end (Go + TypeScript/Vue)
- **refactoring-specialist** - Analyzes code and proposes improvements

### Quality Assurance & Testing
- **code-reviewer** - Reviews code for quality and standards
- **full-stack-test-engineer** - Writes feature-level tests
- **e2e-test-engineer** - Validates entire product health
- **security-engineer** - Identifies and mitigates security vulnerabilities
- **performance-engineer** - Optimizes application performance

### Architecture & Design
- **system-architect** - Defines system architecture and technology decisions
- **design-systems-engineer** - Builds reusable UI component library

### Data
- **data-database-engineer** - Manages databases, schemas, and data pipelines

### DevOps & Infrastructure
- **devops-engineer** - Builds CI/CD pipelines and manages infrastructure

### Product & Requirements
- **technical-product-owner** - Defines requirements and manages backlog
- **project-manager** - Coordinates delivery and removes blockers

### Documentation
- **documentation-engineer** - Creates and maintains technical documentation

## Reference Documentation

All agents reference technology-specific guides:

### Language-Agnostic
- **code-writer.md** - Core principles for all languages

### Go
- **golang-code-writer.md** - Go idioms, patterns, and best practices
- **golang-project-layout.md** - Go project structure and organization

### Python
- **python-code-writer.md** - Python idioms, patterns, and best practices

### TypeScript + Vue
- **typescript-code-writer.md** - TypeScript + Vue patterns and best practices
- **typescript-project-layout.md** - TypeScript + Vue project structure

### Tailwind CSS
- **tailwind-code-writer.md** - Tailwind patterns and best practices
- **tailwind-project-layout.md** - Tailwind file organization

## How Agents Work

### Agent Discovery

Claude Code discovers agents from these locations (in priority order):
1. **Project-level**: `.claude/agents/` (highest priority)
2. **CLI-defined**: `--agents` flag
3. **User-level**: `~/.claude/agents/` (lowest priority)

**Important**: Agents must be in a **flat directory structure** - no subdirectories allowed in `~/.claude/agents/`.

### Agent File Format

Each agent is a Markdown file with YAML frontmatter:

```markdown
---
name: agent-name
description: When to use this agent
model: sonnet              # Optional: sonnet, opus, haiku, inherit
color: blue                # Optional: color for UI
tools: Tool1, Tool2        # Optional: specific tools this agent can use
---

Agent system prompt and instructions go here...
```

### Using Agents

Agents are invoked via the Task tool:

```markdown
I need help implementing a new feature for user authentication.
```

Claude Code will automatically suggest or use the appropriate agent (e.g., `full-stack-engineer`).

## Updating Agents

This repository is the **source of truth** for agent definitions.

### Simple Update (Recommended)

**macOS/Linux:**
```bash
cd /path/to/llm-guides/claude-code
./update-agents.sh
```

**Windows:**
```cmd
cd C:\path\to\llm-guides\claude-code
update-agents.bat
```

This script:
1. Pulls latest changes from GitHub
2. Installs/updates agents and reference docs to `~/.claude/`
3. Tells you to restart Claude Code

### Manual Update

If you prefer step-by-step control:

**macOS/Linux:**
```bash
cd claude-code
git pull origin main
./install-agents.sh
```

**Windows:**
```cmd
cd claude-code
git pull origin main
install-agents.bat
```

### Getting Updates

When agents are updated in the repository, team members can sync:

```bash
cd llm-guides/claude-code
./update-agents.sh  # (or update-agents.bat on Windows)
```

Then restart Claude Code - agents are ready to use!

### For Teams

1. **Maintainer**: Make changes to files in this repository → commit → push to GitHub
2. **Team members**: Run `update-agents.sh` (or `.bat` on Windows)
3. Everyone stays in sync with the same agent definitions

### Making Changes

1. Edit agent files in `claude-code/agents/*/`
2. Edit reference docs in `claude-code/reference-documentation/`
3. Test locally: run `./install-agents.sh` (or `.bat`)
4. Commit and push to GitHub
5. Team runs `./update-agents.sh` (or `.bat`) to get changes

## Reference Path Updates

When agents are installed globally, their reference documentation paths are automatically updated:

- **Before**: `../reference-documentation/golang/golang-code-writer.md`
- **After**: `~/.claude/reference-documentation/golang/golang-code-writer.md`

This allows agents to access documentation from any project location.

## Technology Stack

These agents are configured for:

**Backend:**
- Go

**Frontend:**
- TypeScript
- Vue.js
- Tailwind CSS
- Vite
- Pinia (state management)
- Vitest (testing)

**Database:**
- PostgreSQL/MySQL

**Testing:**
- Go testing framework
- Vitest/Jest
- Playwright (E2E)

## Contributing

When adding or modifying agents:

1. Follow the existing file structure and naming conventions
2. Include complete YAML frontmatter (name, description required)
3. Reference appropriate documentation files
4. Update this README if adding new agent categories
5. Test the agent before committing
6. Use descriptive commit messages

## Version Control

- **Source**: This repository (`llm-guides/claude-code/`)
- **Installed**: `~/.claude/agents/` and `~/.claude/reference-documentation/`
- **Install script**: `../install-agents.sh` (from repo root)

Always edit files in this repository, not in `~/.claude/` directly.

## Troubleshooting

### Agents don't appear in `/agents`

1. Restart Claude Code (agent discovery happens at startup)
2. Check files exist in `~/.claude/agents/`
3. Verify YAML frontmatter is valid
4. Ensure no subdirectories in `~/.claude/agents/` (must be flat)

### Reference documentation not found

1. Check files exist in `~/.claude/reference-documentation/`
2. Verify paths in agent files use `~/.claude/reference-documentation/...`
3. Re-run `./install-agents.sh` to update paths

### Agent behaves unexpectedly

1. Check agent file YAML frontmatter for syntax errors
2. Verify the agent's system prompt is clear and complete
3. Test with a fresh Claude Code session
4. Check for conflicting project-level agents (they override user-level)

## Related Documentation

- [Agent Directory README](agents/README.md) - Detailed agent specifications
- [Reference Documentation README](reference-documentation/README.md) - Language guide details
- Main repository [README](../README.md) - General LLM guides

---

**Maintained by**: Shapestone Engineering Team
**Repository**: https://github.com/shapestone/llm-guides
