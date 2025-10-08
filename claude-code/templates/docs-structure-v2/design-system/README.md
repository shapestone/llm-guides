# Design System Documentation (Published)

**Owner:** design-systems-engineer agent
**Publishing target:** design.yourproduct.com or Storybook
**Audience:** Designers and developers using your design system

## Purpose

Documentation for your UI component library and design system. Helps designers and developers use components consistently across your product.

## Structure

```
design-system/
├── index.md                  # Design system homepage
├── getting-started.md        # How to install and use
├── components/               # Component documentation
│   ├── button.md
│   ├── modal.md
│   ├── form-inputs.md
│   └── navigation.md
├── tokens/                   # Design tokens
│   ├── colors.md
│   ├── typography.md
│   ├── spacing.md
│   └── breakpoints.md
└── patterns/                 # Design patterns
    ├── layouts.md
    ├── navigation-patterns.md
    └── accessibility.md
```

## Content Guidelines

### Component Documentation

Each component should document:
- **Purpose** - What is this component for?
- **Usage** - When to use it
- **Props/API** - All props/attributes
- **Examples** - Visual examples with code
- **Variants** - Different states and styles
- **Accessibility** - ARIA labels, keyboard nav
- **Do's and Don'ts** - Usage guidelines

### Example Component Doc

```markdown
# Button Component

A clickable button component with multiple variants.

## Usage

Use buttons for actions like submitting forms or triggering events.

## Props

| Prop | Type | Default | Description |
|------|------|---------|-------------|
| variant | 'primary' \| 'secondary' \| 'danger' | 'primary' | Button style |
| size | 'sm' \| 'md' \| 'lg' | 'md' | Button size |
| disabled | boolean | false | Disable the button |

## Examples

\`\`\`vue
<Button variant="primary">Click me</Button>
<Button variant="secondary" size="lg">Large Button</Button>
\`\`\`

## Accessibility

- Always include accessible text
- Use semantic HTML `<button>`
- Ensure sufficient color contrast

## Do's and Don'ts

✓ Use for primary actions
✓ Keep button text short and clear
✗ Don't use for navigation (use Link instead)
```

## Design Tokens

Document your design system's foundational values:

```markdown
# Colors

## Primary Colors

- `primary-500`: #3B82F6 (Main brand color)
- `primary-600`: #2563EB (Hover state)
- `primary-700`: #1D4ED8 (Active state)

## Usage

\`\`\`css
.button-primary {
  background-color: var(--color-primary-500);
}
\`\`\`
```

## Publishing

This directory is typically published using:

**Storybook** (recommended for component libraries):
```js
// .storybook/main.js
module.exports = {
  stories: [
    '../design-system/**/*.stories.mdx',
    '../design-system/**/*.stories.@(js|jsx|ts|tsx)',
  ],
};
```

**Static Site Generators**:
- Docusaurus
- VitePress
- Custom Vue/React documentation site

## Live Examples

Consider including:
- Interactive component playground
- Copy-paste code snippets
- Visual design token swatches
- Accessibility testing results

## See Also

- [Document Project Layout](../../reference-documentation/document-project-layout.md)
- [design-systems-engineer agent](../../agents/architecture/design-systems-engineer.md)
