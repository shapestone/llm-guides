---
description: [create report, modify milestones, reprioritize work, or identify next features to implement]
---

You are orchestrating the **Planning Phase** to review work, prioritize, and plan next steps.

## Preferred Output Format: Feature Roadmap (Milestones)

**IMPORTANT**: When creating feature roadmaps or multi-milestone plans, use the milestones.md template.

**FIRST - Use project-manager agent and instruct them to:**
1. Read the template file: `~/.claude/reference-documentation/projects/milestones.md`
2. Follow the template structure exactly
3. Output to: `docs/project/planning/feature-roadmap.md`

- **Template Location**: `~/.claude/reference-documentation/projects/milestones.md`
- **Output Location**: `docs/project/planning/feature-roadmap.md`

The milestones template provides:
- Visual priority, complexity, business value, and customer impact indicators
- Milestone-based organization with target dates
- Priority matrix (Must-Have, Should-Have, Nice-to-Have, Future)
- Quarterly resource allocation planning

**Use the milestones template for:**
- Multi-phase feature releases
- Product roadmaps spanning multiple sprints/quarters
- Stakeholder reporting
- Feature prioritization across milestones

---

## Planning Phase Objectives

1. **Review Current Status**
2. **Identify Remaining Work**
3. **Prioritize Features**
4. **Plan Next Implementation**

---

## Step 1: Review Current Status

**Use technical-product-owner** to:

### Assess Completed Work
- Review what has been implemented
- Check which features are in progress
- Identify what's been deployed

### Review Discovery Findings (if available)
- Check if /discovery has been run
- Review architectural decisions made
- Note any outstanding questions

### Current Backlog Analysis
- List all pending features
- Group by epic/theme
- Note dependencies between features

---

## Step 2: Identify Remaining Work

**Catalog all outstanding items:**

### Features to Implement
- [ ] Feature 1: [Description]
  - Estimated complexity: [Low/Medium/High]
  - Dependencies: [None/List]
  - Value: [Business value assessment]

- [ ] Feature 2: [Description]
  - Estimated complexity: [Low/Medium/High]
  - Dependencies: [None/List]
  - Value: [Business value assessment]

### Technical Debt
- [ ] Tech debt item 1
- [ ] Tech debt item 2

### Bug Fixes
- [ ] Bug #1: [Description and severity]
- [ ] Bug #2: [Description and severity]

### Infrastructure/DevOps Tasks
- [ ] Infrastructure item 1
- [ ] Infrastructure item 2

---

## Step 3: Prioritize Tasks

**Use technical-product-owner** to prioritize based on:

### Prioritization Criteria

1. **Business Value** (High/Medium/Low)
   - Revenue impact
   - User satisfaction
   - Strategic importance

2. **Complexity** (Low/Medium/High)
   - Development effort
   - Testing requirements
   - Risk level

3. **Dependencies**
   - Blocks other features?
   - Requires other features?
   - External dependencies?

4. **Urgency**
   - Time-sensitive?
   - Customer commitment?
   - Regulatory requirement?

### Prioritization Matrix

Create a priority matrix:

```
| Feature | Business Value | Complexity | Dependencies | Priority |
|---------|---------------|------------|--------------|----------|
| Feature A | High | Low | None | P0 (Do First) |
| Feature B | High | High | Feature A | P1 (Do Next) |
| Feature C | Medium | Low | None | P2 (Do Later) |
| Feature D | Low | High | None | P3 (Backlog) |
```

**Priority Levels:**
- **P0**: Critical - Do immediately
- **P1**: High - Do next
- **P2**: Medium - Plan for next sprint
- **P3**: Low - Backlog

---

## Step 4: Define User Stories for Top Priority Items

**For the top 2-3 priority items, create detailed user stories:**

### User Story Template

```markdown
## User Story: [Feature Name]

**As a** [type of user]
**I want** [goal/desire]
**So that** [benefit/value]

### Acceptance Criteria

1. Given [context], when [action], then [expected result]
2. Given [context], when [action], then [expected result]
3. ...

### Technical Requirements

- Backend: [What needs to be built]
- Frontend: [What needs to be built]
- Database: [Schema changes needed]
- APIs: [Endpoints needed]

### Dependencies

- Depends on: [Other features/services]
- Blocked by: [Blockers]

### Definition of Done

- [ ] Code implemented and tested
- [ ] Unit tests passing
- [ ] Integration tests passing
- [ ] E2E tests passing
- [ ] Code reviewed
- [ ] Documentation updated
- [ ] Deployed to staging
- [ ] Product owner approval

### Estimation

- Complexity: [Story points or T-shirt size]
- Estimated duration: [Days/weeks]

### Notes

[Any additional context or considerations]
```

