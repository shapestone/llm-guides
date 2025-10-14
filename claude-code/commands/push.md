---
argument-hint: [feature description]
description: [feature]
---

You are orchestrating **Phase 4: Push** for: $ARGUMENTS

This phase handles all Git operations including creating a unique feature branch, committing changes, and pushing to GitHub.

## Phase 4: Git Operations

**Use git-ops-engineer** to perform all Git operations.

---

### Step 1: Pre-Push Verification

**Before any Git operations, verify:**

```bash
# Run full test suite
go test ./...
npm test
npx playwright test

# Verify builds
go build ./cmd/server
npm run build

# Check for uncommitted sensitive files
git status | grep -E '\.env|credentials|secrets|\.key|\.pem'
```

**Pre-Push Checklist:**
- [ ] All tests passing (unit + integration + E2E)
- [ ] Application builds successfully
- [ ] No sensitive files in changes
- [ ] Code has been reviewed
- [ ] Phase 3 review completed with ship approval

---

### Step 2: Create Unique Feature Branch

**Use git-ops-engineer** to create a unique branch name to avoid conflicts:

```bash
# Generate unique feature branch name
BRANCH_NAME="feature/$(echo '$ARGUMENTS' | sed 's/[^a-zA-Z0-9]/-/g' | tr '[:upper:]' '[:lower:]')-$(date +%s)"

# Example: feature/add-user-notifications-1704153600

# Create and switch to branch
git checkout -b "$BRANCH_NAME"
```

**Branch Naming Convention:**
- Feature: `feature/<description>-<timestamp>`
- Bug fix: `fix/<description>-<timestamp>`
- Hotfix: `hotfix/<description>-<timestamp>`

---

### Step 3: Review and Stage Changes

**Review what has changed:**
```bash
# See all changes
git status

# See detailed diff
git diff

# Review specific files
git diff path/to/file.go
git diff path/to/file.vue
```

**Stage Changes:**

**Option A: Stage Specific Files (Recommended)**
```bash
# Stage related backend changes
git add internal/notifications/
git add cmd/server/handlers/notifications.go
git add migrations/

# Stage related frontend changes
git add frontend/src/components/NotificationCenter.vue
git add frontend/src/stores/notificationStore.ts
git add frontend/src/services/notificationService.ts
```

**Option B: Stage All Changes (Use Cautiously)**
```bash
# Review first!
git status

# Stage all if appropriate
git add .
```

**IMPORTANT: Never Stage:**
- `.env` files
- `credentials.json`
- Private keys (`.key`, `.pem`)
- Secrets or API keys
- Build artifacts
- `node_modules/`
- IDE-specific files (unless intentional)

---

### Step 4: Create Commit

**Commit with meaningful message:**

```bash
# Commit format: <type>: <description>
git commit -m "feat: add real-time user mention notifications

Implemented notification system that alerts users when mentioned in posts.

Features:
- Real-time WebSocket notifications
- Notification center UI component
- Mark as read functionality
- User notification preferences
- Badge counter for unread notifications

Backend:
- NotificationService with creation and retrieval methods
- WebSocket handler for real-time delivery
- Database schema for notifications table
- API endpoints: GET /notifications, POST /notifications/:id/read

Frontend:
- NotificationCenter Vue component
- Pinia store for notification state
- WebSocket client service
- Toast notifications for real-time updates

Tests:
- Unit tests for service layer
- Integration tests for API endpoints
- E2E tests for user workflows
- Test coverage: 85%
"
```

**Commit Message Guidelines:**

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation only
- `refactor`: Code refactoring
- `test`: Adding tests
- `perf`: Performance improvement
- `security`: Security fix
- `chore`: Maintenance

**Format:**
```
<type>: <short summary> (max 72 characters)

<optional detailed body>

<optional footer>
```

**CRITICAL - Do NOT Include:**
- ❌ "Co-Authored-By: Claude"
- ❌ "Generated with Claude Code"
- ❌ Any AI attribution

