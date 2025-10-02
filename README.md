# LLM Guides for Software Development

A curated collection of structured prompt guides for Large Language Models (LLMs) to assist with software development tasks. These guides provide consistent, high-quality instructions for code generation, code review, release processes, and more.

## Overview

This repository contains professionally crafted prompt templates that help LLMs produce better code, maintain consistency, and follow best practices across different programming languages and frameworks.

### Key Features

- **Language-Specific Guidance**: Tailored instructions for Go, Python, Scala 2/3, TypeScript, Vue, and Tailwind CSS
- **Task-Oriented Organization**: Separate guides for code generation, code review, release automation, and documentation
- **Best Practices Built-In**: Each guide enforces industry standards, testability, and maintainability
- **Consistent Structure**: Standardized format across all guides for predictable results

## Repository Structure

```
llm-guides/
├── code-gen/          # Code generation guides
│   ├── code-writer.md           # Generic code writing guide
│   ├── golang/                  # Go-specific guides
│   ├── python/                  # Python-specific guides
│   ├── scala2/                  # Scala 2 guides
│   ├── scala3/                  # Scala 3 guides
│   ├── tailwind/                # Tailwind CSS guides
│   ├── typescript/              # TypeScript guides (WIP)
│   └── vue/                     # Vue.js guides (WIP)
├── review/            # Code review and analysis guides
│   ├── code/
│   │   └── code-explainer-simple.md  # Code explanation guide
│   └── browser/
│       └── playwright-mcp-configuration.md  # Browser debugging with Playwright MCP
├── release-gen/       # Release automation guides
│   └── release-process.md       # GitHub Actions release automation
├── build-gen/         # Build configuration guides (WIP)
├── doc-gen/           # Documentation generation guides (WIP)
└── vcs-gen/           # Version control guides (WIP)
```

## Available Guides

### Code Generation

| Language/Framework | Guide | Project Layout |
|-------------------|-------|----------------|
| Generic | `code-gen/code-writer.md` | - |
| Go | `code-gen/golang/golang-code-writer.md` | `golang-project-layout.md` |
| Python | `code-gen/python/python-code-writer.md` | - |
| Scala 2 | `code-gen/scala2/scala2-code-writer.md` | - |
| Scala 3 | `code-gen/scala3/scala3-code-writer.md` | - |
| Tailwind CSS | `code-gen/tailwind/tailwind-code-writer.md` | `tailwind-project-layout.md` |

### Code Review & Analysis

- **Code Explanation**: `review/code/code-explainer-simple.md`
  - Visual box-drawing format for inline code explanations
  - Comprehensive analysis of correctness, security, and performance

- **Browser Debugging**: `review/browser/playwright-mcp-configuration.md`
  - Playwright MCP configuration for browser automation
  - Frontend testing, visual debugging, and console monitoring
  - Session management and troubleshooting workflows

### Release & Automation

- **Automated Release Process**: `release-gen/release-process.md`
  - GitHub Actions workflow for automated releases
  - Conventional commits and changelog generation
  - Language-agnostic with adaptation examples

## Usage

### How to Use These Guides

1. **Select the appropriate guide** for your task and programming language
2. **Copy the guide content** into your LLM prompt or system instructions
3. **Provide your specific requirements** along with the guide
4. **Receive structured, consistent output** that follows best practices

### Example: Using the Go Code Writer Guide

```markdown
[Paste content from code-gen/golang/golang-code-writer.md]

---

Task: Create a new HTTP handler for user authentication with JWT tokens.
```

### Hierarchical Guide Structure

The guides are organized in a **layered/hierarchical** approach:

- **Generic/Base Layer**: `code-gen/code-writer.md` contains universal principles applicable to all languages
  - Critical rules (no ellipsis, interface preservation, mockability)
  - Mandatory sequence (HALT → REQUEST/CONFIRM → IMPLEMENT)
  - Core quality standards and response protocols

- **Language-Specific Layer**: Each `[language]-code-writer.md` **extends** the generic guide with:
  - Language-specific syntax and idioms
  - Framework-specific patterns and best practices
  - Ecosystem-specific tooling and dependencies
  - Standard project layouts and file organization

