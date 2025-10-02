# VERSION: 1
# LAST UPDATED: 2025-10-01

# Playwright MCP Configuration for Claude Code

This document captures the configuration and best practices for using Playwright MCP (Model Context Protocol) with Claude Code for frontend testing and verification.

## Overview

Playwright MCP provides browser automation capabilities to Claude Code, enabling:
- Automated frontend testing and verification
- Visual regression testing with screenshots
- Interactive debugging of Vue.js applications
- Console log monitoring and error detection
- End-to-end workflow testing

## MCP Server Configuration

### Required MCP Server
- **Server**: Playwright MCP server
- **Purpose**: Browser automation and testing capabilities
- **Integration**: Works with Claude Code through MCP protocol

#### Claude Code MCP Server Setup
The Playwright MCP server should be configured in your Claude Code settings. The exact configuration details depend on your Claude Code setup, but you need:

1. **Playwright MCP Server**: Installed and running
2. **Server Connection**: Properly configured in Claude Code MCP settings
3. **Permissions**: All Playwright functions explicitly allowed (see permissions section below)

#### Verified Environment
- **Platform**: macOS (Darwin 24.6.0)
- **Claude Code**: Latest version as of 2025-09-28
- **Playwright MCP**: Working with Chrome/Chromium browser
- **Test Environment**: Local development server on http://localhost:1234

#### Critical Configuration Notes
1. **Non-headless Mode**: The current working configuration uses `headless: false` for browser interactions, which provides better debugging visibility
2. **Screenshot Storage**: Screenshots are saved to user's Downloads folder with timestamped filenames
3. **Browser Persistence**: Browser sessions persist between commands - this is both a feature and potential source of conflicts
4. **Permission Requirements**: Every individual MCP function must be explicitly granted permission - no wildcard support

## Permissions Configuration

Since MCP doesn't support wildcard permissions, each Playwright function must be explicitly listed. Here's the complete list organized by category:

### Navigation & Page Control
```
mcp__playwright__playwright_navigate
mcp__playwright__playwright_go_back
mcp__playwright__playwright_go_forward
mcp__playwright__playwright_close
```

### User Interactions
```
mcp__playwright__playwright_click
mcp__playwright__playwright_fill
mcp__playwright__playwright_hover
mcp__playwright__playwright_select
mcp__playwright__playwright_press_key
mcp__playwright__playwright_drag
mcp__playwright__playwright_upload_file
mcp__playwright__playwright_click_and_switch_tab
mcp__playwright__playwright_iframe_click
mcp__playwright__playwright_iframe_fill
```

### Content Retrieval & Analysis
```
mcp__playwright__playwright_screenshot
mcp__playwright__playwright_get_visible_text
mcp__playwright__playwright_get_visible_html
mcp__playwright__playwright_console_logs
```

### JavaScript Execution
```
mcp__playwright__playwright_evaluate
```

### HTTP Operations
```
mcp__playwright__playwright_get
mcp__playwright__playwright_post
mcp__playwright__playwright_put
mcp__playwright__playwright_patch
mcp__playwright__playwright_delete
```

### Response Monitoring
```
mcp__playwright__playwright_expect_response
mcp__playwright__playwright_assert_response
```

### Advanced Features
```
mcp__playwright__playwright_save_as_pdf
mcp__playwright__playwright_custom_user_agent
```

### Code Generation (Test Recording)
```
mcp__playwright__start_codegen_session
mcp__playwright__end_codegen_session
mcp__playwright__get_codegen_session
mcp__playwright__clear_codegen_session
```

## Browser Session Management

### Common Issues and Solutions

#### "Browser is already in use" Error
**Problem**: Playwright maintains persistent browser sessions. Multiple navigation attempts can cause conflicts.

**Error Message**:
```
Error: Browser is already in use for /Users/.../ms-playwright/mcp-chrome-..., use --isolated to run multiple instances
```

**Solution Strategy**:
1. **Check current state first**: Use `mcp__playwright__playwright_screenshot` to see what's currently displayed
2. **Navigate existing session**: If browser is open, navigate directly to new URL
3. **Clean restart**: Use `mcp__playwright__playwright_close` then `mcp__playwright__playwright_navigate` for fresh session

**Best Practices**:
- Always check current browser state before attempting navigation
- Use one browser session at a time
- Close browsers when switching contexts
- Handle session failures gracefully with restart approach

