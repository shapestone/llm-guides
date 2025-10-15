---
description: [update documentation]
---

You are orchestrating the **Documentation Update Phase** to ensure all documentation stays current with the codebase.

## Documentation Phase Objectives

1. **Audit Current Documentation**
2. **Identify Documentation Gaps**
3. **Update Technical Documentation**
4. **Update User-Facing Documentation**
5. **Verify Documentation Accuracy**

---

## Step 1: Audit Current Documentation

**Use documentation-engineer** to:

### Review Existing Documentation

Scan all documentation locations:
- `README.md` - Project overview and quick start
- `docs/api/` - API documentation
- `docs/architecture/` - Architecture decisions and diagrams
- `docs/user/` - User guides and tutorials
- `docs/developer/` - Developer onboarding and guides
- `docs/project/` - Project planning and reports
- Code comments and inline documentation

### Compare Documentation to Current Code

For each documentation file:
1. Check if referenced features still exist
2. Verify API endpoints match current implementation
3. Confirm code examples are accurate
4. Check if screenshots/diagrams are current
5. Identify deprecated features that need removal

### Create Documentation Inventory

```markdown
## Documentation Audit: [Date]

### ✅ Up to Date
- [File name] - Last updated: [Date] - Status: Current

### ⚠️ Needs Minor Updates
- [File name] - Issue: [What needs updating]
- [File name] - Issue: [What needs updating]

### ❌ Needs Major Updates
- [File name] - Issue: [Significant changes needed]
- [File name] - Issue: [Significant changes needed]

### 🆕 Missing Documentation
- [Feature/API] - Needs: [Type of documentation]
- [Feature/API] - Needs: [Type of documentation]

### 🗑️ Deprecated Documentation
- [File name] - Reason: [Feature removed/changed]
```

---

## Step 2: Identify Documentation Gaps

**Analyze what's missing:**

### Recently Released Features

Check recent commits/PRs for new features:
```bash
# Review recent changes
git log --since="1 month ago" --oneline
gh pr list --state merged --limit 20
```

**For each new feature, check if documented:**
- [ ] API endpoints documented
- [ ] User guide updated
- [ ] Architecture docs updated
- [ ] Code examples provided
- [ ] Migration guide (if breaking changes)

### Undocumented Code Patterns

**Search for:**
- Public APIs without docstrings
- Complex functions without comments
- Configuration options not in docs
- Environment variables not documented
- Database schema not documented

### User-Facing Changes

**Check if documented:**
- New UI components or pages
- Changed workflows or processes
- New configuration requirements
- Updated installation steps
- Changed CLI commands or flags

---

## Step 3: Update Technical Documentation

**Use documentation-engineer** to update internal technical docs:

### 3.1 API Documentation

**Update for each API change:**

```markdown
## API Endpoint: [METHOD] /api/v1/resource

**Description:** [What this endpoint does]

**Authentication:** [Required/Optional - Type]

**Request:**
```http
POST /api/v1/resource HTTP/1.1
Content-Type: application/json

{
  "field1": "value",
  "field2": 123
}
```

**Response:**
```json
{
  "id": "abc123",
  "field1": "value",
  "createdAt": "2025-01-15T10:30:00Z"
}
```

**Status Codes:**
- 200: Success
- 400: Bad Request - [Common causes]
- 401: Unauthorized
- 500: Server Error

**Example:**
```bash
curl -X POST https://api.example.com/api/v1/resource \
  -H "Authorization: Bearer TOKEN" \
  -d '{"field1":"value"}'
```
```

### 3.2 Architecture Documentation

**Update Architecture Decision Records (ADRs):**

```markdown
# ADR [Number]: [Title]

**Date:** [Date]
**Status:** Accepted | Superseded | Deprecated

## Context
[What problem are we solving?]

## Decision
[What did we decide?]

## Consequences
**Positive:**
- [Benefit 1]
- [Benefit 2]

**Negative:**
- [Tradeoff 1]
- [Tradeoff 2]

## Alternatives Considered
- [Alternative 1] - Rejected because [reason]
- [Alternative 2] - Rejected because [reason]
```

### 3.3 Database Documentation

**Document schema changes:**

```markdown
## Table: `users`

| Column | Type | Nullable | Default | Description |
|--------|------|----------|---------|-------------|
| id | UUID | No | gen_random_uuid() | Primary key |
| email | VARCHAR(255) | No | - | User email (unique) |
| created_at | TIMESTAMP | No | NOW() | Account creation time |

**Indexes:**
- `idx_users_email` - Unique index on email

**Relationships:**
- One-to-Many with `posts` table via `posts.user_id`
```

### 3.4 Code Comments and Docstrings

**Update inline documentation:**

