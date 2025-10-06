# Playwright and Playwright MCP Setup Guide

## Overview

This guide covers installing **Playwright** (browser automation testing framework) and **Playwright MCP** (Model Context Protocol server for Claude Code integration).

## Part 1: Installing Playwright

### 1. Install Playwright Package

```bash
# Using npm
npm install -D @playwright/test

# Using yarn
yarn add -D @playwright/test

# Using pnpm
pnpm add -D @playwright/test
```

### 2. Install Playwright Browsers

```bash
# Install all browsers (Chromium, Firefox, WebKit)
npx playwright install

# Install specific browser only
npx playwright install chromium

# Install with system dependencies (Linux)
npx playwright install --with-deps
```

### 3. Generate Configuration File

```bash
# Interactive setup (recommended for new projects)
npm init playwright@latest

# This creates:
# - playwright.config.ts (or .js)
# - tests/ directory with example test
# - tests-examples/ directory
```

## Part 2: Playwright Configuration Files

### Required: `playwright.config.ts`

**Location**: Project root or frontend directory (e.g., `web/playwright.config.ts`)

```typescript
import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
  // Test directory
  testDir: './tests',

  // Parallel execution
  fullyParallel: true,

  // Fail build on CI if test.only is used
  forbidOnly: !!process.env.CI,

  // Retry failed tests on CI only
  retries: process.env.CI ? 2 : 0,

  // Workers for parallel execution
  workers: process.env.CI ? 1 : undefined,

  // Reporter configuration
  reporter: 'html',

  // Shared test options
  use: {
    // Base URL for page.goto('/')
    baseURL: 'http://localhost:1234',

    // Collect trace on failure
    trace: 'retain-on-failure',

    // Screenshot on failure
    screenshot: 'only-on-failure',

    // Video on retry
    video: 'retain-on-failure',
  },

  // Browser projects
  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] },
    },
    {
      name: 'firefox',
      use: { ...devices['Desktop Firefox'] },
    },
    {
      name: 'webkit',
      use: { ...devices['Desktop Safari'] },
    },
  ],

  // Optional: Auto-start dev server
  webServer: {
    command: 'npm run dev',  // or 'make start'
    url: 'http://localhost:1234',
    reuseExistingServer: !process.env.CI,
    timeout: 120000,
  },
});
```

### Optional: TypeScript Configuration

**Location**: `tsconfig.json` (add to existing or create new)

```json
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "commonjs",
    "lib": ["ES2020"],
    "types": ["@playwright/test"],
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true
  },
  "include": ["tests/**/*"],
  "exclude": ["node_modules"]
}
```

### Optional: `.gitignore` Updates

```gitignore
# Playwright
test-results/
playwright-report/
playwright/.cache/
```

## Part 3: Writing Your First Test

**Location**: `tests/example.spec.ts`

```typescript
import { test, expect } from '@playwright/test';

test.describe('My Application', () => {
  test.beforeEach(async ({ page }) => {
    // Navigate to your app
    await page.goto('http://localhost:1234');
  });

  test('should display homepage', async ({ page }) => {
    // Given: User is on homepage
    await expect(page).toHaveURL('http://localhost:1234');

    // When: Page loads
    await page.waitForLoadState('networkidle');

    // Then: Title should be visible
    await expect(page).toHaveTitle(/My App/);
  });

  test('should interact with element', async ({ page }) => {
    // Find and click button
    await page.click('button:has-text("Click Me")');

    // Verify result
    await expect(page.locator('.result')).toBeVisible();
  });
});
```

## Part 4: Running Playwright Tests

### Command Line Execution

```bash
# Run all tests
npx playwright test

# Run in headed mode (show browser)
npx playwright test --headed

# Run specific test file
npx playwright test tests/example.spec.ts

# Run in debug mode
npx playwright test --debug

# Run with UI mode (interactive)
npx playwright test --ui

# Run specific browser
npx playwright test --project=chromium

# Show test report
npx playwright show-report
```

### Package.json Scripts (Recommended)