---

## Step 5: Create Sprint/Iteration Plan

**Use project-manager** to:

### Define Sprint Goals
- Sprint duration: [1-2 weeks typical]
- Sprint goal: [What will be achieved]
- Sprint capacity: [Team capacity]

### Sprint Backlog
```
Sprint [N]: [Start Date] - [End Date]

Goal: [Sprint goal]

Committed Features:
1. [Feature A] - P0 - [Assignee] - [Est. X days]
2. [Feature B] - P1 - [Assignee] - [Est. Y days]

Stretch Goals (if capacity allows):
3. [Feature C] - P2 - [Assignee] - [Est. Z days]

Technical Debt/Maintenance:
- [Item 1]
- [Item 2]
```

### Risk Assessment
- **Risk 1**: [Description]
  - Probability: [Low/Medium/High]
  - Impact: [Low/Medium/High]
  - Mitigation: [Plan]

- **Risk 2**: [Description]
  - Probability: [Low/Medium/High]
  - Impact: [Low/Medium/High]
  - Mitigation: [Plan]

---

## Step 6: Identify Next Feature to Implement

**Select the highest priority item for immediate implementation:**

```markdown
## Next Feature: [Feature Name]

### Why This Feature?
- Priority: P0
- Business Value: [High/Medium/Low]
- Complexity: [Low/Medium/High]
- No blocking dependencies

### Ready for Implementation?
- [ ] Discovery completed (or run /discovery if needed)
- [ ] User story defined
- [ ] Acceptance criteria clear
- [ ] Technical requirements understood
- [ ] Team has capacity

### Next Steps
1. If discovery NOT done: `/discovery [feature description]`
2. If discovery IS done: `/implement [feature description]`
```

---

## Planning Phase Output

### Option 1: Feature Roadmap (Milestones) - PREFERRED

For multi-milestone planning, use the milestones.md template:

**Output to**: `docs/project/planning/feature-roadmap.md`

1. Read the template: `~/.claude/reference-documentation/projects/milestones.md`
2. Organize features by milestone with target dates
3. Use visual indicators: 🔴 Priority | ⭐ Complexity | 💰 Business Value | 👤 Customer Impact
4. Include Priority Matrix and Timeline Overview
5. Add quarterly resource allocation

### Option 2: Sprint Planning Summary (For Single Sprint)

For immediate sprint planning, create a summary document:

**Output to**: `docs/project/planning/sprint-[N]-plan.md`

```markdown
# Planning Summary: [Date]

## Current Status
- Features completed: [X]
- Features in progress: [Y]
- Features in backlog: [Z]

## Top Priorities (P0/P1)

### 1. [Feature A]
- Priority: P0
- Value: High
- Complexity: Medium
- Status: Ready for /discovery
- Rationale: [Why this is top priority]

### 2. [Feature B]
- Priority: P1
- Value: High
- Complexity: Low
- Status: Blocked by Feature A
- Rationale: [Why this is second priority]

## Sprint Plan

Sprint [N]: [Dates]
- Goal: [Sprint goal]
- Committed: [List features]
- Stretch: [List stretch goals]

## Risks and Mitigation
- [Risk 1 and mitigation]
- [Risk 2 and mitigation]

## Next Action
**Recommended:** `/discovery [Feature A description]`
or
**Recommended:** `/implement [Feature A description]` (if discovery already done)
```

---

## Planning Phase Complete Criteria

- [ ] All pending work cataloged
- [ ] Features prioritized by value and complexity
- [ ] User stories defined for top priorities
- [ ] Sprint/iteration plan created
- [ ] Risks identified and mitigation planned
- [ ] Next feature selected for implementation
- [ ] Team capacity assessed
- [ ] Stakeholders informed of plan

**Next Commands:**
```
/discovery [next feature]  # If discovery needed
or
/implement [next feature]  # If discovery already done
```
