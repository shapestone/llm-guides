---
argument-hint: [feature description]
description: Phase 2 - Implementation loop with TDD: write tests, implement feature, review code
---

You are orchestrating **Phase 2: Implementation Loop** for: $ARGUMENTS

This phase follows Test-Driven Development (TDD) and iterates until the feature is complete and code-reviewed.

## Phase 2: Implementation Loop

**Iterate until feature is complete and passes code review:**

---

### Step 1: Write Tests First (TDD Approach)

**Use full-stack-test-engineer** to:

#### Write Unit Tests
- Test individual functions and methods
- Cover happy path scenarios
- Cover edge cases and error conditions
- Test boundary conditions
- Mock external dependencies

**Backend (Go) Tests:**
```go
// Example: service_test.go
func TestNotificationService_Create(t *testing.T) {
    // Arrange
    service := NewNotificationService()

    // Act
    result, err := service.Create(...)

    // Assert
    assert.NoError(t, err)
    assert.NotNil(t, result)
}
```

**Frontend (TypeScript/Vue) Tests:**
```typescript
// Example: NotificationCenter.spec.ts
describe('NotificationCenter', () => {
  it('displays unread notifications', () => {
    // Arrange
    const wrapper = mount(NotificationCenter, { ... })

    // Act
    // ...

    // Assert
    expect(wrapper.find('.unread-count').text()).toBe('3')
  })
})
```

#### Write Integration Tests
- Test component interactions
- Test API endpoints with database
- Test service layer integration
- Test error propagation

**Integration Test Example:**
```go
func TestNotificationFlow_Integration(t *testing.T) {
    // Arrange: Set up test database
    db := setupTestDB(t)
    defer db.Close()

    // Act: Create notification through service
    // Assert: Verify in database and cache
}
```

#### Plan E2E Test Scenarios
Document E2E tests to be written later in Phase 3:

```markdown
E2E Test Scenarios (to implement in Phase 3):
1. User mentions another user → Notification created → Appears in UI
2. User clicks notification → Marks as read → Badge count decreases
3. User configures preferences → Notifications respect settings
```

**Test Coverage Goals:**
- Unit test coverage: >80%
- Integration test coverage: Key workflows
- E2E test scenarios: Documented for Phase 3

---

### Step 2: Implement the Feature

**Use full-stack-engineer** to:

#### Implementation Requirements

Based on discovery findings and tests, implement:

**Backend (Go):**
- Data models and database schema
- Service layer business logic
- API endpoints (handlers)
- Middleware (if needed)
- Background jobs/workers (if needed)

**Frontend (TypeScript/Vue):**
- Vue components
- State management (Pinia stores)
- API client services
- Routing updates
- UI styling (Tailwind CSS)

#### Implementation Checklist

- [ ] All unit tests pass
- [ ] All integration tests pass
- [ ] Full application builds without errors
- [ ] All services restarted with new code
- [ ] No TypeScript/linting errors
- [ ] Feature verified working in running application
- [ ] Error handling implemented
- [ ] Logging added for debugging
- [ ] Code follows project standards

#### Implementation Success Criteria

**Backend:**
```bash
# Run tests
go test ./...

# Build
go build ./cmd/server

# Verify no errors
echo $?  # Should be 0
```

**Frontend:**
```bash
# Run tests
npm test

# Build
npm run build

# Lint
npm run lint

# Verify no errors
echo $?  # Should be 0
```

**Manual Verification:**
- Start backend: `make start-backend`
- Start frontend: `make start-frontend`
- Test feature in browser
- Verify functionality matches requirements

---

### Step 3: If Implementation Has Issues

**If tests fail or feature doesn't work:**

→ **Return to Step 1** (Update Tests) or **Step 2** (Fix Implementation)

Common issues:
- Tests failing: Fix implementation or update tests if requirements changed
- Build errors: Resolve syntax/type errors
- Runtime errors: Debug and fix logic errors
- Feature not working as expected: Review requirements and fix

**Keep iterating Steps 1-2 until:**
- All tests pass ✓
- Application builds ✓
- Feature works in running app ✓

---

### Step 4: Code Review

**Use code-reviewer** to:

#### Review Checklist

**Code Quality:**
- [ ] Code follows Go idioms (backend)
- [ ] Code follows Vue/TypeScript best practices (frontend)
- [ ] Functions are focused and single-purpose
- [ ] Variable/function names are clear and descriptive
- [ ] No code duplication
- [ ] Proper error handling
- [ ] Appropriate logging

**Testing:**
- [ ] Test coverage is adequate (>80% for unit tests)
- [ ] Tests are meaningful and test behavior, not implementation
- [ ] Edge cases are covered
- [ ] Integration tests cover key workflows

**Standards Compliance:**
- [ ] Follows project structure standards
- [ ] Uses existing patterns and conventions
- [ ] No breaking changes to existing APIs
- [ ] Backward compatibility maintained

**Documentation:**
- [ ] Code comments where needed
- [ ] API endpoints documented
- [ ] Complex logic explained
- [ ] README updated if needed

**Security:**
- [ ] No SQL injection vulnerabilities
- [ ] Input validation present
- [ ] No XSS vulnerabilities
- [ ] Authentication/authorization checked
- [ ] Sensitive data not logged

**Performance:**
- [ ] No obvious performance issues
- [ ] Database queries optimized
- [ ] Appropriate caching
- [ ] No N+1 query problems

#### Review Outcomes

**Option A: Approved ✓**
- Code meets all standards
- Tests are comprehensive
- Feature is complete
- **Proceed to Phase 3: /review**

**Option B: Changes Requested ⚠️**
- Specific issues identified
- Actionable feedback provided
- **Return to Step 2**: Make requested changes
- **Then repeat Step 4**: Get code re-reviewed

**Option C: Major Issues ❌**
- Fundamental problems identified
- May need architectural review
- **Return to Step 1**: Revise approach
- **Consider**: Re-run /discovery if needed

---

## Implementation Loop Summary

```
┌─────────────────────────────────────────────┐
│ Step 1: Write Tests (full-stack-test-eng)  │
└──────────────┬──────────────────────────────┘
               ↓
┌─────────────────────────────────────────────┐
│ Step 2: Implement Feature (full-stack-eng) │
└──────────────┬──────────────────────────────┘
               ↓
        Tests Pass?
        Build Works?
        Feature Works?
               │
         No ←──┴──→ Yes
         │           │
    Return to        ↓
    Step 1 or 2   ┌─────────────────────────────┐
                  │ Step 4: Code Review         │
                  └──────────────┬──────────────┘
                                 ↓
                          Review Result?
                                 │
                    ┌────────────┼────────────┐
                    ↓            ↓            ↓
                Approved    Changes      Major
                   ✓        Requested    Issues
                   │           ⚠️           ❌
                   │           │            │
                   │      Return to    Return to
                   │      Step 2       Step 1
                   │
                   ↓
            Ready for Phase 3
            /review
```

---

## Phase 2 Complete Criteria

Before proceeding to /review:

- [ ] All unit tests passing
- [ ] All integration tests passing
- [ ] Application builds successfully (backend + frontend)
- [ ] Services restarted with new code
- [ ] Feature manually verified working in running application
- [ ] No TypeScript/linting errors
- [ ] Code review completed and approved
- [ ] All requested changes implemented
- [ ] Code follows project standards
- [ ] Documentation updated

**Output:**
Provide implementation summary:

```markdown
## Implementation Complete: [Feature Name]

### Implementation Summary
- **Backend Changes**: [Files modified, new endpoints]
- **Frontend Changes**: [Components added/modified]
- **Database Changes**: [Schema migrations applied]

### Test Results
- Unit Tests: [X/Y passing]
- Integration Tests: [X/Y passing]
- Test Coverage: [%]

### Build Status
- Backend Build: ✓ Success
- Frontend Build: ✓ Success
- Linting: ✓ No errors

### Code Review
- Reviewer: code-reviewer agent
- Status: ✓ Approved
- Issues Found: [N issues, all resolved]

### Manual Verification
- Feature tested in running application: ✓
- Functionality matches requirements: ✓

**Status**: Ready for Phase 3: /review
```

**Next Command:**
```
/review [feature description]
```