```json
{
  "scripts": {
    "test": "playwright test",
    "test:headed": "playwright test --headed",
    "test:debug": "playwright test --debug",
    "test:ui": "playwright test --ui",
    "test:chromium": "playwright test --project=chromium",
    "test:report": "playwright show-report"
  }
}
```

Then run: `npm test`, `npm run test:headed`, etc.

## Part 5: Installing Playwright MCP Server

### What is Playwright MCP?

**Playwright MCP** is a Model Context Protocol server that allows Claude Code to interact with Playwright programmatically during conversations. It provides tools for:
- Browser navigation and automation
- Screenshot capture
- HTML inspection
- Console log monitoring
- Form interaction
- Code generation for tests

### Installation

The Playwright MCP server runs via NPX and doesn't require installation:

```bash
# Verify it can run (optional check)
npx -y @executeautomation/playwright-mcp-server --help
```

**Note**: We use `@executeautomation/playwright-mcp-server` rather than the official `@playwright/mcp` as it provides better compatibility with Claude Code.

### MCP Server Configuration

**IMPORTANT**: The Playwright MCP server is configured **per-project** in Claude Code, not globally.

#### Configuration File Location

**macOS/Linux**: `~/.claude.json`
**Windows**: `%USERPROFILE%\.claude.json`

This file contains project-specific settings for all your projects.

#### Configuration Structure

The configuration is nested under `projects.[your-project-path].mcpServers`:

```json
{
  "projects": {
    "/Users/username/Projects/my-project": {
      "mcpServers": {
        "playwright": {
          "type": "stdio",
          "command": "npx",
          "args": ["-y", "@executeautomation/playwright-mcp-server"],
          "env": {}
        }
      }
    }
  }
}
```

#### Adding Playwright MCP to Your Project

**Option 1: Manual Configuration** (Advanced)

1. Open `~/.claude.json` in a text editor
2. Find your project path under `projects`
3. Add the `playwright` configuration to the `mcpServers` object
4. Save the file
5. Restart Claude Code

**Option 2: Programmatic Configuration** (Recommended)

Use Node.js to safely update the configuration:

```bash
node -e "
const fs = require('fs');
const filePath = process.env.HOME + '/.claude.json';
const projectPath = '/full/path/to/your/project';

const data = JSON.parse(fs.readFileSync(filePath, 'utf8'));

if (data.projects && data.projects[projectPath]) {
  data.projects[projectPath].mcpServers = {
    ...data.projects[projectPath].mcpServers,
    playwright: {
      type: 'stdio',
      command: 'npx',
      args: ['-y', '@executeautomation/playwright-mcp-server'],
      env: {}
    }
  };

  fs.writeFileSync(filePath, JSON.stringify(data, null, 2));
  console.log('✓ Playwright MCP configured for project');
} else {
  console.log('✗ Project not found. Open the project in Claude Code first.');
}
"
```

**Option 3: Ask Claude Code** (Easiest)

Simply ask Claude Code to configure Playwright MCP for your project. It can update the configuration file automatically.

### Verifying Playwright MCP in Claude Code

After configuring and restarting Claude Code, verify the setup:

#### Step 1: Check MCP Status

Run the `/mcp` command in Claude Code:

```
/mcp
```

**Expected output** (when properly configured):

```
┌───────────────────────────────────────────────────────────────────────────────┐
│ Playwright MCP Server                                                         │
│                                                                               │
│ Status: ✔ connected                                                           │
│ Command: npx                                                                  │
│ Args: -y @executeautomation/playwright-mcp-server                             │
│ Config location: ~/.claude.json [project: /path/to/your/project]             │
│ Capabilities: tools · resources                                               │
│ Tools: 32 tools                                                               │
└───────────────────────────────────────────────────────────────────────────────┘
```

**If you see** "No MCP servers configured":
- The configuration wasn't added correctly
- Claude Code wasn't restarted after configuration
- The project path in `.claude.json` doesn't match your actual project path

#### Step 2: Verify Available Tools

The Playwright MCP server provides these tools to Claude Code:

```
Navigation & Control:
- mcp__executeautomation__playwright_navigate
- mcp__executeautomation__playwright_go_back
- mcp__executeautomation__playwright_go_forward
- mcp__executeautomation__playwright_close

Interaction:
- mcp__executeautomation__playwright_click
- mcp__executeautomation__playwright_fill
- mcp__executeautomation__playwright_hover
- mcp__executeautomation__playwright_select

Inspection:
- mcp__executeautomation__playwright_screenshot
- mcp__executeautomation__playwright_get_visible_html
- mcp__executeautomation__playwright_get_visible_text
- mcp__executeautomation__playwright_console_logs

... and 20+ more tools
```

**Note**: Tool names use the `mcp__executeautomation__` prefix (not `mcp__playwright__`)

### Using Playwright MCP in Claude Code

No additional configuration needed in your project. Claude Code provides these tools automatically when the MCP server is running.

**Example Usage** (via Claude Code):

```
User: "Navigate to localhost:8080 and take a screenshot"

Claude Code internally uses:
1. mcp__executeautomation__playwright_navigate({ url: "http://localhost:8080" })
2. mcp__executeautomation__playwright_screenshot({ name: "homepage" })
```

**Example interactions you can request:**
- "Navigate to http://localhost:8080 and take a screenshot"
- "Click the button with text 'Submit'"
- "Fill the input field with id 'email' with 'test@example.com'"
- "Get the visible text from the page"
- "Check the console logs for errors"
- "Take a screenshot of the current page"

## Part 6: Project Integration Checklist

### ✅ Minimal Setup (Start Here)

- [ ] Install Playwright: `npm install -D @playwright/test`
- [ ] Install browsers: `npx playwright install`
- [ ] Create `playwright.config.ts` with basic settings
- [ ] Create `tests/` directory
- [ ] Write first test
- [ ] Run test: `npx playwright test`

### ✅ Recommended Setup

- [ ] Add npm scripts to `package.json`
- [ ] Configure `baseURL` in playwright config
- [ ] Set up `webServer` for auto-start (optional)
- [ ] Add test artifacts to `.gitignore`
- [ ] Configure CI/CD integration (if applicable)

### ✅ Playwright MCP Setup (For Claude Code Users)

- [ ] Verify NPX can run Playwright MCP: `npx -y @executeautomation/playwright-mcp-server --help`
- [ ] Open your project in Claude Code (creates project entry in `~/.claude.json`)
- [ ] Add Playwright MCP configuration to `~/.claude.json` (see configuration section above)
- [ ] Restart Claude Code completely
- [ ] Verify MCP is connected: Run `/mcp` command in Claude Code
- [ ] Test navigation: Ask Claude to navigate to your app
- [ ] Test screenshot: Ask Claude to capture a screenshot
- [ ] Test interaction: Ask Claude to click elements

**Note**: Configuration must be added **per-project** in `~/.claude.json`, not globally.

## Part 7: Directory Structure

After complete setup, your project should look like:

```
my-project/
├── node_modules/
├── tests/
│   ├── example.spec.ts
│   └── my-feature.spec.ts
├── test-results/              # Generated after test runs
├── playwright-report/          # Generated after test runs
├── playwright.config.ts        # Main configuration
├── package.json               # With Playwright dependencies
├── tsconfig.json              # Optional: TypeScript config
└── .gitignore                 # Ignore test artifacts
```

## Part 8: Common Issues and Solutions

### Issue: "Browsers not installed"

```bash
# Solution: Install browsers
npx playwright install
```

### Issue: "Cannot find module '@playwright/test'"

```bash
# Solution: Install Playwright
npm install -D @playwright/test
```

### Issue: "Test timeout exceeded"

```typescript
// Solution: Increase timeout in config
export default defineConfig({
  timeout: 60000,  // 60 seconds per test
  use: {
    navigationTimeout: 30000,  // 30 seconds for navigation
  },
});
```

### Issue: "Playwright MCP tools not available in Claude Code"

**Symptoms**: Running `/mcp` shows "No MCP servers configured" or Playwright is not listed.

**Solutions**:

