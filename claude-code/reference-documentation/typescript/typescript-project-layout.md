# TypeScript + Vue 3 Project Structure Guide

## Overview

This guide defines the standard project structure for TypeScript + Vue 3 applications, emphasizing feature-based organization, type safety, and maintainability.

## Project Root Structure

```
project-root/
├── public/                 # Static assets (not processed by build tools)
│   ├── favicon.ico
│   └── robots.txt
├── src/                    # Application source code
│   ├── assets/            # Build-time assets (images, fonts, etc.)
│   ├── components/        # Shared/generic components
│   ├── composables/       # Reusable composition functions
│   ├── features/          # Feature-based modules
│   ├── layouts/           # Layout components
│   ├── router/            # Vue Router configuration
│   ├── stores/            # Pinia stores
│   ├── types/             # Global TypeScript types
│   ├── utils/             # Utility functions
│   ├── views/             # Page-level components
│   ├── App.vue            # Root component
│   ├── main.ts            # Application entry point
│   └── vite-env.d.ts      # Vite environment types
├── tests/                  # Test files
│   ├── unit/
│   ├── integration/
│   └── e2e/
├── .env                    # Environment variables (local)
├── .env.example            # Environment variables template
├── .gitignore
├── index.html              # HTML entry point
├── package.json
├── tsconfig.json           # TypeScript configuration
├── tsconfig.node.json      # TypeScript config for Node scripts
├── vite.config.ts          # Vite configuration
└── vitest.config.ts        # Vitest configuration
```

## Source Directory (`src/`) Structure

### Feature-Based Organization

Organize code by feature/domain rather than technical layer:

```
src/features/
├── auth/
│   ├── components/
│   │   ├── LoginForm.vue
│   │   └── LoginForm.spec.ts
│   ├── composables/
│   │   ├── useAuth.ts
│   │   └── useAuth.spec.ts
│   ├── services/
│   │   └── authService.ts
│   ├── stores/
│   │   └── authStore.ts
│   ├── types/
│   │   └── auth.types.ts
│   ├── views/
│   │   ├── LoginView.vue
│   │   └── RegisterView.vue
│   └── index.ts           # Feature barrel export
├── users/
│   └── ...                # Similar structure
└── products/
    └── ...                # Similar structure
```

### Components Directory

Shared, reusable components used across features:

```
src/components/
├── ui/                     # Generic UI components
│   ├── Button/
│   │   ├── Button.vue
│   │   ├── Button.spec.ts
│   │   └── types.ts
│   ├── Input/
│   │   ├── Input.vue
│   │   └── Input.spec.ts
│   └── Modal/
│       ├── Modal.vue
│       └── Modal.spec.ts
├── forms/                  # Form-related components
│   ├── FormField.vue
│   └── FormError.vue
└── layout/                 # Layout utilities
    ├── Container.vue
    └── Grid.vue
```

### Composables Directory

Reusable composition functions:

```
src/composables/
├── useApi.ts              # API client composable
├── useDebounce.ts         # Debounce utility
├── useLocalStorage.ts     # Local storage wrapper
├── usePagination.ts       # Pagination logic
└── index.ts               # Barrel export
```

**Naming Convention:**
- Always prefix with `use`
- Use camelCase: `useUserData`, `useFormValidation`
- Export as named export: `export function useCounter() { ... }`

### Stores Directory (Pinia)

State management stores:

```
src/stores/
├── user.ts                # User store
├── cart.ts                # Shopping cart store
├── notifications.ts       # Notifications store
└── index.ts               # Store registration
```

**Store Structure:**
```typescript
// stores/user.ts
import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import type { User } from '@/types'

export const useUserStore = defineStore('user', () => {
  // State
  const user = ref<User | null>(null)
  const loading = ref(false)

  // Getters
  const isAuthenticated = computed(() => user.value !== null)
  const fullName = computed(() =>
    user.value ? `${user.value.firstName} ${user.value.lastName}` : ''
  )

  // Actions
  async function fetchUser(id: number) {
    loading.value = true
    try {
      const response = await api.getUser(id)
      user.value = response.data
    } finally {
      loading.value = false
    }
  }

  function clearUser() {
    user.value = null
  }

  return {
    // State
    user: readonly(user),
    loading: readonly(loading),
    // Getters
    isAuthenticated,
    fullName,
    // Actions
    fetchUser,
    clearUser,
  }
})
```

