# VERSION: 1
# LAST UPDATED: 2025-09-09

# Tailwind CSS Project Layout

## Rules
- Keep configuration files at the project root or build tool root
- Organize styles from global to specific (base → components → utilities)
- Use consistent naming for custom CSS files
- Separate design tokens from implementation

## Core Tailwind Files

### Configuration Files
```
# At project root or frontend root (e.g., web/ in Go projects)
tailwind.config.js       # Main Tailwind configuration
tailwind.config.ts       # TypeScript version (recommended for TS projects)
postcss.config.js        # PostCSS configuration (often required)
postcss.config.cjs       # CommonJS version if needed
```

### CSS Structure
```
src/styles/              # Main styles directory
├─ tailwind.css          # Main Tailwind entry point
├─ globals.css           # Global styles and CSS reset
├─ base.css              # Base layer customizations
├─ components.css        # Component layer styles
├─ utilities.css         # Utility layer additions
├─ tokens/               # Design system tokens
│  ├─ colors.css         # Color variables
│  ├─ typography.css     # Font and text variables
│  ├─ spacing.css        # Spacing scale variables
│  └─ animations.css     # Custom animations/transitions
└─ vendor/               # Third-party CSS overrides
   └─ overrides.css      # Library-specific overrides
```

## Example tailwind.css Structure
```css
/* Base Tailwind imports */
@tailwind base;
@tailwind components;  
@tailwind utilities;

/* Optional: Import design tokens */
@import './tokens/colors.css';
@import './tokens/typography.css';
@import './tokens/spacing.css';
@import './tokens/animations.css';

/* Optional: Import custom layers */
@import './base.css';
@import './components.css';
@import './utilities.css';

/* Optional: Vendor overrides */
@import './vendor/overrides.css';
```

## Framework-Specific Integration

### Vue + Vite Projects
```
web/
├─ tailwind.config.ts    # Tailwind config with content paths
├─ postcss.config.js     # PostCSS with tailwindcss plugin
├─ vite.config.ts        # Vite config (CSS processing)
└─ src/
   ├─ main.ts            # Import main CSS here
   └─ styles/
      └─ tailwind.css    # Main Tailwind file
```

### React Projects
```
tailwind.config.js       # Content paths pointing to src/
postcss.config.js        # PostCSS configuration
src/
├─ index.css            # Import Tailwind here
├─ App.css              # App-specific styles
└─ components/
   └─ Button.module.css # Component-scoped styles
```

### Next.js Projects
```
tailwind.config.js       # Next.js-specific paths
postcss.config.js        # Often auto-generated
styles/
├─ globals.css          # Global Tailwind import
└─ Home.module.css      # Page-specific modules
```

## Example tailwind.config.js Structure
```javascript
/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx,vue}",
    // Only Vue files need to be scanned for classes
  ],
  theme: {
    extend: {
      colors: {
        primary: {
          50: '#f0f9ff',
          500: '#3b82f6',
          900: '#1e3a8a',
        }
      },
      fontFamily: {
        sans: ['Inter', 'system-ui', 'sans-serif'],
      },
      spacing: {
        '18': '4.5rem',
      }
    },
  },
  plugins: [
    // Common plugins
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/aspect-ratio'),
  ],
  // Development optimizations
  safelist: [
    // Classes that should never be purged
    'bg-red-500',
    'text-center',
  ]
}
```

## Go + Vue Integration Layout
```
myapp/                   # Go project root
├─ tailwind.config.js    # Could be here for global config
├─ web/                  # Vue frontend
│  ├─ tailwind.config.ts # Preferred location for Vue-specific config
│  ├─ postcss.config.js  # PostCSS for Vite
│  ├─ vite.config.ts     # Vite build configuration
│  └─ src/
│     ├─ main.ts         # Import './styles/tailwind.css'
│     └─ styles/
│        ├─ tailwind.css # @tailwind directives
│        ├─ components.css # Custom component styles
│        └─ tokens/
│           └─ colors.css # Design system variables
├─ templates/            # Go HTML templates (if using)
│  └─ *.html            # Include Tailwind classes here
└─ internal/
   └─ handlers/
      └─ static.go      # Serve built CSS from web/dist/
```

## Build Integration Files

### package.json Scripts
```json
{
  "scripts": {
    "build:css": "tailwindcss -i ./src/styles/tailwind.css -o ./dist/styles.css --watch",
    "build:css:prod": "tailwindcss -i ./src/styles/tailwind.css -o ./dist/styles.css --minify",
    "dev": "concurrently \"npm run build:css\" \"vite\"",
    "build": "vite build && npm run build:css:prod"
  }
}
```

### Makefile Integration (for Go projects)
```makefile
.PHONY: build-frontend
build-frontend:
	cd web && npm run build

.PHONY: dev-frontend  
dev-frontend:
	cd web && npm run dev

.PHONY: build-all
build-all: build-frontend
	go build -o bin/myapp cmd/myapp/main.go
```

## Development Files

### VS Code Settings (.vscode/settings.json)
```json
{
  "tailwindCSS.includeLanguages": {
    "vue": "html",
    "javascript": "html",
    "typescript": "html"
  },
  "tailwindCSS.experimental.classRegex": [
    ["class:\\s*?[\"'`]([^\"'`]*).*?[\"'`]", "[\"'`]([^\"'`]*)[\"'`]"]
  ],
  "css.validate": false,
  "scss.validate": false
}
```

### .gitignore Additions
```
# Tailwind
/dist/styles.css
/dist/styles.css.map

# Build output
web/dist/
node_modules/
```

## Common File Examples

### base.css
```css
@layer base {
  html {
    @apply scroll-smooth;
  }
  
  body {
    @apply bg-gray-50 text-gray-900 antialiased;
  }
  
  h1, h2, h3, h4, h5, h6 {
    @apply font-bold leading-tight;
  }
}
```

### components.css
```css
@layer components {
  .btn {
    @apply px-4 py-2 rounded-md font-medium transition-colors;
  }
  
  .btn-primary {
    @apply bg-blue-600 text-white hover:bg-blue-700;
  }
  
  .card {
    @apply bg-white rounded-lg shadow-md p-6;
  }
}
```

### utilities.css
```css
@layer utilities {
  .text-shadow {
    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
  }
  
  .scrollbar-hide {
    -ms-overflow-style: none;
    scrollbar-width: none;
  }
  
  .scrollbar-hide::-webkit-scrollbar {
    display: none;
  }
}
```

## Best Practices

### File Organization
- Keep Tailwind config at the appropriate root level
- Use meaningful names for custom CSS files
- Separate concerns: tokens → base → components → utilities
- Co-locate component styles when using CSS modules

### Performance
- Configure content paths accurately to optimize purging
- Use safelist sparingly for dynamic classes
- Consider JIT mode for development speed
- Minimize custom CSS in favor of Tailwind utilities

### Integration
- Import main CSS file in application entry point
- Configure build tools to process PostCSS
- Use CSS-in-JS solutions cautiously with Tailwind
- Leverage framework-specific Tailwind plugins when available