1. **Verify project is open in Claude Code**
   ```bash
   # Check if your project exists in the config
   grep -A 5 "$(pwd)" ~/.claude.json
   ```

2. **Check configuration file**
   ```bash
   # Verify Playwright MCP is configured for your project
   node -e "
   const fs = require('fs');
   const data = JSON.parse(fs.readFileSync(process.env.HOME + '/.claude.json', 'utf8'));
   const project = data.projects?.[process.cwd()];
   console.log('MCP Servers:', JSON.stringify(project?.mcpServers, null, 2));
   "
   ```

3. **Add configuration if missing** (see "Adding Playwright MCP to Your Project" section above)

4. **Restart Claude Code completely** - Configuration changes require full restart

5. **Verify NPX works**
   ```bash
   npx -y @executeautomation/playwright-mcp-server --help
   ```

6. **Check for JSON syntax errors**
   ```bash
   # Validate the JSON file
   node -e "JSON.parse(require('fs').readFileSync(process.env.HOME + '/.claude.json', 'utf8')); console.log('✓ Valid JSON')"
   ```

### Issue: "MCP tools have wrong prefix (mcp__playwright__ instead of mcp__executeautomation__)"

**Cause**: You're using `@playwright/mcp` instead of `@executeautomation/playwright-mcp-server`

**Solution**: Update your configuration to use `@executeautomation/playwright-mcp-server` in the args array

### Issue: "Project path not found in ~/.claude.json"

**Cause**: The project hasn't been opened in Claude Code yet

**Solution**:
1. Open the project directory in Claude Code first
2. Close and reopen Claude Code
3. Check if the project entry was created: `grep "$(pwd)" ~/.claude.json`

## Part 9: Next Steps

### Learn More

- **Official Docs**: https://playwright.dev/docs/intro
- **Best Practices**: https://playwright.dev/docs/best-practices
- **API Reference**: https://playwright.dev/docs/api/class-playwright
- **MCP Docs**: https://modelcontextprotocol.io/

### Advanced Topics

- Page Object Models for reusable test components
- Visual regression testing with Percy or Chromatic
- Accessibility testing with @axe-core/playwright
- Performance testing with Lighthouse
- CI/CD integration (GitHub Actions, GitLab CI)

---

## Summary

### For Regular Playwright Testing:

1. Install: `npm install -D @playwright/test`
2. Install browsers: `npx playwright install`
3. Create: `playwright.config.ts`
4. Write tests in `tests/` directory
5. Run: `npx playwright test`

### For Playwright MCP (Claude Code):

1. **Verify NPX works**: `npx -y @executeautomation/playwright-mcp-server --help`
2. **Open project in Claude Code** (creates entry in `~/.claude.json`)
3. **Add MCP configuration** to `~/.claude.json` for your project:
   ```json
   {
     "projects": {
       "/path/to/your/project": {
         "mcpServers": {
           "playwright": {
             "type": "stdio",
             "command": "npx",
             "args": ["-y", "@executeautomation/playwright-mcp-server"],
             "env": {}
           }
         }
       }
     }
   }
   ```
4. **Restart Claude Code completely**
5. **Verify**: Run `/mcp` command - should show "Playwright MCP Server ✔ connected"
6. **Use**: Ask Claude Code to navigate, screenshot, or interact with your app

**Important**: Configuration is **per-project** in `~/.claude.json`, not global.

### Key Files:

**For Playwright Testing:**
- ✅ **Required**: `playwright.config.ts` (or `.js`)
- ✅ **Required**: Tests in `tests/*.spec.ts`
- 📦 **Optional**: `package.json` scripts
- 📦 **Optional**: `tsconfig.json` for TypeScript

**For Playwright MCP:**
- 🔧 **Required**: `~/.claude.json` with project-specific MCP configuration
- 🔧 **Not in project**: MCP server runs via NPX, no project files needed
- 🔧 **Separate from tests**: MCP and testing are independent features

---

**Document Version**: 2.0
**Last Updated**: 2025-10-03
**Updated**: Added correct MCP configuration instructions for `~/.claude.json`