### Types Directory

Global TypeScript type definitions:

```
src/types/
├── api.types.ts           # API request/response types
├── models.types.ts        # Domain models
├── components.types.ts    # Component prop types
├── enums.ts               # Enums and constants
└── index.ts               # Barrel export
```

**Type Organization:**
```typescript
// types/api.types.ts
export interface ApiResponse<T> {
  data: T
  status: number
  message?: string
}

export interface PaginatedResponse<T> {
  data: T[]
  total: number
  page: number
  perPage: number
}

// types/models.types.ts
export interface User {
  id: number
  email: string
  firstName: string
  lastName: string
  role: UserRole
}

export enum UserRole {
  Admin = 'admin',
  User = 'user',
  Guest = 'guest',
}

// types/components.types.ts
export interface ButtonProps {
  variant?: 'primary' | 'secondary' | 'danger'
  size?: 'sm' | 'md' | 'lg'
  disabled?: boolean
  loading?: boolean
}
```

### Router Directory

Vue Router configuration:

```
src/router/
├── guards/
│   ├── auth.guard.ts
│   └── permission.guard.ts
├── routes/
│   ├── auth.routes.ts
│   ├── admin.routes.ts
│   └── public.routes.ts
├── index.ts               # Router instance
└── types.ts               # Route meta types
```

**Router Structure:**
```typescript
// router/index.ts
import { createRouter, createWebHistory } from 'vue-router'
import type { RouteRecordRaw } from 'vue-router'
import { authGuard } from './guards/auth.guard'

const routes: RouteRecordRaw[] = [
  {
    path: '/',
    component: () => import('@/layouts/MainLayout.vue'),
    children: [
      {
        path: '',
        name: 'home',
        component: () => import('@/views/HomeView.vue'),
      },
      // ... other routes
    ],
  },
]

const router = createRouter({
  history: createWebHistory(),
  routes,
})

router.beforeEach(authGuard)

export default router
```

### Utils Directory

Pure utility functions:

```
src/utils/
├── date.utils.ts          # Date formatting, manipulation
├── string.utils.ts        # String helpers
├── number.utils.ts        # Number formatting
├── validation.utils.ts    # Validation functions
└── index.ts               # Barrel export
```

**Utility Function Guidelines:**
- Keep functions pure (no side effects)
- Provide proper TypeScript types
- Export as named exports
- Include JSDoc comments

```typescript
// utils/date.utils.ts
/**
 * Formats a date to YYYY-MM-DD format
 */
export function formatDate(date: Date): string {
  return date.toISOString().split('T')[0]
}

/**
 * Calculates days between two dates
 */
export function daysBetween(start: Date, end: Date): number {
  const diffTime = Math.abs(end.getTime() - start.getTime())
  return Math.ceil(diffTime / (1000 * 60 * 60 * 24))
}
```

### Views Directory

Page-level components:

```
src/views/
├── HomeView.vue
├── AboutView.vue
├── NotFoundView.vue
└── ErrorView.vue
```

**View Component Characteristics:**
- One view per route
- Suffix with `View` (e.g., `UserProfileView.vue`)
- Compose from smaller components
- Handle page-level logic and layout

## TypeScript Configuration Files

### `tsconfig.json`

```json
{
  "extends": "@vue/tsconfig/tsconfig.dom.json",
  "compilerOptions": {
    "baseUrl": ".",
    "paths": {
      "@/*": ["./src/*"]
    },
    "strict": true,
    "strictNullChecks": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noImplicitReturns": true,
    "skipLibCheck": true,
    "esModuleInterop": true,
    "moduleResolution": "bundler",
    "allowImportingTsExtensions": true,
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "jsx": "preserve"
  },
  "include": [
    "src/**/*",
    "src/**/*.vue"
  ],
  "exclude": [
    "node_modules",
    "dist"
  ]
}
```

