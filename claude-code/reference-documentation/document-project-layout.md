# Document Project Layout

## Overview

This guide defines a standardized directory structure for documentation, with clear separation between **internal documentation** (stays in repo) and **published documentation** (deployed to websites).

## Philosophy

- **Separate by publishing boundary** - Internal vs. published docs use different top-level directories
- **Organized by purpose** - Group related documents together
- **Predictable locations** - Agents and developers know exactly where to find/create documents
- **Scalable** - Works for small projects (few files) and large projects (hundreds of docs)
- **Agent-friendly** - Clear ownership for each directory
- **Don't create until needed** - Start minimal, expand as project grows

## Standard Documentation Structure

```
project/
├── docs/                          # Internal documentation (never published)
│   ├── architecture/              # System architecture & design
│   │   ├── decisions/             # Architecture Decision Records (ADRs)
│   │   ├── diagrams/              # System diagrams
│   │   └── specifications/        # Technical design specs
│   ├── product/                   # Product requirements & planning
│   │   ├── requirements/          # User stories, acceptance criteria
│   │   ├── roadmap/               # Product roadmap
│   │   └── research/              # Market/competitive research
│   ├── security/                  # Security documentation
│   │   ├── assessments/           # Security audits
│   │   └── threat-models/         # Threat modeling
│   ├── performance/               # Performance analysis
│   │   ├── benchmarks/            # Performance test results
│   │   └── optimization/          # Optimization reports
│   ├── database/                  # Database design
│   │   ├── schema/                # Schema docs, ERDs
│   │   └── migrations/            # Migration planning
│   ├── project/                   # Project management
│   │   ├── planning/              # Project plans
│   │   └── reports/               # Status reports, retros
│   ├── operations/                # Operational procedures
│   │   ├── runbooks/              # Incident response
│   │   ├── deployment/            # Deployment procedures
│   │   └── monitoring/            # Monitoring setup
│   └── contributor/               # For code contributors
│       ├── local-setup.md
│       ├── contributing.md
│       ├── testing-guide.md
│       └── debugging.md
│
├── user-docs/                     # Published end-user documentation
│   ├── index.md                   # Homepage
│   ├── getting-started.md
│   ├── tutorials/
│   │   ├── your-first-project.md
│   │   └── advanced-features.md
│   ├── features/
│   │   ├── authentication.md
│   │   ├── data-export.md
│   │   └── collaboration.md
│   ├── faq.md
│   └── troubleshooting.md
│
├── developer-docs/                # Published developer documentation
│   ├── index.md                   # Developer portal homepage
│   ├── getting-started.md         # Quick start for API users
│   ├── api/
│   │   ├── reference/             # API reference docs
│   │   │   ├── openapi.yaml       # OpenAPI spec
│   │   │   └── endpoints/         # Endpoint documentation
│   │   └── guides/                # API usage guides
│   │       ├── authentication.md
│   │       ├── pagination.md
│   │       ├── rate-limiting.md
│   │       └── webhooks.md
│   ├── sdk/                       # SDK documentation (if applicable)
│   │   ├── javascript.md
│   │   ├── python.md
│   │   └── go.md
│   └── changelog.md               # API changelog
│
└── design-system/                 # Published design system docs
    ├── index.md                   # Design system homepage
    ├── getting-started.md
    ├── components/                # Component documentation
    │   ├── button.md
    │   ├── modal.md
    │   └── form-inputs.md
    ├── tokens/                    # Design tokens
    │   ├── colors.md
    │   ├── typography.md
    │   └── spacing.md
    └── patterns/                  # Design patterns
        ├── layouts.md
        ├── navigation.md
        └── accessibility.md
```

## Directory Descriptions

### docs/ - Internal Documentation (Never Published)

Documentation that stays in the repository and is only for internal team use.

#### architecture/
**Owner:** system-architect agent
**Purpose:** System architecture, design decisions, technical specifications

