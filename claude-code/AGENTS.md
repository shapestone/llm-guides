# Claude Code Agents Quick Reference

## Development & Implementation

### full-stack-engineer
**What it does:** Implements features end-to-end (Go backend + TypeScript/Vue frontend) with comprehensive testing
**When to use:** "Implement a new user authentication feature" or "Add a dashboard component with API integration"

### refactoring-specialist
**What it does:** Refactors code to improve structure and maintainability while preserving behavior
**When to use:** "Refactor this module to reduce complexity" or "Improve code structure without breaking existing functionality"

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

### product-strategist
**What it does:** Conducts market research, competitive analysis, and defines strategic positioning
**When to use:** "Analyze competitors for our AI code review product" or "Create go-to-market strategy for Q1 launch"

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

---

## Orchestrating Multiple Agents

For complex tasks, you can orchestrate multiple agents to work together:

### Using Workflow Commands

Pre-built workflows automate multi-agent orchestration:

**Feature Implementation:**
```
/implement-feature Add real-time notifications
```

This runs agents in sequence:
1. Analysis (parallel): system-architect, design-systems-engineer, data-database-engineer
2. Requirements: technical-product-owner
3. Implementation: full-stack-test-engineer + full-stack-engineer (loop)
4. Review: code-reviewer → performance-engineer → security-engineer
5. Verification: e2e-test-engineer
6. Documentation: documentation-engineer + project-manager

**Code Review:**
```
/full-review PR-123
```

This runs comprehensive review:
1. code-reviewer (quality)
2. security-engineer (security)
3. performance-engineer (performance)
4. e2e-test-engineer (integration)

### Manual Orchestration Examples

**Sequential (one after another):**
```
Please implement user authentication:
1. Use system-architect to design the architecture
2. Use data-database-engineer to design the schema
3. Use full-stack-engineer to implement
4. Use code-reviewer to review
```

**Parallel (at the same time):**
```
Analyze the impact of adding search functionality:
- Use system-architect for architecture analysis
- Use design-systems-engineer for UI component needs
- Use data-database-engineer for data requirements

Summarize findings after all three complete.
```

**Fan-Out/Fan-In (parallel then synthesize):**
```
Review this authentication PR:
- Use security-engineer for security review
- Use performance-engineer for performance review
- Use code-reviewer for code quality

After all reviews complete, provide a final ship/no-ship recommendation.
```

**Loop (iterative refinement):**
```
Implement the search feature:
1. Use full-stack-test-engineer to write tests
2. Use full-stack-engineer to implement
3. If tests fail, repeat steps 1-2
4. Once tests pass, use code-reviewer to review
```

### Orchestration Best Practices

✅ **Do:**
- Specify clear handoffs between agents
- Use parallel execution when agents don't depend on each other
- Define success criteria for each phase
- Plan for agent failures and iterations

❌ **Don't:**
- Assume agents can communicate directly (they can't)
- Skip manual verification steps
- Use sequential when parallel would work
- Forget to synthesize results from multiple agents

---

**Total Agents:** 15 specialized agents across development, quality, architecture, data, DevOps, product, and documentation

## See Also

- [Full Agent Documentation](README.md) - Detailed specifications and workflows
- [Installation Guide](README.md#installation) - How to install and update agents
- [Agent Orchestration Guide](workflows/agent-orchestration-guide.md) - Detailed orchestration patterns
- [Feature Workflow Guide](workflows/feature-implementation-workflow.md) - Step-by-step feature implementation