### `vite-env.d.ts`

```typescript
/// <reference types="vite/client" />

interface ImportMetaEnv {
  readonly VITE_API_URL: string
  readonly VITE_APP_TITLE: string
  readonly VITE_ENABLE_ANALYTICS: string
}

interface ImportMeta {
  readonly env: ImportMetaEnv
}
```

## Component File Structure

### Single File Component Layout

```vue
<script setup lang="ts">
// 1. Imports
import { ref, computed, onMounted } from 'vue'
import type { User } from '@/types'
import Button from '@/components/ui/Button.vue'

// 2. Props
interface Props {
  userId: number
  initialName?: string
}

const props = withDefaults(defineProps<Props>(), {
  initialName: '',
})

// 3. Emits
const emit = defineEmits<{
  update: [user: User]
  delete: [id: number]
}>()

// 4. State
const user = ref<User | null>(null)
const loading = ref(false)

// 5. Computed
const displayName = computed(() =>
  user.value ? `${user.value.firstName} ${user.value.lastName}` : 'Unknown'
)

// 6. Methods
async function loadUser() {
  loading.value = true
  try {
    // API call
    user.value = await fetchUser(props.userId)
  } finally {
    loading.value = false
  }
}

// 7. Lifecycle
onMounted(() => {
  loadUser()
})
</script>

<template>
  <div class="user-card">
    <h2>{{ displayName }}</h2>
    <Button @click="emit('delete', userId)">
      Delete
    </Button>
  </div>
</template>

<style scoped>
.user-card {
  padding: 1rem;
}
</style>
```

## Testing Structure

```
tests/
├── unit/
│   ├── components/
│   │   └── Button.spec.ts
│   ├── composables/
│   │   └── useAuth.spec.ts
│   └── utils/
│       └── date.utils.spec.ts
├── integration/
│   └── features/
│       └── auth.spec.ts
└── e2e/
    └── user-flow.spec.ts
```

## Environment Configuration

### `.env.example`

```bash
# API Configuration
VITE_API_URL=http://localhost:3000/api
VITE_API_TIMEOUT=30000

# Application
VITE_APP_TITLE=My Application
VITE_APP_VERSION=1.0.0

# Features
VITE_ENABLE_ANALYTICS=false
VITE_ENABLE_DEBUG=true
```

## Barrel Exports (index.ts)

Use barrel exports to create clean public APIs:

```typescript
// components/ui/index.ts
export { default as Button } from './Button/Button.vue'
export { default as Input } from './Input/Input.vue'
export { default as Modal } from './Modal/Modal.vue'

// composables/index.ts
export * from './useApi'
export * from './useAuth'
export * from './useDebounce'

// types/index.ts
export * from './api.types'
export * from './models.types'
export * from './components.types'
```

## Best Practices

1. **Co-location**: Keep related files close together
2. **Feature Slicing**: Organize by feature, not file type
3. **Type Safety**: Define types in dedicated files, export from barrels
4. **Naming Conventions**:
   - Components: `PascalCase.vue`
   - Composables: `useCamelCase.ts`
   - Utils: `camelCase.ts`
   - Types: `camelCase.types.ts`
5. **Lazy Loading**: Use dynamic imports for routes and heavy components
6. **Path Aliases**: Use `@/` for absolute imports from src
7. **Test Co-location**: Keep tests next to implementation when appropriate
8. **Single Responsibility**: One component/function per file (except barrel exports)

## Anti-Patterns to Avoid

- Organizing by technical layer (`/components`, `/services`, `/utils`) instead of features
- Creating barrel exports that re-export everything (selective exports only)
- Mixing different concerns in single file
- Deep nesting of directories (keep it flat when possible)
- Inconsistent naming conventions
- Not using TypeScript path aliases
- Putting business logic in components instead of composables/services
