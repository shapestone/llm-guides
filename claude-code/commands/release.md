---
argument-hint: [feature description]
description: Release: Update documentation, project tracking, and optionally create tags/merge
---

You are orchestrating the **Release** for: $ARGUMENTS

This command finalizes the feature with documentation updates, project management updates, and optional release operations.

## Release

---

### Step 1: Update Documentation

**Use documentation-engineer** to update all relevant documentation.

#### API Documentation

**If feature adds/modifies APIs:**

Update `docs/api/` with:
- New endpoints
- Request/response formats
- Authentication requirements
- Error codes
- Rate limits
- Examples

**Example API Documentation:**
```markdown
## POST /api/notifications

Create a new notification for a user.

### Request
```json
{
  "user_id": "string",
  "type": "mention" | "comment" | "like",
  "content": "string",
  "reference_id": "string"
}
```

### Response (201 Created)
```json
{
  "id": "string",
  "user_id": "string",
  "type": "mention",
  "content": "string",
  "created_at": "2024-01-01T12:00:00Z",
  "read": false
}
```

### Errors
- `400 Bad Request`: Invalid request body
- `401 Unauthorized`: Missing or invalid auth token
- `404 Not Found`: User not found
```

#### Architecture Documentation

**If architecture changed:**

Update `docs/architecture/`:
- System diagrams
- Data flow diagrams
- Component interactions
- Architecture Decision Records (ADRs)

**Create or Update ADR:**
```markdown
# ADR-0015: Real-Time Notifications with WebSockets

## Status
Accepted

## Context
Users need to receive instant notifications when mentioned in posts.

## Decision
Implement WebSocket-based real-time notification delivery.

## Consequences
- Pros: True real-time delivery, better UX
- Cons: Requires persistent connections, more complex infrastructure

## Alternatives Considered
- Polling: Simpler but poor UX and inefficient
- Server-Sent Events: One-way only, less flexible
```

#### User/Developer Guides

**Update guides as needed:**
- `docs/guides/notifications.md` - How to use notifications
- `docs/developer-docs/notification-service.md` - Implementation details
- `README.md` - If feature affects setup or usage

#### Code Documentation

**Review and update:**
- Inline code comments
- Function/method documentation
- Package/module documentation
- Complex algorithm explanations

---

### Step 2: Update Project Tracking

**Use project-manager** to update project management and notify stakeholders.

#### Update Issue/Ticket Status

```bash
# If using GitHub Issues
gh issue close 123 --comment "Completed in PR #456. Feature is now available."

# If using project board
gh project item-edit --project-id X --id Y --field-id Status --text "Done"
```

#### Update Project Documentation

Update `docs/product/` or project tracking:

**Feature Completion Record:**
```markdown
## Feature: Real-Time User Notifications

### Status: ✓ Complete

### Completion Details
- **Implemented**: 2024-01-15
- **Released**: Pending merge to main
- **Version**: To be included in v1.2.0

### Implementation Summary
- Real-time WebSocket notifications
- Notification center UI
- User preferences
- Mark as read functionality

### Metrics
- Development time: 3 days
- Test coverage: 85%
- Performance: <100ms response time
- Lines of code: +1,234 / -56

### Documentation
- API docs: Updated
- User guide: Updated
- Architecture: Updated (ADR-0015)
```

#### Update Sprint/Milestone Tracking

**Sprint Burndown:**
- Mark story as complete
- Update sprint progress
- Calculate velocity

**Release Notes Draft:**
```markdown
## v1.2.0 Release Notes (Draft)

### New Features
- **Real-Time Notifications**: Users now receive instant notifications when mentioned in posts
  - WebSocket-based real-time delivery
  - Notification center with unread badge
  - Configurable notification preferences
  - Mark as read functionality

### Improvements
- [Other improvements]

### Bug Fixes
- [Bug fixes]

### Technical Updates
- Added WebSocket support
- New notification service layer
- Database schema updates (notifications table)
```

---

### Step 3: Notify Stakeholders

**Use project-manager** to inform relevant parties:

#### Notify Team
- Development team
- QA team
- Product management
- Design team

#### Stakeholder Communication

**Example Notification:**
```markdown
Subject: Feature Complete: Real-Time User Notifications

Hi Team,

The real-time user notification feature is now complete and ready for release.

**What's New:**
Users will now receive instant notifications when mentioned in posts, with a new notification center interface.

**Status:**
- ✓ Discovery - Complete
- ✓ Implementation - Complete
- ✓ Review (E2E, Performance, Security) - Complete
- ✓ Pushed to GitHub - Complete
- ✓ Documentation & Release - Complete

**Next Steps:**
- PR ready for final review: [PR Link]
- Pending merge to main
- Will be included in v1.2.0 release

**Documentation:**
- API Docs: [Link]
- User Guide: [Link]
- Architecture: [Link to ADR]

Let me know if you have any questions!
```

