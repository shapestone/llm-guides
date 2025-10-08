# Migrating to Unified Documentation Structure

This guide helps you migrate existing projects from ad-hoc documentation organization to the standardized publishing-aware structure defined in `document-project-layout.md`.

## Key Concept: Internal vs. Published Documentation

The new structure separates documentation by **publishing boundary**:
- **`docs/`** - Internal documentation (stays in repo, never published)
- **`user-docs/`** - Published end-user documentation (→ docs.yourproduct.com)
- **`developer-docs/`** - Published developer/API documentation (→ developers.yourproduct.com)
- **`design-system/`** - Published design system documentation (→ design.yourproduct.com or Storybook)

## Quick Migration Commands

### For NomadAI-style Projects

If you have both `specifications/` and `docs/` directories:

```bash
# From project root

# 1. Create new directory structure
mkdir -p docs/architecture/specifications
mkdir -p docs/product/{requirements,roadmap,research}
mkdir -p docs/contributor
mkdir -p docs/performance/benchmarks
mkdir -p user-docs/{tutorials,features}
mkdir -p developer-docs/api/{reference,guides}

# 2. Move internal architecture/product specs to docs/
mv specifications/architecture.md docs/architecture/specifications/system-overview.md
mv specifications/product-vision.md docs/product/roadmap/product-vision.md
mv specifications/competitive-analysis.md docs/product/research/competitive-analysis.md
mv specifications/llm-integration-spec.md docs/architecture/specifications/llm-integration.md

# 3. Move internal performance/analysis docs
mv docs/api-cost-analysis.md docs/performance/benchmarks/api-cost-analysis.md

# 4. Move contributor guides to docs/contributor/
mv docs/local-setup.md docs/contributor/local-setup.md 2>/dev/null || true
mv docs/contributing.md docs/contributor/contributing.md 2>/dev/null || true

# 5. Move user-facing guides to user-docs/
# (if you had any user guides, move them here)
# mv docs/user-guide.md user-docs/getting-started.md

# 6. Move developer/API guides to developer-docs/
mv docs/frontend-components.md developer-docs/api/guides/frontend-integration.md
mv docs/playwright-setup-guide.md docs/contributor/playwright-setup.md

# 7. Remove old directories if empty
rmdir specifications 2>/dev/null || echo "specifications/ not empty, please review remaining files"
```

## Migration Strategy by Directory

### Decision Tree: Internal or Published?

Before migrating a document, ask:
1. **Who is the audience?**
   - Internal team only → `docs/`
   - End users → `user-docs/`
   - External developers/API users → `developer-docs/`
   - Designers/developers using design system → `design-system/`

2. **Will this be on a public website?**
   - No → `docs/`
   - Yes → One of the published directories

### From `specifications/` Directory

**Internal specs (stay in repo):**

| Old Location | New Location | Agent Owner |
|-------------|--------------|-------------|
| `specifications/architecture.md` | `docs/architecture/specifications/system-overview.md` | system-architect |
| `specifications/product-vision.md` | `docs/product/roadmap/product-vision.md` | technical-product-owner |
| `specifications/security-threat-model.md` | `docs/security/threat-models/auth-threat-model.md` | security-engineer |
| `specifications/data-model.md` | `docs/database/schema/data-model.md` | data-database-engineer |

**Published specs (go to published directories):**

| Old Location | New Location | Agent Owner |
|-------------|--------------|-------------|
| `specifications/api-spec.yaml` | `developer-docs/api/reference/openapi.yaml` | documentation-engineer |
| `specifications/design-tokens.md` | `design-system/tokens/design-tokens.md` | design-systems-engineer |

### From Generic `docs/` Directory

**Internal docs (stay in `docs/`):**

| Old Location | New Location | Agent Owner |
|-------------|--------------|-------------|
| `docs/architecture-decisions/` | `docs/architecture/decisions/` | system-architect |
| `docs/deployment.md` | `docs/operations/deployment/production-deployment.md` | devops-engineer |
| `docs/runbooks/` | `docs/operations/runbooks/` | devops-engineer |
| `docs/security-audit.md` | `docs/security/assessments/2025-q4-audit.md` | security-engineer |
| `docs/benchmarks/` | `docs/performance/benchmarks/` | performance-engineer |

**Contributor docs (internal):**

| Old Location | New Location | Agent Owner |
|-------------|--------------|-------------|
| `docs/setup.md` | `docs/contributor/local-setup.md` | documentation-engineer |
| `docs/contributing.md` | `docs/contributor/contributing.md` | documentation-engineer |
| `docs/testing.md` | `docs/contributor/testing-guide.md` | documentation-engineer |

**Published user docs:**

| Old Location | New Location | Agent Owner |
|-------------|--------------|-------------|
| `docs/user-guide.md` | `user-docs/getting-started.md` | documentation-engineer |
| `docs/tutorials/` | `user-docs/tutorials/` | documentation-engineer |
| `docs/faq.md` | `user-docs/faq.md` | documentation-engineer |

