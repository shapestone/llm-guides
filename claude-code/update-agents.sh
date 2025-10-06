#!/bin/bash
#
# update-agents.sh
# Pulls latest changes from GitHub and installs/updates agents to ~/.claude/
#
# Usage:
#   ./update-agents.sh           # Pull and install
#   ./update-agents.sh --no-pull # Skip git pull, just install

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NO_PULL=false

if [[ "$1" == "--no-pull" ]]; then
    NO_PULL=true
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

echo "Updating Custom Agents and Reference Documentation"
echo "===================================================="
echo ""

# Step 1: Pull latest changes from GitHub
if [ "$NO_PULL" = false ]; then
    info "Pulling latest changes from GitHub..."
    cd "$SCRIPT_DIR"

    # Check if we're in a git repository
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo "Error: Not a git repository"
        exit 1
    fi

    # Get current branch
    CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

    # Pull latest changes
    if git pull origin "$CURRENT_BRANCH"; then
        log "Successfully pulled latest changes from $CURRENT_BRANCH"
    else
        echo "Error: Failed to pull from GitHub"
        echo "Please resolve any conflicts and try again"
        exit 1
    fi
    echo ""
else
    info "Skipping git pull (--no-pull specified)"
    echo ""
fi

# Step 2: Run installation script
info "Installing agents and reference documentation..."
"$SCRIPT_DIR/install-agents.sh"

echo ""
echo "===================================================="
echo -e "${GREEN}UPDATE COMPLETE${NC}"
echo ""
echo "Next steps:"
echo "  1. Restart Claude Code (if running)"
echo "  2. Run '/agents' to see available agents"
echo ""
