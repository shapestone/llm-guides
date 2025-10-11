---
argument-hint: [feature description or PR number]
description: Phase 3 - Comprehensive review: E2E tests, performance analysis, security review, and system verification
---

You are orchestrating **Phase 3: Review** for: $ARGUMENTS

This phase performs comprehensive verification including E2E testing, performance analysis, security review, and final system integrity check.

## Phase 3: Review

---

### Step 1: E2E Tests

**Use e2e-test-engineer** to:

#### Write and Run End-to-End Tests

Create Playwright E2E tests for complete user workflows:

**Test Scenarios:**
```typescript
// Example: notifications.spec.ts
import { test, expect } from '@playwright/test'

test.describe('Real-time Notifications', () => {
  test('user receives notification when mentioned', async ({ page, context }) => {
    // Arrange: Create two users
    const userA = await context.newPage()
    const userB = page

    // Act: User A mentions User B
    await userA.goto('/posts/new')
    await userA.fill('[data-test="post-content"]', '@userB Hello!')
    await userA.click('[data-test="submit-post"]')

    // Assert: User B sees notification
    await userB.goto('/notifications')
    await expect(userB.locator('[data-test="notification"]')).toContainText('mentioned you')
    await expect(userB.locator('[data-test="unread-badge"]')).toContainText('1')
  })

  test('user marks notification as read', async ({ page }) => {
    // Test marking as read functionality
  })

  test('notification preferences are respected', async ({ page }) => {
    // Test user preferences
  })
})
```

#### Test Coverage

**Core User Workflows:**
- [ ] Happy path: Feature works as expected
- [ ] Error scenarios: Proper error handling
- [ ] Edge cases: Boundary conditions
- [ ] Integration: Works with existing features
- [ ] Cross-browser: Chrome, Firefox, Safari

**Run Tests:**
```bash
# Run all E2E tests
npx playwright test

# Run specific test file
npx playwright test notifications.spec.ts

# Run in headed mode (see browser)
npx playwright test --headed

# Generate report
npx playwright show-report
```

#### E2E Test Results

```markdown
E2E Test Results:
- Tests Run: [N]
- Tests Passed: [N]
- Tests Failed: [N]
- Test Coverage: [List scenarios covered]

Failed Tests (if any):
- [Test name]: [Failure reason]
- [Action needed]

Browser Compatibility:
- Chrome: ✓
- Firefox: ✓
- Safari: [✓/✗]
```

---

### Step 2: Performance Review

**Use performance-engineer** to:

#### Analyze Performance

**Backend Performance:**
- API endpoint response times
- Database query performance
- Memory usage
- CPU utilization
- Concurrency handling

**Performance Testing:**
```bash
# Example: Load test with hey
hey -n 1000 -c 50 http://localhost:8080/api/notifications

# Monitor database queries
EXPLAIN ANALYZE SELECT * FROM notifications WHERE user_id = 123;
```

**Frontend Performance:**
- Initial load time
- Time to interactive
- Component render performance
- Bundle size
- Memory leaks

**Performance Metrics:**
```markdown
### Backend Performance
- Notification Creation API: [X ms avg]
- Notification Fetch API: [Y ms avg]
- WebSocket Connection: [Z ms avg]
- Database Query Time: [W ms avg]

### Frontend Performance
- Initial Load: [X ms]
- Time to Interactive: [Y ms]
- Bundle Size: [Z KB]
- Largest Contentful Paint: [W ms]

### Load Testing Results
- Concurrent Users: [N]
- Requests/Second: [N]
- Error Rate: [X%]
- 95th Percentile Response Time: [X ms]
```

#### Performance Analysis

**Bottlenecks Identified:**
- [ ] None found ✓
- [ ] Bottleneck 1: [Description]
  - Impact: [High/Medium/Low]
  - Recommendation: [How to fix]
- [ ] Bottleneck 2: [Description]
  - Impact: [High/Medium/Low]
  - Recommendation: [How to fix]

**Optimization Opportunities:**
- [List any optimization suggestions]

**Performance Verdict:**
- ✓ **Acceptable**: Performance meets requirements
- ⚠️ **Needs Optimization**: Minor issues to address
- ❌ **Unacceptable**: Major performance problems

---

### Step 3: Security Review

**Use security-engineer** to:

#### Security Assessment

**OWASP Top 10 Review:**
- [ ] A01:2021 – Broken Access Control
- [ ] A02:2021 – Cryptographic Failures
- [ ] A03:2021 – Injection
- [ ] A04:2021 – Insecure Design
- [ ] A05:2021 – Security Misconfiguration
- [ ] A06:2021 – Vulnerable and Outdated Components
- [ ] A07:2021 – Identification and Authentication Failures
- [ ] A08:2021 – Software and Data Integrity Failures
- [ ] A09:2021 – Security Logging and Monitoring Failures
- [ ] A10:2021 – Server-Side Request Forgery (SSRF)

