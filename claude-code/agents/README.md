# Software Development Agent Specifications

This directory contains specialized agent role specifications for end-to-end software development using Claude Code.

## Purpose

Each agent has:
- **Clear responsibilities** - What the agent does and doesn't do
- **Standard workflows** - Step-by-step checklists to follow
- **Common pitfalls** - What agents typically forget or skip
- **Exit criteria** - When work is truly complete
- **Reference documentation** - Technology guides to follow

## Directory Structure

```
agents/
├── development/         # Code implementation roles
│   ├── full-stack-engineer.md
│   └── refactoring-specialist.md
├── quality/            # Testing and QA roles
│   ├── code-reviewer.md
│   ├── full-stack-test-engineer.md
│   ├── e2e-test-engineer.md
│   ├── security-engineer.md
│   └── performance-engineer.md
├── architecture/       # System design roles
│   ├── system-architect.md
│   └── design-systems-engineer.md
├── data/              # Data and database roles
│   └── data-database-engineer.md
├── devops/            # Infrastructure roles
│   └── devops-engineer.md
├── product/           # Product and project management
│   ├── technical-product-owner.md
│   └── project-manager.md
└── documentation/     # Documentation roles
    └── documentation-engineer.md
```

## Agent Roles (14 Total)

### Development & Implementation
- **Full Stack Engineer** - Implements features end-to-end (Go + TypeScript/Vue)
- **Refactoring Specialist** - Analyzes code and proposes improvements

### Quality Assurance & Testing
- **Code Reviewer** - Reviews code for quality and standards
- **Full Stack Test Engineer** - Writes feature-level tests
- **E2E Test Engineer** - Validates entire product health
- **Security Engineer** - Identifies and mitigates security vulnerabilities
- **Performance Engineer** - Optimizes application performance

### Architecture & Design
- **System Architect** - Defines system architecture and technology decisions
- **Design Systems Engineer** - Builds reusable UI component library

### Data
- **Data & Database Engineer** - Manages databases, schemas, and data pipelines

### DevOps & Infrastructure
- **DevOps Engineer** - Builds CI/CD pipelines and manages infrastructure

### Product & Requirements
- **Technical Product Owner** - Defines requirements and manages backlog
- **Project Manager** - Coordinates delivery and removes blockers

### Documentation
- **Documentation Engineer** - Creates and maintains technical documentation

## How to Use These Specs

When working with Claude Code:

1. **Reference the appropriate agent** for the task at hand
2. **Follow the Standard Workflow** step-by-step - don't skip steps
3. **Check Common Pitfalls** to avoid typical mistakes
4. **Verify Exit Criteria** before considering work complete
5. **Consult Reference Documentation** for technology-specific patterns

## Key Principles

- **Separation of Concerns**: Each agent has clear boundaries (e.g., Refactoring Specialist proposes, Full Stack Engineer implements)
- **Complete Workflows**: Agents follow comprehensive checklists (e.g., Full Stack Engineer builds entire app, not just the feature)
- **Quality Gates**: Exit criteria ensure work is done thoroughly, not just "done"
- **Idiomatic Practices**: Agents reference technology-specific guides (Go, Vue, etc.)

## Technology Stack

These agents are configured for:
- **Backend**: Go
- **Frontend**: TypeScript, Vue.js, Tailwind CSS
- **Database**: PostgreSQL/MySQL
- **Testing**: Go testing, Vitest/Jest, Playwright

## Future Extensions

For mobile development:
- iOS: Swift agents (to be added)
- Android: Kotlin agents (to be added)

---

**Source**: These specifications are derived from `drafts/agents-spec.md`
