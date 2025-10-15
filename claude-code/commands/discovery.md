---
argument-hint: [feature description]
description: [feature or architectural change]
---

You are orchestrating **Discovery** for: $ARGUMENTS

This command uses a sequential approach to understand requirements, then analyze architecture, UI, and data needs.

## Discovery - Sequential Process

**CRITICAL: Run these steps IN ORDER. Do NOT run agents in parallel.**

---

## Step 1: System Architect - Requirements Gathering & Architecture

**FIRST**, use **system-architect** to understand what the user wants:

### Requirements Phase (Interactive Q&A):

**The system-architect will:**
1. Ask clarifying questions ONE AT A TIME with multiple choice options (A, B, C, D)
2. Understand the problem scope and requirements
3. Identify constraints and success criteria
4. Wait for your response before proceeding to next question
5. Continue until the problem is fully understood

**Do NOT let system-architect analyze code or make decisions until requirements are clear.**

### Architecture Phase (After Requirements Understood):

**Then, system-architect will:**
- Analyze current codebase architecture
- Identify architectural decision points
- Present options (A/B/C/D) with tradeoffs for EACH decision
- Ask ONE question at a time and wait for user response
- Build up complete architectural specification
- Document all decisions with justifications

**Deliverables:**
- Architectural decisions with rationale
- System design and component interactions
- Technology stack choices with justification
- API contracts and integration points
- Architecture Decision Records (ADRs)
- Architecture diagrams

**Example Decision Flow:**
```
Decision Point 1: Authentication Strategy
- Option A: JWT with Refresh Tokens
- Option B: Session-Based with Redis
- Option C: OAuth 2.0 / OIDC
[Wait for user choice]

Decision Point 2: API Design
- Option A: REST
- Option B: GraphQL
- Option C: gRPC
[Wait for user choice]

... continue for all decision points
```

---

## Step 2: Design Systems Engineer - UI/Component Analysis (OPTIONAL)

**ONLY AFTER system-architect completes**, if UI components are needed, use **design-systems-engineer** to:
- Analyze UI requirements for "$ARGUMENTS"
- Identify components needed (new vs reusable)
- Check design system consistency
- Plan component architecture
- Assess responsive design needs
- Review accessibility requirements
- Document component specifications

**Deliverables:**
- List of UI components required
- Component hierarchy and relationships
- Design system updates needed
- Wireframes or mockups (if needed)
- Accessibility checklist
- Responsive breakpoint considerations

---

## Step 3: Data/Database Engineer - Data Analysis (OPTIONAL)

**ONLY AFTER system-architect completes**, if database changes are needed, use **data-database-engineer** to:
- Analyze data requirements for "$ARGUMENTS"
- Design database schema changes
- Plan data migrations
- Identify indexing strategy
- Assess query patterns (read/write ratios)
- Plan data retention and archiving
- Review data security requirements

**Deliverables:**
- Database schema design
- Migration scripts (plan)
- Index recommendations
- Query optimization strategy
- Data flow diagrams
- Backup and recovery considerations

---

## After All Agents Complete

### Synthesis Phase

**Consolidate findings from all agents that were run:**

1. **Architectural Foundation** (from system-architect)
   - Summary of key architectural decisions
   - Technology stack selected
   - Integration approach

2. **UI/UX Requirements** (if design-systems-engineer was run)
   - Components to build
   - Design patterns to follow
   - User experience flows

3. **Data Strategy** (if data-database-engineer was run)
   - Schema changes summary
   - Performance considerations
   - Data integrity approach

### Identify Conflicts and Dependencies

- Do architectural choices support UI needs?
- Does data design align with architecture?
- Are there performance concerns across layers?
- Any security implications to address?

### Create Discovery Summary Document

```markdown
# Discovery Summary: [Feature Name]

## Overview
[Brief description of feature and discovery approach]

## Architectural Decisions

### Decision 1: [Topic]
- **Chosen Option**: [A/B/C]
- **Rationale**: [Why this choice]
- **Implications**: [What this means for implementation]

### Decision 2: [Topic]
- **Chosen Option**: [A/B/C]
- **Rationale**: [Why this choice]
- **Implications**: [What this means for implementation]

[... all decisions ...]

## UI/Component Requirements

### New Components
- [Component 1]: [Description and purpose]
- [Component 2]: [Description and purpose]

### Existing Components to Modify
- [Component X]: [Changes needed]

### Component Dependencies
- [How components relate]

## Data/Schema Design

### Schema Changes
```sql
-- New tables
CREATE TABLE ...

-- Modified tables
ALTER TABLE ...

-- Indexes
CREATE INDEX ...
```

### Migration Plan
1. [Step 1]
2. [Step 2]

### Query Patterns
- [Read pattern 1]
- [Write pattern 2]

## Integration Points

### Backend APIs
- `POST /api/...` - [Purpose]
- `GET /api/...` - [Purpose]

### Frontend ↔ Backend
- [Data flow description]

### Database ↔ Backend
- [Access patterns]

## Security Considerations
- [Security item 1]
- [Security item 2]

## Performance Considerations
- [Performance item 1]
- [Performance item 2]

## Dependencies and Risks
- **Dependencies**: [External dependencies]
- **Risks**: [Potential risks identified]
- **Mitigation**: [How to address risks]

## Next Steps
- Ready for /planning
- Outstanding questions: [Any unresolved items]
```

---

## Discovery Complete Criteria

Before proceeding to /planning:

- [ ] System architect has completed requirements gathering
- [ ] All architectural decisions made and documented
- [ ] UI components identified and specified (if applicable)
- [ ] Database schema designed (if applicable)
- [ ] Integration points defined
- [ ] Security considerations addressed
- [ ] Performance implications understood
- [ ] All agent findings synthesized
- [ ] No major conflicts between perspectives
- [ ] User has approved the overall approach

**Note:** UI and data analysis are optional based on the feature requirements.

**Output:**
Provide the complete Discovery Summary document and confirm readiness for /planning.

**Next Command:**
```
/planning
```
