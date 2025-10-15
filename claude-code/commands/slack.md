---
argument-hint: [optional: number of commits or feature description]
description: Generate Slack team update message
---

You are generating a **Slack Team Update** about recent changes.

This command analyzes recent git commits and creates a friendly, team-oriented message formatted for Slack.

**Usage:**
- `/slack` - Generate update from last commit (default)
- `/slack 5` - Generate update from last 5 commits
- `/slack 10` - Generate update from last 10 commits
- `/slack "feature description"` - Generate update focused on a specific feature

## Generate Slack Update

### Step 1: Analyze Recent Changes

**Gather information:**

```bash
# Get recent commits (default: last 1, or use $ARGUMENTS if number provided)
COMMIT_COUNT="${1:-1}"
git log -n "$COMMIT_COUNT" --pretty=format:"%h - %s (%an, %ar)" --no-merges

# Get detailed changes
git log -n "$COMMIT_COUNT" --pretty=format:"%B" --no-merges

# Get files changed
git diff HEAD~"$COMMIT_COUNT"..HEAD --stat

# Get current branch
git branch --show-current
```

**Extract key information:**
- What features/functionality was added or changed?
- What bugs were fixed?
- What improvements were made?
- Any documentation updates?
- Any refactoring or technical improvements?

---

### Step 2: Categorize Changes

Group changes into categories:

**New Features:**
- [List new functionality added]

**Bug Fixes:**
- [List bugs that were fixed]

**Improvements:**
- [List enhancements to existing features]

**Technical/Infrastructure:**
- [List refactoring, build improvements, etc.]

**Documentation:**
- [List doc updates]

---

### Step 3: Generate Slack Message

Create a friendly, concise message formatted for Slack:

**Message Template:**

```markdown
:rocket: *Team Update*

Hey team! Here's what we shipped recently:

*New Features*:
• [Feature 1] - [Brief description of benefit]
• [Feature 2] - [Brief description of benefit]

*Bug Fixes*:
• Fixed [issue description]
• Resolved [problem description]

*Improvements*:
• [Enhancement 1] - [Why it matters]
• [Enhancement 2] - [Why it matters]

*Technical Updates*:
• [Technical change and benefit]

*What's Next*:
[Optional: Brief mention of upcoming work]

Branch: `[branch-name]`
Commits: [N commits]

Questions or feedback? Let me know! :point_left:
```

**Slack Formatting Guidelines:**
- Use `*bold*:` for section headers (colon OUTSIDE asterisks)
- Use `*bold*` for inline emphasis (colon inside if part of text)
- Use `•` for bullet points
- Use `:emoji:` for visual interest (e.g., :rocket:, :bug:, :sparkles:, :wrench:)
- Use `` `code` `` for branch names, file names, commands
- Keep it conversational and friendly
- Focus on value/benefit to the team, not just technical details
- Keep it concise - aim for readable in 30 seconds

**Tone Guidelines:**
- Friendly and approachable
- Focus on outcomes and benefits
- Avoid jargon where possible
- Celebrate wins
- Be clear about any blockers or questions

---

### Step 4: Customize for Context

**If no arguments** (default - last 1 commit):
- Focus on the most recent change
- Keep it concise and specific
- Highlight the key benefit or fix
- Perfect for quick updates after a single commit

**If number provided** (e.g., `/slack 5`):
- Give overview of all recent changes
- Group related commits together
- Highlight most impactful changes
- Keep other changes brief

**If feature-specific** (when $ARGUMENTS describes a feature):
- Focus on that specific feature
- Include more details about functionality
- Mention testing/quality assurance done
- Call out any breaking changes or migration needed

---

## Output Format

Provide the Slack message in a code block so it's easy to copy/paste:

```
[Your generated Slack message here]
```

**Also provide:**
- Brief summary of what was emphasized
- Any suggested follow-up actions or discussions
- Links to PRs, docs, or related resources (if applicable)

---

## Example Output

**Example 1: Single commit (default - `/slack`):**

```
:sparkles: *Quick Update*

Hey team! Just pushed a fix:

*What Changed*:
• Fixed authentication timeout issue on mobile devices

*Why It Matters*:
• Users will no longer be logged out unexpectedly
• Better mobile experience

Branch: `fix/mobile-auth-timeout`
Commit: abc1234

Ready for testing on staging! :rocket:
```

**Example 2: Multiple commits (`/slack 5`):**

```
:books: *Documentation Update*

Hey team! Just wrapped up some documentation improvements:

*What's New*:
• Cleaned up all slash command descriptions - now more clear and consistent
• Removed confusing "Phase" terminology from agent workflows
• Updated command references to use simpler language

*Why It Matters*:
• Easier for everyone to understand the workflow commands
• Less confusion about what each command does
• Better onboarding for new team members

*Technical*:
• Updated 7 command files (discovery, implement, review, push, release, document, planning)
• Updated 2 agent files (full-stack-engineer, refactoring-specialist)

Branch: `feature/cleanup-phase-references`
Commits: 5 commits

These changes are ready to sync - run the update scripts to get the latest! :raised_hands:
```

---

## Tips for Great Slack Updates

**Do:**
- Lead with value and benefits
- Use emojis to make it scannable
- Keep it brief and focused
- Celebrate the team's work
- Include actionable next steps
- Tag relevant people if needed (e.g., @channel, @product-team)

**Don't:**
- Use too much technical jargon
- Make it too long (aim for under 200 words)
- Skip context - assume people haven't been following along
- Forget to proofread
- Be overly formal or stiff

**Consider adding:**
- Screenshots or GIFs for visual features
- Links to demo/staging environment
- Metrics or performance improvements
- Shout-outs to contributors
- Call for testers or feedback

---

## Variations by Audience

**For Development Team:**
- Include more technical details
- Mention testing coverage
- Note any breaking changes
- Reference related tickets/issues

**For Broader Team (Product, Design, etc.):**
- Focus on user-facing changes
- Explain benefits in business terms
- Use less technical language
- Emphasize impact on users/customers

**For Stakeholders/Leadership:**
- Lead with business value
- Include metrics if available
- Keep technical details minimal
- Connect to project goals

---

**Next Steps:**
- Copy the message to Slack
- Consider which channel is most appropriate (#engineering, #general, etc.)
- Tag relevant people if needed
- Follow up on any questions or feedback