**decisions/**: Architecture Decision Records (ADRs)
- Numbered sequentially (0001, 0002, etc.)
- Format: Context, Decision, Consequences, Status
- Never delete, mark as superseded instead

**diagrams/**: Visual system representations
- C4 diagrams, sequence diagrams, flowcharts
- Store as Markdown with Mermaid/PlantUML

**specifications/**: Detailed technical design
- System integration patterns
- Technology evaluations
- Cross-cutting concerns

#### product/
**Owner:** technical-product-owner agent
**Purpose:** Product requirements, roadmap, research

**requirements/**: Feature requirements organized by epic
- Problem statement, user stories, acceptance criteria
- Link to related architecture specs

**roadmap/**: Product planning
- Quarterly/annual roadmaps
- Feature prioritization, release schedules

**research/**: Market and user research
- Competitive analysis, user feedback, market trends

#### security/
**Owner:** security-engineer agent
**Purpose:** Security assessments, threat models, compliance

**assessments/**: Security audit results
- Vulnerability scans, penetration tests
- Compliance audits

**threat-models/**: Threat modeling documents
- STRIDE analysis, risk assessments
- Mitigation strategies

#### performance/
**Owner:** performance-engineer agent
**Purpose:** Performance analysis, benchmarks, optimization

**benchmarks/**: Performance test results
- Load test reports, baseline metrics
- SLA/SLO definitions

**optimization/**: Optimization documentation
- Performance analysis, bottleneck identification
- Before/after comparisons

#### database/
**Owner:** data-database-engineer agent
**Purpose:** Database design, schema, data modeling

**schema/**: Database schema documentation
- ERD diagrams, table definitions
- Data dictionary, indexes

**migrations/**: Migration planning
- Schema change proposals
- Data migration strategies, rollback procedures

#### project/
**Owner:** project-manager agent
**Purpose:** Project planning, tracking, reporting

**planning/**: Project plans and timelines
- Sprint planning, milestone definitions
- Resource allocation, risk management

**reports/**: Status reports and retrospectives
- Sprint reports, metrics, lessons learned

#### operations/
**Owner:** devops-engineer agent
**Purpose:** Operational procedures, deployment, monitoring

**runbooks/**: Operational procedures
- Incident response, troubleshooting
- Disaster recovery, maintenance tasks

**deployment/**: Deployment documentation
- Release procedures, rollback procedures
- Environment configuration, CI/CD

**monitoring/**: Observability documentation
- Monitoring setup, dashboard configs
- Alert definitions, log aggregation

#### contributor/
**Owner:** documentation-engineer agent
**Purpose:** Documentation for people contributing code to this project

Files in this directory help developers set up their environment and contribute:
- `local-setup.md` - Dev environment setup
- `contributing.md` - How to contribute code
- `testing-guide.md` - Running/writing tests
- `debugging.md` - Debugging tips
- `code-style.md` - Code conventions

### user-docs/ - Published End-User Documentation

**Owner:** documentation-engineer agent
**Publishing target:** `docs.yourproduct.com` or similar
**Audience:** End users of your product

Documentation that gets published to your user-facing documentation website. Written for non-technical users.

**Structure:**
- `index.md` - Documentation homepage
- `getting-started.md` - New user onboarding
- `tutorials/` - Step-by-step tutorials
- `features/` - Feature-specific documentation
- `faq.md` - Frequently asked questions
- `troubleshooting.md` - Common issues and solutions

**Examples:**
- How to create an account
- How to use specific features
- Tutorials for common workflows
- Troubleshooting login issues

### developer-docs/ - Published Developer Documentation

**Owner:** documentation-engineer agent
**Publishing target:** `developers.yourproduct.com` or `api.yourproduct.com`
**Audience:** Developers integrating with your product/API

Documentation for developers who want to integrate with your API, use your SDKs, or build on your platform.

**api/reference/**: API reference documentation
- OpenAPI/Swagger specs
- Endpoint documentation
- Request/response examples

**api/guides/**: API usage guides
- Authentication guide
- Pagination patterns
- Rate limiting policies
- Webhook setup
- Error handling

**sdk/**: SDK documentation (if you provide SDKs)
- Language-specific guides
- SDK installation and setup
- Code examples

**Other files:**
- `getting-started.md` - Quick start for API users
- `changelog.md` - API version history

### design-system/ - Published Design System Documentation

**Owner:** design-systems-engineer agent
**Publishing target:** `design.yourproduct.com` or Storybook
**Audience:** Designers and developers using your design system

Documentation for your UI component library and design system.

**components/**: Component documentation
- Component behavior and API
- Props documentation
- Usage examples
- Accessibility requirements

**tokens/**: Design token documentation
- Color palettes
- Typography scales
- Spacing systems
- Breakpoints

**patterns/**: Design patterns and guidelines
- Layout patterns
- Interaction patterns
- Accessibility guidelines
- Responsive design strategies

## Naming Conventions

### File Names
- Use kebab-case: `authentication-system.md`, `user-authentication.md`
- Be descriptive: `payment-processing-requirements.md` not `requirements.md`
- Include dates for time-sensitive docs: `2025-q4-roadmap.md`

### ADR Naming
- Format: `NNNN-short-description.md`
- Example: `0001-use-postgresql.md`, `0012-adopt-graphql.md`
- Zero-padded to 4 digits

### Directory Names
- Use singular for concepts: `architecture/`, `performance/`
- Use plural for collections: `decisions/`, `diagrams/`, `guides/`

## Publishing Strategy

### Build Tools

Common documentation publishing tools:

**User Docs & Developer Docs:**
- Docusaurus
- VitePress
- MkDocs
- GitBook
- Read the Docs

**Design System:**
- Storybook
- Docusaurus
- Custom Vue/React documentation site

### Example Publishing Configuration

**Docusaurus** (user-docs/):
```js
// docusaurus.config.js
module.exports = {
  docs: {
    path: '../user-docs',
  },
};
```

**VitePress** (developer-docs/):
```js
// .vitepress/config.js
export default {
  srcDir: './developer-docs',
};
```

**Storybook** (design-system/):
```js
// .storybook/main.js
module.exports = {
  stories: [
    '../design-system/**/*.stories.mdx',
    '../design-system/**/*.stories.@(js|jsx|ts|tsx)',
  ],
};
```

### CI/CD Publishing

**GitHub Actions example:**
```yaml
# .github/workflows/docs.yml
name: Publish Documentation

