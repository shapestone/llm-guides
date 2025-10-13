# Feature Implementation Workflow

A detailed, step-by-step guide for implementing features using the multi-agent workflow.

## Overview

This workflow orchestrates multiple specialized agents through distinct phases to ensure high-quality feature delivery. Each phase has specific objectives, success criteria, and agent responsibilities.

## Quick Start

```bash
# Use the pre-built slash command
/implement-feature Add real-time notifications for user mentions
```

Or manually orchestrate agents following the phases below.

## Workflow Phases

### Phase 1: Analysis & Architecture

**Objective:** Understand the full impact of the feature across architecture, design, and data layers.

**Agents (Run in Parallel):**

#### 1. System Architect
**Responsibility:** Analyze architectural impact

**Deliverables:**
- Architectural decisions and trade-offs
- Technology choices (WebSockets, Redis, etc.)
- System design considerations
- Scalability implications
- Integration points with existing systems

**Example Prompt:**
```
Use system-architect to analyze the architectural impact of adding
real-time notifications for user mentions. Consider:
- How notifications will be delivered (WebSockets, SSE, polling?)
- Where notification state should be stored
- How this integrates with existing systems
- Scalability concerns for high-volume users
```

#### 2. Design Systems Engineer
**Responsibility:** Review UI/UX component needs

**Deliverables:**
- List of UI components needed
- Design system consistency check
- Component architecture plan
- Accessibility considerations
- Responsive design requirements

**Example Prompt:**
```
Use design-systems-engineer to review UI component needs for
real-time notifications. Consider:
- Toast/notification component design
- Notification center/dropdown component
- Badge indicators for unread counts
- Settings panel for notification preferences
- Integration with existing design system
```

#### 3. Data/Database Engineer
**Responsibility:** Assess data and schema requirements

**Deliverables:**
- Database schema changes
- Migration plan
- Query optimization strategies
- Data retention policies
- Index requirements

**Example Prompt:**
```
Use data-database-engineer to assess data requirements for
real-time notifications. Consider:
- Notification storage schema
- User preferences schema
- Indexing strategy for fast queries
- Data retention and archiving
- Read/write patterns and optimization
```

**Phase 1 Success Criteria:**
- [ ] Architecture approach decided
- [ ] UI components identified
- [ ] Database schema designed
- [ ] All three perspectives synthesized into coherent plan

### Phase 2: Requirements Definition

**Objective:** Create clear, testable requirements based on analysis findings.

**Agent:** Technical Product Owner

**Deliverables:**
- User stories with acceptance criteria
- Edge cases identified
- Non-functional requirements
- Success metrics

**Example Prompt:**
```
Use technical-product-owner to define requirements for real-time
notifications based on these findings:
[Paste architecture, design, and data findings]

Create user stories with acceptance criteria covering:
- User receives notification when mentioned
- User can view notification history
- User can configure notification preferences
- User can mark notifications as read
```

**Phase 2 Success Criteria:**
- [ ] User stories written with clear acceptance criteria
- [ ] Edge cases documented
- [ ] Success metrics defined
- [ ] Requirements ready for implementation

### Phase 3: Implementation Loop

**Objective:** Implement the feature using Test-Driven Development.

**Iteration Process:**

#### Iteration N: Test → Implement → Verify

##### Step 1: Write Tests (Test Engineer)

**Agent:** full-stack-test-engineer

**Deliverables:**
- Unit tests for new functionality
- Integration tests for component interactions
- E2E test scenarios (planned, not yet implemented)

**Example Prompt:**
```
Use full-stack-test-engineer to write tests for user mention
notifications. Include:

Unit tests:
- NotificationService.createNotification()
- NotificationService.markAsRead()
- NotificationPreferences validation

Integration tests:
- Mention detected → notification created
- User fetches unread notifications
- WebSocket notification delivery

E2E test scenarios:
- Plan tests for: user mentions another user, receiver gets
  real-time notification, notification appears in UI
```

##### Step 2: Implement Feature (Full-Stack Engineer)

**Agent:** full-stack-engineer

**Deliverables:**
- Backend implementation (Go)
- Frontend implementation (TypeScript/Vue)
- All tests passing
- Application builds successfully
- Services restarted with new code
- Feature verified working in running application

**Example Prompt:**
```
Use full-stack-engineer to implement real-time notifications.

Based on the requirements and tests, implement:

Backend (Go):
- NotificationService with methods from tests
- WebSocket notification handler
- Database queries and mutations
- API endpoints: GET /notifications, POST /notifications/:id/read

Frontend (TypeScript/Vue):
- NotificationCenter component
- WebSocket connection service
- Notification state management (Pinia)
- Toast notification component
- Integration with mention detection

Success criteria:
- All unit tests pass
- All integration tests pass
- Full application builds without errors
- Services restarted
- Can send and receive notifications in running app
- Manually verified feature works as expected
```

##### Step 3: Verify Implementation

**Check:**
- [ ] All unit tests pass
- [ ] All integration tests pass
- [ ] Application builds successfully
- [ ] Services restarted
- [ ] Feature works in running application
- [ ] No TypeScript/linting errors

