# Claude Code Agents Quick Reference

## Development & Implementation

### full-stack-engineer
**What it does:** Implements features end-to-end (Go backend + TypeScript/Vue frontend) with comprehensive testing
**When to use:** "Implement a new user authentication feature" or "Add a dashboard component with API integration"

### refactoring-specialist
**What it does:** Analyzes code and proposes refactoring improvements (does NOT implement)
**When to use:** "Analyze this module for refactoring opportunities" or "Suggest improvements to reduce technical debt"

## Quality Assurance & Testing

### code-reviewer
**What it does:** Reviews code for quality, standards, security, and best practices
**When to use:** "Review this pull request" or "Check if this code follows our standards"

### full-stack-test-engineer
**What it does:** Writes feature-level tests (unit + integration + Playwright E2E)
**When to use:** "Write tests for the user registration feature" or "Add test coverage for the payment flow"

### e2e-test-engineer
**What it does:** Validates entire product health and makes ship/no-ship recommendations
**When to use:** "Run full test suite and verify product readiness" or "Test the complete user workflow"

### security-engineer
**What it does:** Identifies security vulnerabilities and provides remediation recommendations
**When to use:** "Security review this authentication code" or "Check for OWASP Top 10 vulnerabilities"

### performance-engineer
**What it does:** Analyzes performance and provides optimization recommendations
**When to use:** "Profile this API endpoint" or "Find performance bottlenecks in the dashboard"

## Architecture & Design

### system-architect
**What it does:** Defines system architecture and makes technology decisions
**When to use:** "Design the architecture for a multi-tenant system" or "Choose database for high-volume analytics"

### design-systems-engineer
**What it does:** Builds reusable Vue component library and design system
**When to use:** "Create a reusable button component" or "Build a design system dropdown"

## Data

### data-database-engineer
**What it does:** Manages databases, schemas, and data pipelines
**When to use:** "Design schema for user permissions" or "Optimize this slow query"

## DevOps & Infrastructure

### devops-engineer
**What it does:** Builds CI/CD pipelines and manages infrastructure
**When to use:** "Set up GitHub Actions for deployment" or "Configure staging environment"

## Product & Requirements

### technical-product-owner
**What it does:** Defines requirements and manages product backlog
**When to use:** "Write user stories for checkout flow" or "Define acceptance criteria for search feature"

### project-manager
**What it does:** Coordinates project delivery and removes blockers
**When to use:** "Create project plan for Q4 features" or "Track progress on authentication epic"

## Documentation

### documentation-engineer
**What it does:** Creates and maintains technical documentation
**When to use:** "Document this API" or "Create architecture diagrams for the system"

---

## How to Use Agents

Agents are invoked automatically by Claude Code based on your request. Simply ask naturally:

- "Implement a login feature" → Invokes `full-stack-engineer`
- "Review this code" → Invokes `code-reviewer`
- "Add tests for this feature" → Invokes `full-stack-test-engineer`
- "Check for security issues" → Invokes `security-engineer`

You can also be explicit: "Use the system-architect agent to design..."

## See Also

- [Full Agent Documentation](README.md) - Detailed specifications and workflows
- [Installation Guide](README.md#installation) - How to install and update agents
