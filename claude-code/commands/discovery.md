---
argument-hint: [feature description]
description: Phase 1 - Architectural discovery with analysis of architecture, UI, and database impact
---

You are orchestrating **Phase 1: Discovery** for: $ARGUMENTS

This phase analyzes the feature from three perspectives to build a comprehensive understanding before implementation.

## Phase 1: Discovery (Run in Parallel)

Launch all three agents in parallel for maximum efficiency:

### 1. System Architect - Architectural Analysis

**Use system-architect** to:
- Use interactive questionnaire-style discovery
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

### 2. Design Systems Engineer - UI/Component Analysis

**Use design-systems-engineer** to:
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

### 3. Data/Database Engineer - Data Analysis

**Use data-database-engineer** to:
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

## After All Three Agents Complete

### Synthesis Phase

**Consolidate findings from all three perspectives:**

1. **Architectural Foundation**
   - Summary of key architectural decisions
   - Technology stack selected
   - Integration approach

2. **UI/UX Requirements**
   - Components to build
   - Design patterns to follow
   - User experience flows

3. **Data Strategy**
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
- Ready for /planning phase
- Outstanding questions: [Any unresolved items]
```

---

## Discovery Phase Complete Criteria

Before proceeding to /planning:

- [ ] All architectural decisions made and documented
- [ ] UI components identified and specified
- [ ] Database schema designed
- [ ] Integration points defined
- [ ] Security considerations addressed
- [ ] Performance implications understood
- [ ] All three agents' findings synthesized
- [ ] No major conflicts between perspectives
- [ ] User has approved the overall approach

**Output:**
Provide the complete Discovery Summary document and confirm readiness for /planning phase.

**Next Command:**
```
/planning
```