on:
  push:
    branches: [main]
    paths:
      - 'user-docs/**'
      - 'developer-docs/**'
      - 'design-system/**'

jobs:
  publish-user-docs:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Build user docs
        run: |
          cd user-docs
          npm install
          npm run build
      - name: Deploy to docs.yourproduct.com
        # Deploy step...

  publish-developer-docs:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Build developer docs
        run: |
          cd developer-docs
          npm install
          npm run build
      - name: Deploy to developers.yourproduct.com
        # Deploy step...
```

## Integration with Code

### Go Projects
```
myapp/
├── cmd/
├── internal/
├── pkg/
├── docs/              # Internal docs (architecture, product, etc.)
├── user-docs/         # Published user docs
├── developer-docs/    # Published API docs
└── README.md
```

### TypeScript/Vue Projects
```
myapp/
├── src/
├── tests/
├── docs/              # Internal docs
├── user-docs/         # Published user docs
├── developer-docs/    # Published API docs
├── design-system/     # Published design system docs
└── README.md
```

### Monorepo Projects
```
monorepo/
├── docs/              # Shared internal docs (cross-cutting)
├── user-docs/         # Unified user documentation
├── developer-docs/    # Unified API documentation
├── design-system/     # Shared design system
├── services/
│   ├── auth-service/
│   │   └── docs/      # Service-specific internal docs
│   └── payment-service/
│       └── docs/      # Service-specific internal docs
└── packages/
    └── ui-components/
        └── docs/      # Package-specific internal docs
```

## Agent Responsibilities

### Creating Documents

**Internal Documentation (docs/):**
- system-architect → `docs/architecture/`
- technical-product-owner → `docs/product/`
- project-manager → `docs/project/`
- security-engineer → `docs/security/`
- performance-engineer → `docs/performance/`
- data-database-engineer → `docs/database/`
- devops-engineer → `docs/operations/`

**Published Documentation:**
- documentation-engineer → `user-docs/`, `developer-docs/`
- design-systems-engineer → `design-system/`

### Finding Documents

Agents should check these locations:
1. Internal docs: `docs/[category]/`
2. Published user docs: `user-docs/`
3. Published developer docs: `developer-docs/`
4. Design system docs: `design-system/`

### Maintaining Documents
- Keep published docs in sync with features
- Update API docs when endpoints change
- Mark deprecated features in published docs
- Maintain versioning for API documentation

## Document Templates

### Architecture Decision Record (ADR)
```markdown
# ADR-NNNN: [Short Title]

