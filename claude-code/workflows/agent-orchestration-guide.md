# Agent Orchestration Guide

A comprehensive guide to orchestrating multiple Claude Code agents for complex workflows.

## Table of Contents

- [Overview](#overview)
- [How Agent Orchestration Works](#how-agent-orchestration-works)
- [Orchestration Patterns](#orchestration-patterns)
- [Common Workflows](#common-workflows)
- [Best Practices](#best-practices)
- [Advanced Techniques](#advanced-techniques)

## Overview

Agent orchestration allows you to combine multiple specialized agents to handle complex, multi-phase development tasks. While agents cannot directly call other agents, you can orchestrate them through:

1. **Slash Commands** - Pre-defined workflows (e.g., `/implement-feature`)
2. **Explicit Instructions** - Manual agent sequencing
3. **Main Assistant Orchestration** - The main Claude Code assistant coordinates agent invocations

## How Agent Orchestration Works

### Agent Characteristics

Each agent:
- Operates in its own context window
- Is stateless (no memory between invocations)
- Returns a final report
- Has specific tools and permissions

### Orchestration Flow

```
User Request
    ↓
Main Claude Code Assistant (Orchestrator)
    ↓
Agent 1 → Returns results
    ↓
Main Assistant (processes results)
    ↓
Agent 2 → Returns results
    ↓
Main Assistant (processes results)
    ↓
... continues ...
    ↓
Final Summary to User
```

The main assistant:
- Launches agents sequentially or in parallel
- Passes context between agents
- Aggregates results
- Makes decisions about next steps

## Orchestration Patterns

### 1. Sequential Pattern

Agents run one after another, each building on previous results.

**Use when:** Later agents need results from earlier agents.

**Example:**
```
1. system-architect analyzes architecture
2. data-database-engineer designs schema (based on architecture)
3. full-stack-engineer implements (based on architecture + schema)
4. code-reviewer reviews implementation
```

**How to invoke:**
```
Please implement user authentication:
1. First use system-architect to design the architecture
2. Then use data-database-engineer to design the user schema
3. Then use full-stack-engineer to implement
4. Finally use code-reviewer to review
```

### 2. Parallel Pattern

Multiple agents work simultaneously on independent tasks.

**Use when:** Agents don't need each other's results.

**Example:**
```
Run in parallel:
- security-engineer checks for vulnerabilities
- performance-engineer profiles performance
- code-reviewer checks code quality
```

**How to invoke:**
```
Please review this PR in parallel:
- Use security-engineer for security review
- Use performance-engineer for performance analysis
- Use code-reviewer for code quality
```

### 3. Fan-Out/Fan-In Pattern

Multiple agents analyze in parallel, then results are synthesized.

**Use when:** Need multiple perspectives before making a decision.

**Example:**
```
Analysis Phase (parallel):
- system-architect → architecture impact
- design-systems-engineer → UI component needs
- data-database-engineer → data requirements

Synthesis Phase:
- Main assistant combines findings
- Makes go/no-go decision
```

**How to invoke:**
```
Analyze the impact of adding real-time notifications:
- system-architect should analyze architecture needs
- design-systems-engineer should review UI components
- data-database-engineer should assess data requirements

Then summarize findings and recommend approach.
```

### 4. Loop Pattern

Repeat agent invocations until conditions are met.

**Use when:** Iterative refinement is needed.

**Example:**
```
Loop until tests pass:
1. full-stack-test-engineer writes tests
2. full-stack-engineer implements feature
3. If tests fail → return to step 1
4. If tests pass → continue to next phase
```

**How to invoke:**
```
Implement search functionality:
1. full-stack-test-engineer writes tests
2. full-stack-engineer implements
3. Keep iterating until all tests pass
```

### 5. Pipeline Pattern

Agents form a processing pipeline with quality gates.

**Use when:** Need multiple validation steps.

**Example:**
```
Implementation → Code Review → Security → Performance → E2E Tests
     ↓              ↓             ↓           ↓            ↓
  (gate)        (gate)        (gate)      (gate)       (gate)
```

**How to invoke:**
Use `/implement-feature` or `/full-review` slash commands.

## Common Workflows

### Feature Implementation Workflow

**Phases:**
1. **Analysis** - Understand impact
2. **Planning** - Define requirements
3. **Implementation** - Build the feature
4. **Review** - Quality assurance
5. **Documentation** - Update docs

**Agents:**
```
Analysis (parallel):
  - system-architect
  - design-systems-engineer
  - data-database-engineer

Planning:
  - technical-product-owner

Implementation (loop):
  - full-stack-test-engineer
  - full-stack-engineer

E2E Testing:
  - e2e-test-engineer

Review (sequential):
  - code-reviewer
  - performance-engineer
  - security-engineer

Verification:
  - e2e-test-engineer

Documentation (parallel):
  - documentation-engineer
  - project-manager
```

**Invoke with:**
```
/implement-feature Add user profile editing
```

### Code Review Workflow

**Phases:**
1. Code quality review
2. Security analysis
3. Performance analysis
4. Integration verification
5. Final recommendation

**Agents:**
```
Sequential:
  - code-reviewer
  - security-engineer
  - performance-engineer
  - e2e-test-engineer
```

**Invoke with:**
```
/full-review PR-123
```

### Bug Fix Workflow

**Phases:**
1. Reproduction and analysis
2. Root cause identification
3. Fix implementation
4. Regression testing
5. Review

**Agents:**
```
Analysis:
  - e2e-test-engineer (reproduce bug)
  - system-architect (if architectural issue)

Implementation:
  - full-stack-engineer

Testing:
  - e2e-test-engineer (verify fix + no regressions)

Review:
  - code-reviewer
```

**Invoke with:**
```
Please fix bug #456:
1. Use e2e-test-engineer to reproduce the bug
2. Use full-stack-engineer to implement the fix
3. Use e2e-test-engineer to verify fix and check for regressions
4. Use code-reviewer to review the fix
```

### Refactoring Workflow

**Phases:**
1. Code analysis
2. Refactoring plan
3. Implementation
4. Verification

**Agents:**
```
Analysis:
  - refactoring-specialist

Implementation:
  - refactoring-specialist (makes changes)

Testing:
  - full-stack-test-engineer (verify no behavior changes)

Review:
  - code-reviewer
  - performance-engineer (verify performance maintained/improved)
```

**Invoke with:**
```
Refactor the authentication module:
1. Use refactoring-specialist to analyze and propose improvements
2. Use refactoring-specialist to implement changes
3. Use full-stack-test-engineer to verify no behavior changes
4. Use code-reviewer and performance-engineer to review
```

### Security Audit Workflow

**Phases:**
1. Automated security scan
2. Manual security review
3. Remediation
4. Verification

**Agents:**
```
Audit (parallel):
  - security-engineer (comprehensive scan)
  - code-reviewer (security-focused review)

Remediation:
  - full-stack-engineer (fix issues)

Verification:
  - security-engineer (verify fixes)
  - e2e-test-engineer (ensure no breakage)
```

**Invoke with:**
```
Perform security audit on authentication system:
1. Use security-engineer for comprehensive security review
2. Use code-reviewer to review auth code specifically
3. If issues found, use full-stack-engineer to fix them
4. Use security-engineer to verify fixes
5. Use e2e-test-engineer to ensure auth still works
```

## Best Practices

### 1. Clear Agent Handoffs

When passing work between agents, be explicit:

**Good:**
```
First use system-architect to analyze the caching strategy.
Based on the architect's recommendations, use full-stack-engineer
to implement the chosen approach.
```

**Bad:**
```
Implement caching. Use multiple agents.
```

### 2. Define Success Criteria

Specify what "done" means for each phase:

**Good:**
```
Use full-stack-engineer to implement login.
Success criteria:
- All tests pass
- Application builds without errors
- Feature works in running application
- User can log in and log out successfully
```

**Bad:**
```
Use full-stack-engineer to implement login.
```

### 3. Handle Agent Failures

Plan for what happens if an agent identifies issues:

**Good:**
```
Use security-engineer to review auth code.
If critical issues found:
  - Use full-stack-engineer to fix them
  - Use security-engineer again to verify fixes
If no issues, proceed to performance review.
```

**Bad:**
```
Use security-engineer to review auth code, then continue.
```

### 4. Aggregate Results

Synthesize findings from multiple agents:

**Good:**
```
After all three agents complete:
- Summarize architectural decisions
- List all required schema changes
- Identify UI components needed
- Create implementation plan based on all findings
```

**Bad:**
```
Run three agents and move on.
```

### 5. Use Parallel Execution When Possible

Launch independent agents in parallel for efficiency:

**Good:**
```
In parallel:
- Use security-engineer for security review
- Use performance-engineer for performance review
- Use code-reviewer for code quality review
```

**Bad:**
```
Use security-engineer, then performance-engineer, then code-reviewer.
(Sequential when they could be parallel)
```

## Advanced Techniques

### Conditional Branching

Different agent paths based on findings:

```
1. Use system-architect to evaluate approach
2. If architect recommends microservices:
     - Use devops-engineer to plan infrastructure
   If architect recommends monolith:
     - Use data-database-engineer to optimize schema
3. Proceed with implementation
```

### Nested Workflows

Workflows within workflows:

```
For each feature in the epic:
  1. Run /implement-feature workflow
  2. Use project-manager to update epic status
  3. Continue to next feature
```

### Quality Gates

Require agent approval to proceed:

```
1. Use full-stack-engineer to implement
2. Use code-reviewer to review
   - If approved: continue
   - If changes requested: return to step 1
3. Use security-engineer to review
   - If approved: continue
   - If issues found: return to step 1
4. Ship to production
```

### Agent Result Caching

Reuse agent results across phases:

```
1. system-architect analyzes architecture (save results)
2. Multiple features implemented based on same architecture
3. No need to re-run architect for each feature
```

### Progressive Enhancement

Start simple, add complexity as needed:

```
Phase 1: Basic implementation
  - full-stack-engineer

Phase 2: If performance issues found
  - performance-engineer analyzes
  - full-stack-engineer optimizes

Phase 3: If security concerns arise
  - security-engineer reviews
  - full-stack-engineer hardens
```

## Troubleshooting

### Agent Returns Incomplete Results

**Issue:** Agent didn't complete the full task.

**Solution:** Provide more specific instructions with clear success criteria.

### Agents Contradict Each Other

**Issue:** Different agents recommend different approaches.

**Solution:** Use main assistant to synthesize findings and make a decision, or escalate to user for input.

### Too Much Context Needed

**Issue:** Agent needs more context than can be provided.

**Solution:** Break the task into smaller chunks, or have agent read specific files first.

### Wrong Agent Selected

**Issue:** Claude Code chose the wrong agent automatically.

**Solution:** Explicitly specify which agent to use in your request.

## Related Documentation

- [Feature Implementation Workflow](feature-implementation-workflow.md) - Detailed feature workflow
- [Agent Descriptions](../AGENTS.md) - Quick reference for all agents
- [Slash Commands](../commands/) - Pre-built workflow commands

---

**Next Steps:**
- Try the `/implement-feature` command for your next feature
- Experiment with parallel agent execution
- Create custom slash commands for your team's specific workflows