**Published developer docs:**

| Old Location | New Location | Agent Owner |
|-------------|--------------|-------------|
| `docs/api.md` | `developer-docs/getting-started.md` | documentation-engineer |
| `docs/api-reference/` | `developer-docs/api/reference/` | documentation-engineer |
| `docs/sdk/` | `developer-docs/sdk/` | documentation-engineer |

**Published design system docs:**

| Old Location | New Location | Agent Owner |
|-------------|--------------|-------------|
| `docs/components/` | `design-system/components/` | design-systems-engineer |
| `docs/design-tokens.md` | `design-system/tokens/design-tokens.md` | design-systems-engineer |

## Step-by-Step Migration Process

### Phase 1: Audit Current Documentation

```bash
# List all current documentation files
find . -name "*.md" -type f ! -path "*/node_modules/*" ! -path "*/.git/*" ! -path "*/vendor/*"
```

Create an inventory:
1. List each document
2. Determine its purpose
3. Identify appropriate new location (use document-project-layout.md)
4. Note which agent owns that category

### Phase 2: Create Directory Structure

Only create directories you need (don't create full structure upfront):

```bash
# Example: If you have architecture, product, and developer docs
mkdir -p docs/architecture/{decisions,diagrams,specifications}
mkdir -p docs/product/{requirements,roadmap,research}
mkdir -p docs/guides/developer
```

### Phase 3: Move Files

Move files one category at a time, updating internal links as you go:

```bash
# Example: Move architecture docs
mv specifications/architecture.md docs/architecture/specifications/system-overview.md

# Update links in the file (example using sed on macOS)
sed -i '' 's|../specifications/|../architecture/specifications/|g' docs/architecture/specifications/system-overview.md
```

### Phase 4: Update References

Search for broken links:

```bash
# Find markdown links that might be broken
grep -r "\[.*\](.*\.md)" docs/
```

Update code comments that reference old paths:

```bash
# Find code comments referencing old paths
rg "specifications/" --type go --type ts
```

### Phase 5: Clean Up

Remove old directories only when empty:

```bash
# Check if old directories are empty
ls -la specifications/
ls -la old-docs/

# Remove if empty
rmdir specifications/
```

## Project-Specific Migration Examples

### Example 1: NomadAI

**Before:**
```
NomadAI/
├── specifications/
│   ├── architecture.md
│   ├── competitive-analysis.md
│   ├── llm-integration-spec.md
│   ├── nomad-ai.md
│   ├── product-vision.md
│   └── storage.md
└── docs/
    ├── api-cost-analysis.md
    ├── frontend-components.md
    └── playwright-setup-guide.md
```

**After:**
```
NomadAI/
├── docs/                              # Internal documentation
│   ├── architecture/
│   │   └── specifications/
│   │       ├── system-overview.md     # was architecture.md
│   │       ├── llm-integration.md
│   │       └── storage-architecture.md
│   ├── product/
│   │   ├── research/
│   │   │   └── competitive-analysis.md
│   │   └── roadmap/
│   │       └── product-vision.md
│   ├── performance/
│   │   └── benchmarks/
│   │       └── api-cost-analysis.md
│   └── contributor/
│       └── playwright-setup.md
│
├── user-docs/                         # Published user documentation
│   ├── getting-started.md
│   └── features/
│
└── developer-docs/                    # Published developer documentation
    ├── getting-started.md
    └── api/
        └── guides/
            └── frontend-integration.md  # was frontend-components.md
```

**Migration commands:**
```bash
cd NomadAI

# Create new structure
mkdir -p docs/architecture/specifications
mkdir -p docs/product/{research,roadmap}
mkdir -p docs/performance/benchmarks
mkdir -p docs/contributor
mkdir -p user-docs/features
mkdir -p developer-docs/api/guides

# Move internal specs
mv specifications/architecture.md docs/architecture/specifications/system-overview.md
mv specifications/llm-integration-spec.md docs/architecture/specifications/llm-integration.md
mv specifications/storage.md docs/architecture/specifications/storage-architecture.md
mv specifications/competitive-analysis.md docs/product/research/
mv specifications/product-vision.md docs/product/roadmap/

# Move internal docs
mv docs/api-cost-analysis.md docs/performance/benchmarks/

# Move contributor docs (internal)
mv docs/playwright-setup-guide.md docs/contributor/

# Move published developer docs
mv docs/frontend-components.md developer-docs/api/guides/frontend-integration.md

# Create placeholder published docs
echo "# Getting Started with NomadAI" > user-docs/getting-started.md
echo "# Developer Quick Start" > developer-docs/getting-started.md

# Clean up
rmdir specifications
```

### Example 2: Apilary

**Before:**
```
apilary/
└── docs/
    └── assets/
        └── (images)
```

**After:**
```
apilary/
└── docs/
    ├── architecture/
    │   └── (create as needed)
    ├── api/
    │   └── (create as needed)
    ├── guides/
    │   └── (create as needed)
    └── assets/
        └── (images - keep as is)
```

**Note:** Start fresh with new docs in proper locations. Keep `assets/` where it is.

## Handling Edge Cases

### Architecture Decision Records (ADRs)

If you have existing ADRs in various locations:

```bash
# Collect existing ADRs
mkdir -p docs/architecture/decisions

# If numbered ADRs exist
mv adr/0001-*.md docs/architecture/decisions/

# If unnumbered, renumber them
cd docs/architecture/decisions
# Manually rename or use a script:
# old-decision.md → 0001-old-decision.md
```

### Large Documentation Sets

For projects with 50+ documentation files:

1. **Prioritize**: Migrate active documents first
2. **Archive**: Move obsolete docs to `docs/archive/YYYY-MM-DD/`
3. **Batch by owner**: Migrate all architecture docs, then all product docs, etc.
4. **Update gradually**: Don't need to update all links at once

### Monorepo Projects

For monorepos with multiple services:

```
monorepo/
├── docs/                    # Shared/cross-cutting docs
│   ├── architecture/       # Overall system architecture
│   └── product/            # Product roadmap
├── services/
│   ├── auth-service/
│   │   └── docs/          # Service-specific docs
│   │       ├── api/
│   │       └── operations/
│   └── payment-service/
│       └── docs/
│           ├── api/
│           └── security/
```

## Updating Tool Configurations

### Update .gitignore

If you ignored old doc paths:

```diff
# .gitignore
- specifications/temp/
- docs/drafts/
+ docs/*/drafts/
+ docs/archive/
```

### Update CI/CD

If documentation builds are automated:

```diff
# .github/workflows/docs.yml
- docs_dir: 'docs'
+ docs_dir: 'docs'  # Same, but check for subdirectories

# If you have link checkers:
- paths: ['docs/*.md', 'specifications/*.md']
+ paths: ['docs/**/*.md']
```

### Update IDE/Editor Settings

If you have documentation shortcuts:

```json
// VSCode settings.json
{
  "files.associations": {
    "docs/**/*.md": "markdown"
  }
}
```

## Post-Migration Checklist

- [ ] All documentation files moved to new locations
- [ ] Internal links updated and verified
- [ ] Code comments referencing docs updated
- [ ] README.md updated with new doc structure
- [ ] Old directories removed
- [ ] Team notified of new structure
- [ ] Added `docs/README.md` explaining structure
- [ ] Updated any build/CI scripts
- [ ] Verified documentation website still builds (if applicable)
- [ ] Updated any onboarding/contributing guides

## Rollback Plan

If migration causes issues:

```bash
# Restore from git
git checkout HEAD -- docs/ specifications/

# Or if committed
git revert <migration-commit-sha>
```

Keep a backup before migrating:

```bash
# Before migration
tar -czf docs-backup-$(date +%Y%m%d).tar.gz docs/ specifications/
```

## Tips for Success

1. **Migrate incrementally** - Do one category at a time, commit after each
2. **Update agent prompts** - Train your team/agents on new structure
3. **Document the migration** - Keep notes on what you moved where
4. **Test link integrity** - Use tools like `markdown-link-check`
5. **Communicate early** - Tell team before, during, and after migration
6. **Keep a mapping** - Create a "moved from → to" reference document

## Getting Help

If you're unsure where a document should go:

1. Check `document-project-layout.md` directory descriptions
2. Look at agent responsibilities in `claude-code/agents/*/`
3. Ask: "Which agent would create/maintain this document?"
4. When in doubt, use `docs/guides/` and refactor later

## Example Migration Script

Save this as `migrate-docs.sh`:

```bash
#!/bin/bash
# migrate-docs.sh - Helper script for doc migration

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

log() { echo -e "${GREEN}✓${NC} $1"; }
info() { echo -e "${BLUE}ℹ${NC} $1"; }

# Create backup
info "Creating backup..."
tar -czf docs-backup-$(date +%Y%m%d-%H%M%S).tar.gz docs/ specifications/ 2>/dev/null || true
log "Backup created"

# Create new structure (customize as needed)
info "Creating new directory structure..."
mkdir -p docs/architecture/{decisions,diagrams,specifications}
mkdir -p docs/product/{requirements,roadmap,research}
mkdir -p docs/guides/{user,developer}
log "Directories created"

# Move files (customize these for your project)
info "Moving files..."

# Add your mv commands here
# mv specifications/architecture.md docs/architecture/specifications/system-overview.md

log "Migration complete!"
info "Next steps:"
info "  1. Review moved files"
info "  2. Update internal links"
info "  3. Test documentation builds"
info "  4. Update README.md"
```

## Maintenance After Migration

Once migrated, keep documentation organized:

1. **Agent guidelines** - Agents know where to put new docs
2. **PR reviews** - Check docs go in right locations
3. **Periodic audits** - Review structure quarterly
4. **Update document-project-layout.md** - If you find gaps
5. **Archive old docs** - Don't let them accumulate

## Version History

- **v1.0** (2025-10-08): Initial migration guide for unified docs structure