**Go example:**
```go
// ProcessPayment processes a payment transaction and returns the result.
// It validates the payment details, checks for fraud, and charges the card.
//
// Parameters:
//   - ctx: Request context for cancellation and timeout
//   - payment: Payment details including amount and card info
//
// Returns:
//   - *PaymentResult: Contains transaction ID and status
//   - error: Returns error if validation fails or payment processing errors
func ProcessPayment(ctx context.Context, payment *Payment) (*PaymentResult, error) {
    // Implementation
}
```

**TypeScript example:**
```typescript
/**
 * Fetches user data from the API
 * @param userId - The unique identifier for the user
 * @param includeProfile - Whether to include full profile data
 * @returns Promise resolving to User object
 * @throws {ApiError} When the user is not found or API fails
 */
async function fetchUser(userId: string, includeProfile = false): Promise<User> {
    // Implementation
}
```

---

## Step 4: Update User-Facing Documentation

**Use documentation-engineer** to update user documentation:

### 4.1 User Guides

**Update step-by-step guides:**

```markdown
# How to [Accomplish Task]

**Time required:** ~5 minutes
**Prerequisites:**
- [Prerequisite 1]
- [Prerequisite 2]

## Step 1: [Action]

[Detailed instructions]

**Screenshot/Visual:**
![Description](path/to/screenshot.png)

**Tip:** [Helpful hint]

## Step 2: [Next Action]

[More instructions]

**Example:**
```bash
command --option value
```

## Troubleshooting

**Problem:** [Common issue]
**Solution:** [How to fix]

**Problem:** [Another issue]
**Solution:** [How to fix]
```

### 4.2 README Updates

**Ensure README is current:**

```markdown
# Project Name

[One-line description]

## Features

✨ [Feature 1] - [Brief description]
✨ [Feature 2] - [Brief description]
✨ [Feature 3] - [Brief description]

## Quick Start

```bash
# Installation
git clone https://github.com/user/repo
cd repo
npm install  # or: go mod download, pip install -r requirements.txt

# Configuration
cp .env.example .env
# Edit .env with your settings

# Run
npm start  # or: go run main.go, python app.py
```

## Documentation

- [User Guide](docs/user/guide.md)
- [API Documentation](docs/api/README.md)
- [Architecture](docs/architecture/README.md)
- [Contributing](CONTRIBUTING.md)

## Requirements

- Node.js 18+ (or: Go 1.21+, Python 3.11+)
- PostgreSQL 14+
- Redis 7+

## License

[License type]
```

### 4.3 Changelog

**Maintain CHANGELOG.md:**

```markdown
# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]

### Added
- [New feature 1]
- [New feature 2]

### Changed
- [Changed behavior]
- [Updated dependency]

### Fixed
- [Bug fix 1]
- [Bug fix 2]

### Deprecated
- [Feature being deprecated]

### Removed
- [Removed feature]

### Security
- [Security fix or improvement]

## [1.2.0] - 2025-01-15

### Added
- Real-time notifications for mentions
- User profile customization

[Previous versions...]
```

### 4.4 Migration Guides

**For breaking changes:**

```markdown
# Migration Guide: v1.x to v2.0

## Overview

Version 2.0 introduces breaking changes to [area]. This guide helps you migrate.

## Breaking Changes

### 1. API Authentication

**Before (v1.x):**
```typescript
fetch('/api/users', {
  headers: { 'X-API-Key': apiKey }
})
```

**After (v2.0):**
```typescript
fetch('/api/users', {
  headers: { 'Authorization': `Bearer ${token}` }
})
```

**Action required:** Replace API key authentication with JWT tokens.

### 2. Database Schema

**Migration SQL:**
```sql
ALTER TABLE users ADD COLUMN email_verified BOOLEAN DEFAULT false;
CREATE INDEX idx_users_verified ON users(email_verified);
```

**Action required:** Run migration before deploying v2.0.

## Deprecation Timeline

- v2.0 (Jan 2025): Old auth deprecated, still works with warnings
- v2.1 (Mar 2025): Old auth removed completely

## Getting Help

- [Slack channel] for questions
- [GitHub issues] for bugs
```

---

## Step 5: Verify Documentation Accuracy

**Use documentation-engineer** to verify:

### 5.1 Test Code Examples

**For each code example:**
- [ ] Copy code exactly as written in docs
- [ ] Run in clean environment
- [ ] Verify it produces expected output
- [ ] Update if broken or outdated

### 5.2 Validate Links

**Check all documentation links:**
```bash
# Find broken internal links
find docs -name "*.md" -exec grep -l "](.*)" {} \;

# Check external links (if tools available)
markdown-link-check docs/**/*.md
```

**Fix or remove:**
- Broken internal links
- Dead external links
- Outdated references

