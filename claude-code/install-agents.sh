#!/bin/bash
#
# install-agents.sh
# Installs/updates custom agents, commands, workflows, and reference documentation to ~/.claude/
#
# Usage:
#   ./install-agents.sh           # Install/update all agents, commands, and docs
#   ./install-agents.sh --dry-run # Show what would be installed without doing it

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_HOME="$HOME/.claude"
DRY_RUN=false

if [[ "$1" == "--dry-run" ]]; then
    DRY_RUN=true
    echo "DRY RUN MODE - No files will be modified"
    echo ""
fi

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log() {
    echo -e "${GREEN}✓${NC} $1"
}

info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

warn() {
    echo -e "${YELLOW}⚠${NC} $1"
}

run_or_print() {
    if [ "$DRY_RUN" = true ]; then
        echo "  Would run: $*"
    else
        "$@"
    fi
}

echo "Installing Custom Agents, Commands, Workflows, and Reference Documentation"
echo "=========================================================================="
echo ""

# Create directories
info "Creating directory structure..."
run_or_print mkdir -p "$CLAUDE_HOME/agents"
run_or_print mkdir -p "$CLAUDE_HOME/commands"
run_or_print mkdir -p "$CLAUDE_HOME/reference-documentation"/{golang,python,typescript,tailwind,workflows}
log "Directories created"
echo ""

# Copy agents
info "Installing agents to $CLAUDE_HOME/agents/"
AGENT_COUNT=0
for agent_file in "$SCRIPT_DIR/agents"/*/*.md; do
    if [ -f "$agent_file" ]; then
        agent_name=$(basename "$agent_file")
        if [ "$DRY_RUN" = true ]; then
            echo "  Would copy: $agent_name"
        else
            cp "$agent_file" "$CLAUDE_HOME/agents/"
        fi
        ((AGENT_COUNT++))
    fi
done
log "Installed $AGENT_COUNT agent files"
echo ""

# Copy commands
info "Installing commands to $CLAUDE_HOME/commands/"
COMMAND_COUNT=0
if [ -d "$SCRIPT_DIR/commands" ]; then
    for command_file in "$SCRIPT_DIR/commands"/*.md; do
        if [ -f "$command_file" ]; then
            command_name=$(basename "$command_file")
            if [ "$DRY_RUN" = true ]; then
                echo "  Would copy: $command_name"
            else
                cp "$command_file" "$CLAUDE_HOME/commands/"
            fi
            ((COMMAND_COUNT++))
        fi
    done
    log "Installed $COMMAND_COUNT command file(s)"
else
    warn "No commands directory found, skipping"
fi
echo ""

# Copy workflows
info "Installing workflow documentation to $CLAUDE_HOME/reference-documentation/workflows/"
WORKFLOW_COUNT=0
if [ -d "$SCRIPT_DIR/workflows" ]; then
    for workflow_file in "$SCRIPT_DIR/workflows"/*.md; do
        if [ -f "$workflow_file" ]; then
            workflow_name=$(basename "$workflow_file")
            if [ "$DRY_RUN" = true ]; then
                echo "  Would copy: $workflow_name"
            else
                cp "$workflow_file" "$CLAUDE_HOME/reference-documentation/workflows/"
            fi
            ((WORKFLOW_COUNT++))
        fi
    done
    log "Installed $WORKFLOW_COUNT workflow document(s)"
else
    warn "No workflows directory found, skipping"
fi
echo ""

# Copy reference documentation
info "Installing reference documentation to $CLAUDE_HOME/reference-documentation/"

# Copy root-level reference docs
for doc in code-writer.md document-project-layout.md; do
    if [ -f "$SCRIPT_DIR/reference-documentation/$doc" ]; then
        run_or_print cp "$SCRIPT_DIR/reference-documentation/$doc" "$CLAUDE_HOME/reference-documentation/"
        log "Copied $doc"
    fi
done

# Copy language-specific docs
for lang_dir in golang python typescript tailwind; do
    if [ -d "$SCRIPT_DIR/reference-documentation/$lang_dir" ]; then
        doc_count=$(ls -1 "$SCRIPT_DIR/reference-documentation/$lang_dir"/*.md 2>/dev/null | wc -l || echo 0)
        if [ "$doc_count" -gt 0 ]; then
            run_or_print cp "$SCRIPT_DIR/reference-documentation/$lang_dir"/*.md "$CLAUDE_HOME/reference-documentation/$lang_dir/"
            log "Copied $doc_count file(s) for $lang_dir"
        fi
    fi
done
echo ""

# Update reference paths in agent files
if [ "$DRY_RUN" = false ]; then
    info "Updating reference documentation paths in agent files..."
    for agent_file in "$CLAUDE_HOME/agents"/*.md; do
        if [ -f "$agent_file" ]; then
            # Replace relative paths with absolute paths
            sed -i.bak 's|](../reference-documentation/|](~/.claude/reference-documentation/|g' "$agent_file"
            rm -f "${agent_file}.bak"
        fi
    done
    log "Updated reference paths"
else
    echo "  Would update reference paths in all agent files"
fi
echo ""

# Summary
echo "=========================================================================="
if [ "$DRY_RUN" = true ]; then
    echo -e "${YELLOW}DRY RUN COMPLETE${NC}"
    echo "No files were modified. Run without --dry-run to install."
else
    echo -e "${GREEN}INSTALLATION COMPLETE${NC}"
    echo ""
    echo "Installed to:"
    echo "  • Agents: $CLAUDE_HOME/agents/ ($AGENT_COUNT files)"
    echo "  • Commands: $CLAUDE_HOME/commands/ ($COMMAND_COUNT files)"
    echo "  • Workflows: $CLAUDE_HOME/reference-documentation/workflows/ ($WORKFLOW_COUNT files)"
    echo "  • Reference Docs: $CLAUDE_HOME/reference-documentation/"
    echo ""
    echo "Next steps:"
    echo "  1. Restart Claude Code (if running)"
    echo "  2. Run '/agents' to see available agents"
    echo "  3. Try '/implement-feature' or '/full-review' commands"
    echo "  4. Read workflow guides in ~/.claude/reference-documentation/workflows/"
fi
echo ""