**If any check fails:** Return to Step 1 or Step 2 as needed.

**If all checks pass:** Exit loop, proceed to Phase 4.

**Phase 3 Success Criteria:**
- [ ] Feature fully implemented
- [ ] All tests passing
- [ ] Application builds and runs
- [ ] Feature manually verified working
- [ ] Code follows project standards

### Phase 4: E2E Testing

**Objective:** Validate complete user workflows with end-to-end tests.

**Agent:** e2e-test-engineer

**Deliverables:**
- Playwright E2E tests for full workflows
- Cross-browser test results
- Integration test results
- Regression test results

**Example Prompt:**
```
Use e2e-test-engineer to write and run E2E tests for notifications.

Test scenarios:
1. User A mentions User B in a comment
   - Verify User B receives real-time notification
   - Verify notification appears in UI
   - Verify badge count updates

2. User views notification center
   - Verify all unread notifications shown
   - Verify marking as read works
   - Verify badge count decreases

3. User configures notification preferences
   - Verify preferences saved
   - Verify notifications respect preferences

Also verify:
- No regressions in existing features
- Cross-browser compatibility (Chrome, Firefox, Safari)
```

**Phase 4 Success Criteria:**
- [ ] All E2E tests pass
- [ ] No regressions detected
- [ ] Cross-browser compatibility verified

### Phase 5: Code Review & Quality Assurance

**Objective:** Comprehensive review for quality, performance, and security.

#### Step 1: Code Review

**Agent:** code-reviewer

**Deliverables:**
- Code quality assessment
- Standards compliance check
- Test coverage analysis
- Refactoring recommendations

**Example Prompt:**
```
Use code-reviewer to review the notification feature implementation.

Review:
- Go code for idiomatic patterns
- Vue/TypeScript code for best practices
- Test coverage adequacy
- Error handling
- Code organization and maintainability
- Documentation completeness

Provide specific, actionable feedback.
```

**Decision Point:**
- **If issues found:** Return to Phase 3 (Implementation Loop)
- **If approved:** Continue to Step 2

#### Step 2: Performance Review

**Agent:** performance-engineer

**Deliverables:**
- Performance analysis
- Bottleneck identification
- Optimization recommendations
- Load test results

**Example Prompt:**
```
Use performance-engineer to analyze notification feature performance.

Analyze:
- Database query performance (notification fetching)
- WebSocket connection overhead
- Frontend rendering performance
- Memory usage patterns
- API endpoint response times

Test scenarios:
- User with 1,000+ notifications
- 100 concurrent WebSocket connections
- High-frequency mention notifications

Provide optimization recommendations if needed.
```

**Decision Point:**
- **If critical issues found:** Return to Phase 3 (Implementation Loop)
- **If acceptable:** Continue to Step 3

#### Step 3: Security Review

**Agent:** security-engineer

**Deliverables:**
- Security vulnerability assessment
- OWASP Top 10 check
- Authorization verification
- Input validation review

**Example Prompt:**
```
Use security-engineer to perform security review of notifications.

Check for:
- Authorization: Can users only see their own notifications?
- Input validation: Mention parsing, notification content
- XSS vulnerabilities in notification rendering
- WebSocket security (authentication, authorization)
- SQL injection in notification queries
- Sensitive data exposure
- CSRF protection on API endpoints

Flag any critical vulnerabilities immediately.
```

**Decision Point:**
- **If critical vulnerabilities found:** Return to Phase 3 (Implementation Loop)
- **If secure:** Continue to Phase 6

**Phase 5 Success Criteria:**
- [ ] Code review passed or issues resolved
- [ ] Performance acceptable or optimized
- [ ] No critical security vulnerabilities
- [ ] All feedback addressed

### Phase 6: Final System Verification

**Objective:** Verify entire system integrity and make ship/no-ship recommendation.

**Agent:** e2e-test-engineer

**Deliverables:**
- Full test suite results
- System integrity verification
- Regression test results
- Ship/no-ship recommendation

**Example Prompt:**
```
Use e2e-test-engineer to perform final system verification.

Run:
- Complete E2E test suite (all features, not just notifications)
- Regression tests for critical workflows
- Smoke tests for main user journeys

Verify:
- All tests pass
- No new failures introduced
- System stability maintained
- Feature integrates cleanly

Provide ship/no-ship recommendation.
```

**Phase 6 Success Criteria:**
- [ ] Full test suite passes
- [ ] No regressions
- [ ] System integrity verified
- [ ] Ship recommendation received

### Phase 7: Documentation & Project Management

**Objective:** Update documentation and finalize project tracking.

**Agents (Run in Parallel):**

#### Documentation Engineer

**Deliverables:**
- API documentation updates
- Architecture documentation updates
- User guide updates
- Code comment review

**Example Prompt:**
```
Use documentation-engineer to update documentation for notifications.

Update:
- API docs: New /notifications endpoints
- Architecture docs: WebSocket notification flow diagram
- User guide: How to use notifications and configure preferences
- Developer docs: How to trigger notifications programmatically

Ensure all documentation is current and accurate.
```