---

### Step 4: Optional - Create Release Tag

**If this is a versioned release, use git-ops-engineer** to create a tag:

#### Semantic Versioning

Determine version number:
- **Major** (v2.0.0): Breaking changes
- **Minor** (v1.2.0): New features, backward compatible
- **Patch** (v1.1.1): Bug fixes only

#### Create Annotated Tag

```bash
# Ensure you're on the correct commit
git log -1

# Create annotated tag
git tag -a v1.2.0 -m "Release v1.2.0: Real-Time Notifications

New Features:
- Real-time user mention notifications
- Notification center UI
- User notification preferences

Improvements:
- WebSocket infrastructure
- Notification service layer

Technical Changes:
- Added notifications table
- WebSocket handler implementation
- Vue notification components

Test Coverage: 85%
Performance: <100ms response time
"

# Verify tag
git tag -l "v1.2.0"
git show v1.2.0

# Push tag to remote
git push origin v1.2.0
```

---

### Step 5: Optional - Merge to Main

**If authorized and ready to deploy:**

#### Pre-Merge Checklist

- [ ] All steps complete (discovery, implementation, review, push, release)
- [ ] PR approved by reviewers
- [ ] All CI/CD checks passing
- [ ] No merge conflicts
- [ ] Deployment plan ready
- [ ] Rollback plan ready

#### Merge Options

**Option A: Merge via GitHub PR**
```bash
# Merge PR using gh CLI
gh pr merge 456 --merge --delete-branch

# Or use web interface for better control
gh pr view 456 --web
```

**Option B: Manual Merge (if needed)**
```bash
# Switch to main
git checkout main

# Pull latest
git pull origin main

# Merge feature branch
git merge --no-ff feature/add-user-notifications-1704153600

# Push to main
git push origin main

# Delete feature branch
git branch -d feature/add-user-notifications-1704153600
git push origin :feature/add-user-notifications-1704153600
```

---

## Release Summary

### Complete Release Checklist

**Documentation:**
- [ ] API documentation updated
- [ ] Architecture docs updated (ADRs, diagrams)
- [ ] User/developer guides updated
- [ ] Code comments reviewed
- [ ] README updated (if applicable)

**Project Management:**
- [ ] Issue/ticket status updated
- [ ] Project board updated
- [ ] Sprint/milestone updated
- [ ] Release notes drafted
- [ ] Metrics recorded

**Stakeholder Communication:**
- [ ] Team notified
- [ ] Product management informed
- [ ] Documentation links shared
- [ ] Status communicated

**Optional - Release Operations:**
- [ ] Version tag created (if versioned release)
- [ ] Tag pushed to remote
- [ ] PR merged to main (if authorized)
- [ ] Feature branch deleted

---

## Release Output

```markdown
## Release Complete - [Feature Name]

### Documentation Updates
- ✓ API Documentation: Updated `/api/notifications` endpoints
- ✓ Architecture: Created ADR-0015 for WebSocket decision
- ✓ User Guide: Added notifications section
- ✓ README: Updated with setup instructions

### Project Tracking
- ✓ Issue #123: Closed
- ✓ Project Board: Moved to "Done"
- ✓ Sprint Status: Complete
- ✓ Release Notes: Drafted for v1.2.0

### Stakeholder Communication
- ✓ Team notified via [channel]
- ✓ Product management informed
- ✓ Documentation shared

### Release Operations (if applicable)
- ✓ Version Tag: v1.2.0 created and pushed
- ✓ PR #456: Merged to main
- ✓ Feature Branch: Deleted

### Feature Complete
All steps successfully completed:
- ✓ Discovery
- ✓ Implementation
- ✓ Review
- ✓ Push
- ✓ Release

**Status**: Feature is COMPLETE and ready for deployment.
```

---

## Post-Release Activities

### Monitor Deployment

After merge/deploy:
- Monitor application logs
- Check error rates
- Verify metrics/monitoring
- Watch for user feedback
- Be ready to rollback if needed

### Retrospective

**Document lessons learned:**
- What went well?
- What could be improved?
- Any blockers encountered?
- Estimated vs actual time?
- Any technical debt created?

### Next Steps

- Return to `/planning` for next feature
- Address any follow-up issues
- Iterate on feedback

---

**Feature Development Cycle Complete!**

**To start next feature:**
```
/planning  # Review backlog and prioritize
```
or
```
/discovery [next feature]  # Start discovery for known next feature
```
