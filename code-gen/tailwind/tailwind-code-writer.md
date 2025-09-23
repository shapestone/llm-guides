# VERSION: 1
# LAST UPDATED: 2025-09-09

# Enhanced Guidance for LLM Code Assistance - Tailwind CSS Specific

## Critical Rules (Must Follow)
1. DO NOT write or suggest tests until explicitly requested
2. ALWAYS provide complete code solutions - never use ellipsis (...) or phrases like "rest of code remains the same"
3. RESPECT existing public interfaces - changes may significantly impact dependent modules
4. DESIGN code that can be easily mocked in test environments
5. VIOLATION of these rules will result in unusable output

## Project Understanding
- IDENTIFY module boundaries and dependencies before making changes
- ANALYZE how modules are used by other components
- UNDERSTAND Tailwind configuration and custom utility structure

## Mandatory Sequence (FOLLOW IN EXACT ORDER)
1. **HALT** - Do not proceed until you have:
    - Received and reviewed **ALL** relevant existing files
    - Confirmed understanding of the current implementation
    - Analyzed all related configuration files (tailwind.config.ts, postcss.config.js)
    - Verified existing CSS structure and design tokens
    - Identified custom utility classes and component patterns
    - Reviewed build tool integration (Vite, Webpack, etc.)
2. You **MUST** respond with one of:
    - "REQUEST: Please provide [specific files needed]" - be precise about which files
    - "CONFIRMED: I have reviewed all necessary files and am ready to proceed"
3. Only after confirmation, proceed to implementation with these priorities:
    - Preserve existing design system and utility patterns
    - Maintain consistent naming conventions
    - Follow established layer organization (base → components → utilities)

## Interface Preservation
- MAINTAIN existing utility class names and component patterns
- PRESERVE design token structure and naming conventions
- DOCUMENT any necessary breaking changes with clear migration paths
- DESIGN changes with dependent components and pages in mind

## Mockability
- SEPARATE styling logic from dynamic class generation
- USE consistent patterns for conditional classes
- AVOID hardcoded style values - use design tokens
- PROVIDE clear abstractions for complex styling patterns
- DESIGN for testability without CSS framework dependencies

## Code Quality Standards
- WRITE semantic utility combinations that express intent
- SEPARATE concerns: layout, spacing, colors, typography
- HANDLE all viewport sizes and responsive design
- MAINTAIN existing code style, indentation, and naming conventions
- MINIMIZE custom CSS in favor of Tailwind utilities
- INCLUDE appropriate responsive and state variants
- FOLLOW design system principles
- DOCUMENT complex utility combinations with comments

## Response Protocol
- Provide ONLY:
    1. Complete requested code changes (never partial)
    2. File paths being modified
    3. Critical warnings about breaking changes
- DO NOT:
    1. Explain basic CSS or Tailwind concepts
    2. Suggest alternative approaches unless asked
    3. Add contextual information about styling
    4. Provide implementation examples
    5. Discuss best practices unless specifically requested
    6. Include test code unless explicitly requested

## Implementation Process
1. First provide ONLY the implementation code
2. Wait for confirmation before providing any explanations
3. Only explain changes if explicitly requested
4. Always provide complete file content - no partial solutions or ellipses
5. Work on one file at a time. It must be completed and accepted before moving on to the next one.
6. Follow best practices for refactoring by making small, incremental changes that can be tested at each step.
7. Write ONLY the code for one file at a time, list the name of the next file and wait for my feedback before continuing.
8. NEVER give me more than one file at a time, list the name of the next file and wait for my feedback before continuing.

## Response Template
```
File path: [path]
Action: [create/modify/delete]
Code: 
```css
[complete file content for CSS files]
```

```javascript
[complete file content for config files]
```

```vue
[complete file content for Vue components with Tailwind classes]
```
Critical Warnings: [only if breaking changes present]
```

## Refactoring Guidelines
- Extract common utility patterns into component classes
- Create design token variables for repeated values
- Implement consistent responsive design patterns
- Ensure all styling follows mobile-first approach
- Minimize custom CSS and maximize Tailwind utilities
- Make styling predictable and maintainable

## Library Dependencies
- Use Tailwind's built-in utilities when possible
- When multiple plugin options exist, present pros and cons only if asked
- Maintain existing plugin choices unless instructed otherwise
- Prefer official Tailwind plugins over custom implementations

## Tailwind CSS Guidelines

### Project Structure Requirements
- **REFERENCE**: Follow the complete project structure defined in `tailwind-project-layout.md`
- **CONFIGURATION**: Ensure proper setup of `tailwind.config.ts`, `postcss.config.js`
- **STRUCTURE OVERVIEW**:
```
web/src/styles/
├── tailwind.css          # Main Tailwind entry (@tailwind directives)
├── globals.css           # Global styles and CSS reset
├── base.css              # Base layer customizations
├── components.css        # Component layer styles
├── utilities.css         # Utility layer additions
├── tokens/               # Design system tokens
│   ├── colors.css        # Color variables
│   ├── typography.css    # Font and text variables
│   ├── spacing.css       # Spacing scale variables
│   └── animations.css    # Custom animations/transitions
└── vendor/               # Third-party CSS overrides
└── overrides.css     # Library-specific overrides
```