#### Project Manager

**Deliverables:**
- Project status update
- Stakeholder notification
- Sprint/backlog updates
- Metrics and reporting

**Example Prompt:**
```
Use project-manager to finalize project tracking for notifications.

Tasks:
- Update ticket status to "Done"
- Document completion metrics (time, effort, LOC)
- Notify stakeholders of feature completion
- Update sprint burndown
- Document lessons learned
```

**Phase 7 Success Criteria:**
- [ ] All documentation updated
- [ ] Project tracking current
- [ ] Stakeholders notified
- [ ] Feature marked complete

## Summary Report Template

After completing all phases, compile a comprehensive summary:

```markdown
# Feature Implementation Summary: [Feature Name]

## Feature Overview
- **Feature**: [Description]
- **Status**: ✅ Ready for Deployment / ⚠️ Needs Additional Work
- **Implementation Time**: [Hours/Days]

## Phase 1: Analysis Findings

### Architecture
- **Approach**: [Architecture decision]
- **Key Technologies**: [List]
- **Trade-offs**: [Decisions made]

### Design
- **Components Created**: [List]
- **Design System Updates**: [Changes]

### Data
- **Schema Changes**: [Tables/fields added]
- **Migrations**: [Migration plan]
- **Indexes**: [Indexes created]

## Phase 2: Requirements
- **User Stories**: [Count]
- **Acceptance Criteria**: [Key criteria]

## Phase 3: Implementation
- **Backend Changes**: [Files modified, LOC added]
- **Frontend Changes**: [Components created, LOC added]
- **Tests Written**: [Unit: X, Integration: Y]
- **Iterations**: [Number of implementation loops]

## Phase 4: E2E Testing
- **Tests Written**: [Count]
- **Test Results**: [X/Y passing]
- **Browsers Tested**: [Chrome, Firefox, Safari]

## Phase 5: Review Results

### Code Review
- **Status**: ✅ Approved / ⚠️ Changes Requested
- **Issues Found**: [Count and severity]
- **All Resolved**: [Yes/No]

### Performance
- **Status**: ✅ Acceptable / ⚠️ Needs Optimization
- **Key Metrics**: [Response times, throughput]
- **Optimizations Made**: [List]

### Security
- **Status**: ✅ Secure / ⚠️ Vulnerabilities Found
- **Vulnerabilities**: [None / List]
- **All Mitigated**: [Yes/No]

## Phase 6: System Verification
- **Full Test Suite**: [X/Y tests passing]
- **Regressions**: [None / List]
- **Ship Recommendation**: ✅ Ship / ⚠️ Do Not Ship

## Phase 7: Documentation
- **API Docs**: ✅ Updated
- **Architecture Docs**: ✅ Updated
- **User Guides**: ✅ Updated
- **Project Tracking**: ✅ Updated

## Next Steps
- [ ] Deploy to staging
- [ ] Final QA in staging
- [ ] Deploy to production
- [ ] Monitor metrics
```

## Workflow Variations

### Simplified Workflow (Small Features)

For small, low-risk features, you can simplify:

```
1. Skip Phase 1 (Analysis) for trivial changes
2. Combine Phases 2 & 3 (Requirements + Implementation)
3. Skip Phase 4 if unit/integration tests are sufficient
4. Combine Phase 5 reviews (single review pass)
5. Light documentation updates
```

### Extended Workflow (Large Features/Epics)

For large features, extend the workflow:

```
1. Add Phase 0: Discovery & Research (product-strategist)
2. Break into smaller features
3. Run workflow for each feature
4. Add Phase 8: Production Monitoring (devops-engineer)
```

### Bug Fix Workflow

Adapt for bug fixes:

```
1. Phase 1: Bug Reproduction (e2e-test-engineer)
2. Phase 2: Root Cause Analysis (system-architect if needed)
3. Phase 3: Fix Implementation (full-stack-engineer)
4. Phase 4: Regression Testing (e2e-test-engineer)
5. Phase 5: Code Review (code-reviewer)
```

## Best Practices

### Do's
✅ Always run analysis in parallel to save time
✅ Be prepared to iterate in Phase 3
✅ Don't skip security review for user-facing features
✅ Keep stakeholders informed via project-manager
✅ Document as you go, not at the end

### Don'ts
❌ Don't skip phases to "save time" - it costs more later
❌ Don't proceed if quality gates fail
❌ Don't skip manual verification in Phase 3
❌ Don't ignore performance issues "for later"
❌ Don't deploy without final system verification

## Customization

This workflow is a template. Customize for your team:

1. **Adjust agent selection** based on your stack
2. **Add/remove phases** based on project complexity
3. **Modify quality gates** based on risk tolerance
4. **Extend documentation** based on your standards
5. **Add custom checks** for your domain (e.g., compliance)

## Related Documentation

- [Agent Orchestration Guide](agent-orchestration-guide.md) - Orchestration patterns and best practices
- [Slash Commands](../commands/) - Pre-built workflow commands
- [Agent Reference](../AGENTS.md) - Individual agent capabilities

---

**Ready to start?**
```
/implement-feature Your feature description here
```