Write natural, professional commit messages as if written by a human developer.

---

### Step 5: Push to GitHub

**Push the feature branch:**

```bash
# First push (set upstream)
git push -u origin "$BRANCH_NAME"

# Example output:
# To github.com:username/repo.git
#  * [new branch]      feature/add-user-notifications-1704153600 -> feature/add-user-notifications-1704153600
# Branch 'feature/add-user-notifications-1704153600' set up to track remote branch...
```

**Push Success Verification:**
```bash
# Verify branch pushed
git branch -vv

# Should show:
# * feature/add-user-notifications-1704153600  abc1234 [origin/feature/...] feat: add real-time...
```

---

### Step 6: Verify Remote Branch

**Check GitHub:**

```bash
# View repository on GitHub
gh repo view --web

# List remote branches
gh api repos/:owner/:repo/branches | jq '.[].name'

# Should show your new branch
```

---

## Optional: Create Pull Request

**If ready to create PR (optional at this stage):**

```bash
# Create PR using gh CLI
gh pr create \
  --title "feat: Add real-time user mention notifications" \
  --body "$(cat <<'EOF'
## Summary
Implemented real-time notification system for user mentions.

## Changes
- Backend notification service and APIs
- Frontend notification center UI
- WebSocket real-time delivery
- User notification preferences
- E2E test coverage

## Testing
- ✓ All unit tests passing (85% coverage)
- ✓ Integration tests passing
- ✓ E2E tests passing
- ✓ Manual testing completed
- ✓ Performance verified
- ✓ Security reviewed

## Phase Completed
- ✓ Phase 1: Discovery
- ✓ Phase 2: Implementation
- ✓ Phase 3: Review
- ✓ Phase 4: Push
- ⏳ Phase 5: Release (pending)

Ready for final review and merge.
EOF
)"

# Get PR URL
gh pr view --web
```

---

## Troubleshooting

### Issue: Push Rejected (Behind Remote)

```bash
# Fetch latest changes
git fetch origin

# Rebase onto main
git rebase origin/main

# Resolve any conflicts
# ... resolve conflicts ...
git add <resolved-files>
git rebase --continue

# Force push (safe with --force-with-lease)
git push --force-with-lease origin "$BRANCH_NAME"
```

### Issue: Accidental Sensitive File Committed

```bash
# Remove from staging (before commit)
git reset HEAD .env

# Remove from last commit (after commit, before push)
git reset --soft HEAD~1
git reset HEAD .env
git commit -m "..."

# If already pushed (contact team, rotate secrets)
```

### Issue: Wrong Branch Name

```bash
# Rename branch locally
git branch -m old-name new-name

# Delete old remote branch
git push origin :old-name

# Push new branch
git push -u origin new-name
```

---

## Phase 4 Complete Criteria

- [ ] Unique feature branch created
- [ ] All changes reviewed and staged
- [ ] Commit created with professional message
- [ ] No sensitive data in commit
- [ ] Branch pushed to GitHub successfully
- [ ] Remote branch verified
- [ ] Pull request created (optional)

**Output:**

```markdown
## Phase 4: Push Complete

### Branch Information
- **Branch Name**: feature/add-user-notifications-1704153600
- **Commit SHA**: abc1234567890...
- **Commit Message**: feat: add real-time user mention notifications

### Changes Pushed
- **Files Changed**: 23
- **Insertions**: +1,234 lines
- **Deletions**: -56 lines

### Remote Status
- **Push Status**: ✓ Success
- **Remote Branch**: origin/feature/add-user-notifications-1704153600
- **PR Created**: Yes (optional)
- **PR URL**: https://github.com/username/repo/pull/123

### Next Steps
Ready for Phase 5: Release
- Documentation updates
- Project tracking
- Optional: Tag creation
- Optional: Merge to main
```

**Next Command:**
```
/release [feature description]
```