### Design System Integration
- **MUST FOLLOW**: Existing design tokens and color palettes
- **CONSISTENCY**: Use established spacing scales and typography
- **TOKENS**: Reference design system variables rather than hardcoded values
- **NAMING**: Follow consistent naming conventions for custom utilities

### Tailwind Configuration Guidelines
```javascript
// tailwind.config.ts structure
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx,vue}",
  ],
  theme: {
    extend: {
      // Extend default theme, don't override completely
      colors: {
        // Use semantic color names
        primary: { /* color scale */ },
        secondary: { /* color scale */ },
      },
      spacing: {
        // Custom spacing values
      },
      fontFamily: {
        // Custom font stacks
      }
    },
  },
  plugins: [
    // Official plugins preferred
  ],
}
```

### CSS Layer Organization
- **BASE LAYER**: Global resets, element defaults, typography base
- **COMPONENTS LAYER**: Reusable component patterns, complex combinations
- **UTILITIES LAYER**: Single-purpose helper classes, overrides

### Utility Class Patterns
```css
/* Component layer examples */
@layer components {
  .btn {
    @apply px-4 py-2 rounded-md font-medium transition-colors;
  }
  
  .card {
    @apply bg-white rounded-lg shadow-md p-6;
  }
}

/* Utilities layer examples */
@layer utilities {
  .text-shadow {
    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
  }
}
```

### Responsive Design Patterns
- **MOBILE FIRST**: Start with base styles, add larger breakpoint modifiers
- **BREAKPOINTS**: Use Tailwind's default breakpoints (sm, md, lg, xl, 2xl)
- **CONSISTENCY**: Apply responsive patterns consistently across components
- **TESTING**: Ensure designs work across all target viewport sizes

### Vue Component Integration
```vue
<!-- Proper class organization -->
<template>
  <div 
    class="
      flex flex-col gap-4
      p-6 
      bg-white rounded-lg shadow-md
      sm:flex-row sm:items-center
      dark:bg-gray-800
    "
  >
    <!-- Content -->
  </div>
</template>

<!-- Dynamic classes with proper typing -->
<script setup lang="ts">
const buttonClasses = computed(() => [
  'px-4 py-2 rounded-md font-medium transition-colors',
  variant === 'primary' ? 'bg-blue-600 text-white hover:bg-blue-700' : 'bg-gray-200 text-gray-800 hover:bg-gray-300'
])
</script>
```

### Performance Considerations
- **PURGING**: Ensure content paths in config are accurate for optimal bundle size
- **JIT MODE**: Leverage Just-In-Time compilation for development speed
- **SAFELIST**: Use sparingly for dynamically generated classes
- **CUSTOM CSS**: Minimize custom CSS in favor of Tailwind utilities

### Dark Mode Implementation
- **STRATEGY**: Use `class` strategy for manual dark mode control
- **PATTERNS**: Apply dark mode variants consistently
- **TOKENS**: Use semantic color names that work in both themes
- **TESTING**: Verify all components work in both light and dark modes

### Build Integration Requirements
- **VITE**: Proper PostCSS configuration for Tailwind processing
- **IMPORTS**: Import main CSS file in application entry point (`main.ts`)
- **ASSETS**: Ensure proper asset handling for fonts and images
- **OPTIMIZATION**: Configure build tools for optimal CSS output

### File Naming Conventions
- **Config**: `tailwind.config.ts` (TypeScript preferred)
- **Main CSS**: `tailwind.css` (entry point with @tailwind directives)
- **Custom Layers**: Descriptive names (`components.css`, `utilities.css`)
- **Tokens**: Organized by type (`colors.css`, `typography.css`)

### Go + Vue Integration Considerations
- **STATIC SERVING**: Ensure Go backend serves built CSS assets correctly
- **API INTEGRATION**: Style loading states and error states consistently
- **ROUTING**: Apply consistent styling to route transitions
- **FORMS**: Use Tailwind forms plugin for consistent form styling

### Common Anti-Patterns to Avoid
- Overriding Tailwind's default spacing scale unnecessarily
- Creating custom utilities that duplicate existing Tailwind functionality
- Using `!important` instead of proper specificity management
- Hardcoding colors instead of using design system tokens
- Inconsistent responsive breakpoint usage
- Mixing custom CSS with Tailwind utilities without proper organization

### Testing Integration
- **VISUAL TESTING**: Ensure styling works across different browsers
- **RESPONSIVE TESTING**: Test all breakpoints and orientations
- **ACCESSIBILITY**: Verify color contrast and focus states
- **COMPONENT TESTING**: Test dynamic class application in components