### Session Management Workflow
```javascript
// 1. Check current state (non-invasive)
mcp__playwright__playwright_screenshot

// 2. If navigation needed and browser responsive
mcp__playwright__playwright_navigate

// 3. If browser unresponsive or stuck
mcp__playwright__playwright_close
mcp__playwright__playwright_navigate
```

## Testing Workflow for Vue.js Applications

### Standard Testing Pattern

1. **Initial Setup**
   ```javascript
   // Navigate to application
   mcp__playwright__playwright_navigate("http://localhost:1234")

   // Take baseline screenshot
   mcp__playwright__playwright_screenshot("initial_state")
   ```

2. **Component Testing**
   ```javascript
   // Interact with components
   mcp__playwright__playwright_click("button[aria-label='Scenarios']")

   // Verify state changes
   mcp__playwright__playwright_get_visible_html("div.scenario-header")
   ```

3. **Console Monitoring**
   ```javascript
   // Check for JavaScript errors
   mcp__playwright__playwright_console_logs("all")
   ```

4. **Interactive Testing**
   ```javascript
   // Test form interactions
   mcp__playwright__playwright_fill("input.scenario-title-input", "New Title")
   mcp__playwright__playwright_press_key("Enter")
   ```

### Vue.js Specific Considerations

- **Reactive Updates**: Allow time for Vue's reactivity system to update DOM
- **Component Lifecycle**: Monitor console logs for component mounting/unmounting
- **State Management**: Verify state changes through DOM inspection
- **Event Handling**: Test click handlers and form submissions

## Debugging Techniques

### Visual Debugging
```javascript
// Take screenshots at key points
mcp__playwright__playwright_screenshot("before_interaction")
mcp__playwright__playwright_click("selector")
mcp__playwright__playwright_screenshot("after_interaction")
```

### Console Analysis
```javascript
// Monitor all console activity
mcp__playwright__playwright_console_logs("all")

// Filter specific log types
mcp__playwright__playwright_console_logs("error")
```

### DOM Inspection
```javascript
// Get specific element HTML
mcp__playwright__playwright_get_visible_html("div.component")

// Check element text content
mcp__playwright__playwright_get_visible_text()
```

### JavaScript Evaluation
```javascript
// Execute custom JavaScript for debugging
mcp__playwright__playwright_evaluate(`
  const element = document.querySelector('.target');
  return {
    visible: element ? !element.hidden : false,
    text: element ? element.textContent : null
  };
`)
```

## Integration with Development Workflow

### Production-Like Development Testing
```bash
# Start development server
make watch-production-like

# Test with Playwright MCP
# Navigate to http://localhost:1234
# Perform interactive testing
```

### Continuous Verification
- Use Playwright MCP after `make restart` to verify changes
- Combine with `make logs` to correlate frontend/backend behavior
- Test both main application and component showcase (`?components=true`)

## Common Use Cases

### 1. Inline Editing Verification
```javascript
// Test scenario name editing
mcp__playwright__playwright_click("h1.scenario-title")
mcp__playwright__playwright_fill("input.scenario-title-input", "New Name")
mcp__playwright__playwright_press_key("Enter")
mcp__playwright__playwright_screenshot("name_updated")
```

### 2. CSS Styling Verification
```javascript
// Check computed styles
mcp__playwright__playwright_evaluate(`
  const element = document.querySelector('.target');
  const styles = window.getComputedStyle(element);
  return { width: styles.width, minWidth: styles.minWidth };
`)
```

### 3. Component State Testing
```javascript
// Navigate to component showcase
mcp__playwright__playwright_navigate("http://localhost:1234/?components=true")
```

## Troubleshooting

### Browser Not Responding
1. Take screenshot to verify current state
2. Try `mcp__playwright__playwright_close`
3. Wait a moment, then navigate fresh

### Element Not Found
1. Check current page with `mcp__playwright__playwright_get_visible_html`
2. Verify element exists and is visible
3. Use JavaScript evaluation to debug selectors

### Console Errors
1. Monitor `mcp__playwright__playwright_console_logs`
2. Check for Vue component errors
3. Verify API requests are completing successfully

## Security Considerations

- Playwright MCP runs in controlled environment
- Only test against local development servers
- Avoid testing with real credentials or sensitive data
- Browser sessions are isolated and temporary

## Performance Tips

- Use specific selectors rather than broad searches
- Take screenshots only when necessary for verification
- Clear console logs periodically to avoid memory buildup
- Close browser sessions when switching between major test scenarios

## Conclusion

Playwright MCP provides powerful browser automation capabilities for Claude Code. Proper session management and understanding of the permission model are key to successful frontend testing and verification workflows.