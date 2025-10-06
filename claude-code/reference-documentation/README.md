# Reference Documentation

This directory contains language-specific coding guidelines and project structure standards for Claude Code agents.

## Overview

These documents define idiomatic patterns, best practices, and project organization standards that agents should follow when writing code.

## Directory Structure

```
reference-documentation/
├── code-writer.md              # General code quality standards (language-agnostic)
├── golang/
│   ├── golang-code-writer.md        # Go idioms, patterns, and best practices
│   └── golang-project-layout.md     # Go project structure and organization
├── python/
│   └── python-code-writer.md        # Python idioms, patterns, and best practices
├── tailwind/
│   ├── tailwind-code-writer.md      # Tailwind CSS patterns and best practices
│   └── tailwind-project-layout.md   # Tailwind file organization
└── typescript/
    ├── typescript-code-writer.md    # TypeScript + Vue patterns and best practices
    └── typescript-project-layout.md # TypeScript + Vue project structure
```

## Document Purpose

### General Standards
- **code-writer.md** - Core principles applicable to all languages: interface preservation, mockability, code quality, refactoring guidelines

### Language-Specific Guides

#### Go (`golang/`)
- **golang-code-writer.md** - Go idioms, modular design, interface patterns, testing approach
- **golang-project-layout.md** - Go project structure, package organization, file naming

#### Python (`python/`)
- **python-code-writer.md** - Python idioms (duck typing, EAFP), type hinting philosophy, Pythonic patterns, testing approach

#### TypeScript + Vue (`typescript/`)
- **typescript-code-writer.md** - TypeScript type system, Vue 3 Composition API, composables, Pinia stores, component patterns
- **typescript-project-layout.md** - Feature-based organization, component structure, routing, testing layout

#### Tailwind CSS (`tailwind/`)
- **tailwind-code-writer.md** - Utility patterns, responsive design, Vue integration, performance considerations
- **tailwind-project-layout.md** - CSS file organization, design tokens, layer structure

## How Agents Use These Documents

### Full Stack Engineer
References when implementing features:
- TypeScript + Vue patterns for frontend
- Go patterns for backend
- Tailwind for styling
- General code quality standards

### Code Reviewer
Uses as checklist for reviews:
- Verify code follows language idioms
- Check project structure compliance
- Ensure best practices are followed

### Refactoring Specialist
References when proposing improvements:
- Identify violations of idiomatic patterns
- Suggest structure improvements
- Recommend better testing approaches

### Full Stack Test Engineer
References for testing standards:
- Language-specific testing patterns
- Mockability requirements
- Test organization standards

## Key Principles Across All Languages

### Code Quality
- Provide complete solutions (no ellipsis or partial code)
- Respect existing public interfaces
- Design for testability and mockability
- Follow SOLID principles
- Handle errors appropriately

### Testing Philosophy
- Separate business logic from I/O
- Use dependency injection
- Create interface abstractions
- Minimize global state
- Make code deterministic

### Project Organization
- Organize by feature/domain, not file type
- Co-locate related files
- Use clear naming conventions
- Create clean public APIs
- Keep files focused and small

## Language-Specific Highlights

### Go
- Interface-driven design (`interfaces.go`)
- Black-box testing (`_test` package suffix)
- Unexported implementation details
- Standard library preference

### Python
- Duck typing first, protocols second
- EAFP over LBYL
- Gradual typing philosophy
- Pythonic idioms over verbose patterns

### TypeScript + Vue
- Composition API with `<script setup>`
- Type-safe props and emits
- Composables for reusable logic
- Feature-based organization

### Tailwind CSS
- Utility-first approach
- Mobile-first responsive design
- Layer organization (base → components → utilities)
- Design token usage

## Relationship to Tech Stack

These documents support the following tech stack:

**Backend:**
- Go (primary backend language)

**Frontend:**
- TypeScript (language)
- Vue 3 (framework)
- Tailwind CSS (styling)
- Vite (build tool)
- Pinia (state management)
- Vitest (testing)

**Future:**
- Python (scripting, data processing)
- Swift (iOS - TBD)
- Kotlin (Android - TBD)

## Contributing

When adding new language guides:

1. **Create language subdirectory** (`language-name/`)
2. **Add code-writer guide** (`language-name-code-writer.md`)
3. **Add project layout guide** (`language-name-project-layout.md`)
4. **Follow existing pattern**:
   - Key Principles section
   - Language-specific guidelines
   - Best practices and anti-patterns
   - Testing approach
5. **Update this README** with new language

## Document Maintenance

- Keep documents in sync with project decisions
- Update when adopting new patterns
- Remove obsolete practices
- Add examples when patterns are unclear
- Version documents if breaking changes occur

---

**Source:** These documents are adapted from `code-gen/` guides, refined for Claude Code agent usage.