**How to Use Layered Guides:**

1. **Option A - Use Language-Specific Only**: Language guides include all generic rules, so you can use them standalone
2. **Option B - Layer Both**: For maximum clarity, provide both the generic guide and language-specific guide together

Example layering:
```markdown
[Content from code-gen/code-writer.md]

---

[Content from code-gen/golang/golang-code-writer.md]

---

Task: Implement a caching layer with Redis...
```

### Guide Selection Matrix

| Task | Generic Guide | Language-Specific | Notes |
|------|---------------|-------------------|-------|
| Generate new code | `code-gen/code-writer.md` | Use language-specific variant | Language guides include framework-specific patterns |
| Refactor existing code | `code-gen/code-writer.md` | Use language-specific variant | Emphasizes interface preservation |
| Explain code | `review/code/code-explainer-simple.md` | Language-agnostic | Visual inline documentation format |
| Debug browser/UI issues | `review/browser/playwright-mcp-configuration.md` | Framework-agnostic | Requires Playwright MCP server configured |
| Setup release automation | `release-gen/release-process.md` | Adaptable to any language | Includes adaptation examples |

## Core Principles

All guides in this repository follow these fundamental principles:

### 1. **Complete Solutions Only**
- No ellipsis (...) or "rest of code remains the same"
- Full file contents provided in every response
- No partial implementations

### 2. **Interface Preservation**
- Maintain backward compatibility by default
- Respect existing public APIs
- Consider impact on dependent modules

### 3. **Testability & Mockability**
- Dependency injection patterns
- Separation of business logic from I/O
- Interface abstractions for external dependencies

### 4. **No Tests Unless Requested**
- Focus on implementation first
- Tests only when explicitly asked
- Separate test generation from code generation

### 5. **Incremental Development**
- One file at a time
- Wait for confirmation before proceeding
- Small, testable changes

## Guide Structure

Each code generation guide follows this structure:

1. **Critical Rules**: Non-negotiable requirements
2. **Mandatory Sequence**: Step-by-step process (HALT → REQUEST/CONFIRM → IMPLEMENT)
3. **Interface Preservation**: Guidelines for maintaining compatibility
4. **Mockability**: Patterns for testable code
5. **Code Quality Standards**: Style and best practices
6. **Response Protocol**: What to include/exclude in responses
7. **Language-Specific Guidelines**: Framework and ecosystem patterns

## Version Tracking

Guides include version metadata:

```markdown
# VERSION: 1
# LAST UPDATED: 2025-10-01
```

This helps track changes and ensure you're using the latest version of each guide.

## Contributing

Contributions are welcome! When adding or updating guides:

1. Follow the established structure and formatting
2. Include VERSION and LAST UPDATED metadata
3. Provide language-specific examples where applicable
4. Test the guide with actual LLM interactions
5. Update this README if adding new guide categories

### Adding a New Language Guide

1. Create a new directory under `code-gen/[language]/`
2. Copy `code-gen/code-writer.md` as a template
3. Add language-specific sections and best practices
4. Update the Available Guides table in this README
5. Include project layout guide if applicable

## Roadmap

### Planned Additions

- [ ] React code generation guide
- [ ] Rust code generation guide
- [ ] Java/Kotlin code generation guide
- [ ] Database schema design guide
- [ ] API documentation generation guide
- [ ] Docker/Kubernetes configuration guides
- [ ] Test generation guides
- [ ] Security review guides

### In Progress

- TypeScript guide
- Vue.js guide
- Build configuration guides
- VCS workflow guides

## Use Cases

- **Individual Developers**: Consistent code generation for personal projects
- **Teams**: Standardized coding practices across team members
- **Code Reviews**: Automated initial code analysis
- **Documentation**: Auto-generated code explanations
- **CI/CD**: Automated release notes and changelog generation

## License

MIT License - see [LICENSE](LICENSE) for details

## Author

Michael Sundell

## Acknowledgments

These guides are based on real-world experience with LLM-assisted development and incorporate best practices from various programming communities.

---

**Note**: This is an active project. Some guide categories are work-in-progress (marked as WIP). Check the repository structure above for currently available guides.