**Status:** [Proposed | Accepted | Deprecated | Superseded]
**Date:** YYYY-MM-DD
**Supersedes:** ADR-XXXX (if applicable)

## Context
[What is the issue we're facing?]

## Decision
[What change are we making?]

## Consequences
**Positive:**
- [Benefit 1]

**Negative:**
- [Trade-off 1]

## References
- [Links to related specs]
```

### Feature Requirements (Internal)
```markdown
# Feature: [Feature Name]

**Epic:** [Epic Name]
**Status:** [Draft | Approved | In Progress | Complete]
**Owner:** [Product Owner]

## Problem Statement
[What user problem are we solving?]

## User Stories
- As a [user], I want [goal] so that [benefit]

## Acceptance Criteria
- [ ] [Criterion 1]

## Technical Considerations
[Link to architecture specs]

## Success Metrics
- [Metric 1]
```

### User Guide (Published)
```markdown
# [Feature Name]

Learn how to [accomplish task] with [feature].

## Overview
[Brief description of what this feature does]

## Getting Started
[Step-by-step instructions]

## Common Use Cases
### [Use Case 1]
[Instructions]

## Troubleshooting
### [Common Issue 1]
[Solution]

## Related Articles
- [Link to related guide]
```

### API Guide (Published)
```markdown
# [API Feature Name]

[Brief description]

## Authentication
[How to authenticate]

## Request
\`\`\`http
POST /api/v1/resource
Content-Type: application/json

{
  "key": "value"
}
\`\`\`

## Response
\`\`\`json
{
  "id": "123",
  "status": "success"
}
\`\`\`

## Error Codes
| Code | Description |
|------|-------------|
| 400  | Bad request |

## Examples
[Code examples in multiple languages]
```

## Best Practices

### Do's
✓ Keep internal and published docs separate
✓ Version your API documentation
✓ Test code examples before publishing
✓ Use consistent formatting across published docs
✓ Include search functionality in published docs
✓ Monitor published docs for broken links
✓ Gather feedback from users on published docs

### Don'ts
✗ Don't publish internal architecture decisions
✗ Don't publish security assessments or threat models
✗ Don't mix internal and published content
✗ Don't forget to update published docs when features change
✗ Don't use internal jargon in user-facing docs

## Examples by Project Size

### Small Project
```
project/
├── docs/
│   ├── architecture/
│   │   └── decisions/
│   └── contributor/
│       └── local-setup.md
├── user-docs/
│   ├── getting-started.md
│   └── faq.md
└── developer-docs/
    └── api/
        └── reference/
            └── openapi.yaml
```

### Medium Project
```
project/
├── docs/
│   ├── architecture/
│   ├── product/
│   ├── security/
│   └── contributor/
├── user-docs/
│   ├── getting-started.md
│   ├── tutorials/
│   └── features/
├── developer-docs/
│   ├── getting-started.md
│   ├── api/
│   └── sdk/
└── design-system/
    ├── components/
    └── tokens/
```

### Large Project
Use full structure with all categories.

## Migration from Single docs/ Directory

If you currently have a single `docs/` directory, migrate like this:

```bash
# Internal docs stay in docs/
# (architecture, product, security, etc. - already correct)

# Move user-facing guides to user-docs/
mkdir -p user-docs
mv docs/guides/user/* user-docs/
mv docs/user-guide.md user-docs/

# Move API docs to developer-docs/
mkdir -p developer-docs/api
mv docs/api/ developer-docs/api/
mv docs/developer-guide.md developer-docs/

# Move design system docs
mkdir -p design-system
mv docs/design-system/* design-system/

# Contributor docs stay internal
mkdir -p docs/contributor
mv docs/guides/developer/local-setup.md docs/contributor/
mv docs/guides/developer/contributing.md docs/contributor/
```

## Version History

- **v2.0** (2025-10-08): Revised structure separating internal vs. published documentation
- **v1.0** (2025-10-08): Initial unified documentation structure