**Specific Security Checks:**

**Authentication & Authorization:**
- [ ] Proper authentication required
- [ ] Authorization checks in place
- [ ] No privilege escalation possible
- [ ] Session management secure

**Input Validation:**
- [ ] All inputs validated
- [ ] SQL injection prevention
- [ ] XSS prevention
- [ ] CSRF protection

**Data Security:**
- [ ] Sensitive data encrypted
- [ ] No secrets in code/logs
- [ ] Secure data transmission (HTTPS)
- [ ] Proper error messages (no info leakage)

**API Security:**
- [ ] Rate limiting implemented
- [ ] Input size limits
- [ ] Proper CORS configuration
- [ ] API authentication

#### Security Findings

```markdown
### Critical Issues (Fix Immediately)
- [ ] None found ✓
- [ ] Issue 1: [Description and fix required]

### High Priority Issues
- [ ] None found ✓
- [ ] Issue 1: [Description and fix required]

### Medium Priority Issues
- [ ] None found ✓
- [ ] Issue 1: [Description and recommendation]

### Low Priority Issues / Recommendations
- [ ] Recommendation 1: [Description]
```

**Security Verdict:**
- ✓ **Secure**: No critical vulnerabilities
- ⚠️ **Minor Issues**: Address before release
- ❌ **Vulnerable**: Critical issues must be fixed

---

### Step 4: System Integrity Verification

**Use e2e-test-engineer** to:

#### Final System Check

**Run Complete Test Suite:**
```bash
# Backend tests
go test ./...

# Frontend tests
npm test

# E2E tests
npx playwright test

# Integration tests
npm run test:integration
```

#### Regression Testing

**Verify No Regressions:**
- [ ] All existing E2E tests still pass
- [ ] Core workflows unaffected
- [ ] No breaking changes introduced
- [ ] Existing APIs still functional
- [ ] Data integrity maintained

#### System Health Check

**Smoke Tests:**
- [ ] Application starts successfully
- [ ] Database connectivity works
- [ ] Cache/Redis connectivity works
- [ ] External APIs responsive
- [ ] Background jobs running
- [ ] Logging functional
- [ ] Monitoring alerts working

#### System Integrity Results

```markdown
### Test Suite Results
- Unit Tests: [X/Y passing]
- Integration Tests: [X/Y passing]
- E2E Tests: [X/Y passing]
- Total: [X/Y passing]

### Regression Check
- Existing Features: ✓ All working
- Breaking Changes: None detected
- Data Integrity: ✓ Maintained

### System Health
- All services: ✓ Running
- Database: ✓ Connected
- External dependencies: ✓ Responsive
```

---

## Phase 3 Review Summary

### Ship/No-Ship Recommendation

**Criteria for Ship Decision:**

| Category | Status | Details |
|----------|--------|---------|
| E2E Tests | [✓/✗] | [X/Y tests passing] |
| Performance | [✓/⚠️/✗] | [Acceptable/Needs work/Unacceptable] |
| Security | [✓/⚠️/✗] | [No critical issues/Minor issues/Critical issues] |
| System Integrity | [✓/✗] | [No regressions/Regressions found] |

### Final Recommendation

**✓ SHIP** - Ready for Release
- All E2E tests passing
- Performance acceptable
- No critical security issues
- No regressions
- System integrity verified
- **Proceed to Phase 4: /push**

**⚠️ SHIP WITH CONDITIONS** - Minor Issues
- E2E tests passing but minor issues found
- Performance acceptable with minor optimizations needed
- No critical security issues but minor improvements recommended
- Create tickets for follow-up work
- **Can proceed to Phase 4: /push** (address issues in next iteration)

**❌ DO NOT SHIP** - Critical Issues
- E2E test failures
- Unacceptable performance
- Critical security vulnerabilities
- Regressions in existing functionality
- **Return to Phase 2: /implement** to address issues

---

## Phase 3 Complete Criteria

- [ ] All E2E tests written and passing
- [ ] Performance analyzed and acceptable
- [ ] Security review completed with no critical issues
- [ ] System integrity verified
- [ ] No regressions in existing features
- [ ] Ship/No-Ship decision made

**Output:**
Provide comprehensive review summary with ship recommendation.

**Next Commands:**
```
/push  # If SHIP or SHIP WITH CONDITIONS
```
or
```
/implement [feature]  # If DO NOT SHIP (fix issues first)
```