### 5.3 Review with Fresh Eyes

**Documentation quality checklist:**
- [ ] Clear and concise language
- [ ] Proper grammar and spelling
- [ ] Consistent formatting and style
- [ ] Accurate and up-to-date information
- [ ] Appropriate for target audience
- [ ] Screenshots/diagrams are current
- [ ] Code examples work correctly
- [ ] No references to removed features

### 5.4 Test User Flows

**Follow documentation as a new user:**
- [ ] Complete "Getting Started" guide
- [ ] Follow API tutorial
- [ ] Try common tasks from user guides
- [ ] Verify installation instructions
- [ ] Check troubleshooting steps work

---

## Step 6: Generate Documentation Report

**Create comprehensive report:**

```markdown
# Documentation Update Report: [Date]

## Summary

- **Files Updated:** [N] files
- **New Documentation:** [N] new files
- **Removed Documentation:** [N] deprecated files
- **Gaps Remaining:** [N] items still need documentation

## Updates Made

### API Documentation
- ✅ Updated [endpoint] - Added new parameters
- ✅ Documented [new endpoint]
- ✅ Removed deprecated [old endpoint]

### User Guides
- ✅ Updated "Getting Started" - New installation steps
- ✅ Created "How to [Task]" guide
- ✅ Updated screenshots for [feature]

### Architecture Documentation
- ✅ Added ADR-007: [Decision]
- ✅ Updated system diagram
- ✅ Documented [component] architecture

### Code Documentation
- ✅ Added docstrings to [package]
- ✅ Updated inline comments in [module]
- ✅ Improved examples in [file]

## Remaining Gaps

### High Priority
1. [Feature X] - Needs user guide (Owner: [Name], Due: [Date])
2. [API Y] - Needs documentation (Owner: [Name], Due: [Date])

### Medium Priority
3. [Component Z] - Architecture docs needed
4. [Process W] - Developer guide needed

### Low Priority
5. [Feature V] - Could use more examples

## Metrics

- **Documentation Coverage:** [X]% of public APIs documented
- **Code Comment Density:** [X]% of functions have docstrings
- **User Guide Completeness:** [X]% of features have guides
- **Link Health:** [X]% of links working

## Next Actions

1. [Action 1] - Owner: [Name]
2. [Action 2] - Owner: [Name]
3. Schedule next documentation review: [Date]

## Verification

- [ ] All code examples tested
- [ ] All links validated
- [ ] Fresh user tested getting started guide
- [ ] Technical review completed
- [ ] User feedback incorporated
```

---

## Documentation Phase Output Locations

**Save documentation updates to:**

- API docs: `docs/api/`
- Architecture: `docs/architecture/`
- User guides: `docs/user/`
- Developer guides: `docs/developer/`
- ADRs: `docs/architecture/decisions/`
- Database: `docs/database/schema.md`
- Changelog: `CHANGELOG.md`
- Migration guides: `docs/migrations/`
- Documentation report: `docs/project/reports/YYYY-MM-documentation-report.md`

**Reference Standards:**

Always check these before writing:
- `~/.claude/reference-documentation/document-project-layout.md` - Documentation structure standards
- Project's existing documentation style and format

---

## Documentation Phase Complete Criteria

- [ ] All existing documentation audited
- [ ] Documentation gaps identified
- [ ] API documentation updated
- [ ] User guides updated
- [ ] Architecture docs current
- [ ] Code comments and docstrings updated
- [ ] README and CHANGELOG current
- [ ] Migration guides created (if needed)
- [ ] All code examples tested and working
- [ ] All links validated and fixed
- [ ] Fresh user can follow getting started guide
- [ ] Documentation report created

---

## When to Use This Command

**Use `/document` when:**
- After releasing new features
- After significant code changes
- Before major releases
- When onboarding new team members reveals gaps
- When users report documentation is outdated
- As part of regular maintenance (monthly/quarterly)
- After API changes
- After architecture decisions

**This command can be run:**
- Standalone at any time
- As part of `/release` workflow
- After `/implement` and `/review` cycles
- Before creating releases or tags

---

## Tips for Effective Documentation

1. **Write for your audience**: Technical docs for developers, simple language for users
2. **Show, don't just tell**: Include examples, screenshots, diagrams
3. **Keep it current**: Documentation that's wrong is worse than no documentation
4. **Test everything**: Code examples must work exactly as written
5. **Link generously**: Connect related documentation
6. **Maintain consistency**: Use same terminology and format throughout
7. **Version carefully**: Note which version documentation applies to
8. **Get feedback**: Ask users if documentation helped them
9. **Automate when possible**: Generate API docs from code comments
10. **Document decisions**: Not just what, but why

**Remember:** Good documentation is a feature, not an afterthought!
