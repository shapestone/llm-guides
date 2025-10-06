# Enhanced Guidance for LLM Code Assistance - TypeScript Specific

## Key Principles
- Respect existing public interfaces - changes may impact dependent modules
- Design code that can be easily tested and mocked
- Follow idiomatic patterns for the language

## Project Understanding
- IDENTIFY module boundaries and dependencies before making changes
- ANALYZE how modules are used by other components
- UNDERSTAND Vue component composition and state management patterns

## Interface Preservation
- MAINTAIN existing method signatures, parameter types, and return types
- PRESERVE backward compatibility unless explicitly instructed otherwise
- DOCUMENT any necessary breaking changes with clear migration paths
- DESIGN changes with dependent modules in mind

## Mockability
- SEPARATE pure business logic from external dependencies (API calls, browser APIs, etc.)
- USE dependency injection for external services
- AVOID direct instantiation of dependencies within business logic
- PROVIDE interface abstractions for all external dependencies
- DESIGN for testability without DOM or network mocks when possible

## Code Quality Standards
- WRITE pure functions without side effects when possible
- SEPARATE deterministic logic from non-deterministic operations
- HANDLE all potential errors and edge cases
- MAINTAIN existing code style, indentation, and naming conventions
- MINIMIZE changes to existing code (change only what's necessary)
- INCLUDE appropriate error handling
- FOLLOW SOLID principles
- DOCUMENT complex logic with concise comments

## Refactoring Guidelines
- Extract business logic from I/O operations
- Create interfaces for external dependencies
- Implement dependency injection
- Ensure all functions have clear inputs and outputs
- Minimize global state and side effects
- Make code deterministic where possible

## Library Dependencies
- Use standard browser APIs when possible
- When multiple options exist, present pros and cons only if asked
- Maintain existing dependency choices unless instructed otherwise

## TypeScript Guidelines

### Type System Best Practices

#### Type Safety
- LEVERAGE TypeScript's type system - avoid `any` except when absolutely necessary
- USE `unknown` instead of `any` when type is truly unknown
- PREFER type inference where types are obvious
- DEFINE explicit types for public APIs, function parameters, and return types
- USE strict mode (`"strict": true` in tsconfig.json)
- ENABLE all strict flags: `strictNullChecks`, `strictFunctionTypes`, `noImplicitAny`

#### Type Definitions
- CREATE types and interfaces in dedicated `types.ts` files or co-located with implementation
- USE `interface` for object shapes that may be extended
- USE `type` for unions, intersections, and computed types
- PREFER `interface` over `type` for object definitions (better error messages, declaration merging)
- EXPORT types from barrel files (`index.ts`) for clean imports
- USE generics to create reusable, type-safe components and functions

#### Type Assertions and Guards
- AVOID type assertions (`as`) unless absolutely necessary
- PREFER type guards (`typeof`, `instanceof`, custom type predicates) over assertions
- CREATE custom type guards for complex type narrowing:
  ```typescript
  function isUser(obj: unknown): obj is User {
    return typeof obj === 'object' && obj !== null && 'id' in obj
  }
  ```
- USE discriminated unions for type-safe state management
- LEVERAGE `satisfies` operator (TypeScript 4.9+) for type checking without widening

### Module Organization

#### File Structure
- ORGANIZE by feature/domain, not by file type (avoid `components/`, `services/`, `utils/` dumps)
- CO-LOCATE related files: component, types, tests, styles
- USE barrel exports (`index.ts`) to create clean public APIs
- KEEP files focused and small (prefer many small modules over large ones)

#### Import/Export Patterns
- USE named exports for most cases (better for tree-shaking)
- USE default exports sparingly (only for main component/class in file)
- ORGANIZE imports: external packages, internal modules, types, styles
  ```typescript
  // External
  import { ref, computed } from 'vue'
  import axios from 'axios'

  // Internal
  import { useAuth } from '@/composables/useAuth'
  import Button from '@/components/Button.vue'

  // Types
  import type { User, ApiResponse } from '@/types'

  // Styles
  import './Component.css'
  ```
- USE path aliases (`@/`, `~/`) defined in tsconfig for cleaner imports
- AVOID circular dependencies through proper layering

### Vue 3 + TypeScript Integration

#### Component Definition
- USE `<script setup lang="ts">` for Composition API (preferred)
- DEFINE props with `defineProps` using TypeScript syntax:
  ```typescript
  const props = defineProps<{
    title: string
    count?: number
  }>()

  // Or with defaults
  const props = withDefaults(defineProps<{
    title: string
    count?: number
  }>(), {
    count: 0
  })
  ```
- DEFINE emits with type-safe signatures:
  ```typescript
  const emit = defineEmits<{
    update: [value: string]
    delete: [id: number]
  }>()
  ```
- TYPE refs and reactive objects explicitly when inference isn't sufficient:
  ```typescript
  const user = ref<User | null>(null)
  const items = reactive<Item[]>([])
  ```

#### Composables Pattern
- CREATE composables for reusable logic following `use*` naming convention
- RETURN typed objects from composables for clear API surface:
  ```typescript
  export function useCounter(initial = 0) {
    const count = ref(initial)
    const increment = () => count.value++
    const decrement = () => count.value--

    return {
      count: readonly(count),
      increment,
      decrement,
    } as const
  }
  ```
- SEPARATE concerns: each composable should have single responsibility
- USE dependency injection for testability

#### State Management with Pinia
- DEFINE stores with TypeScript for full type safety
- USE `defineStore` with setup syntax for Composition API style:
  ```typescript
  export const useUserStore = defineStore('user', () => {
    const user = ref<User | null>(null)
    const isAuthenticated = computed(() => user.value !== null)

    async function login(credentials: Credentials) {
      // ...
    }

    return { user, isAuthenticated, login }
  })
  ```
- AVOID state mutations outside actions/store methods
- TYPE getters explicitly when return type isn't obvious

### Error Handling

#### Type-Safe Error Handling
- CREATE custom error classes with proper inheritance:
  ```typescript
  class ApiError extends Error {
    constructor(
      message: string,
      public statusCode: number,
      public endpoint: string
    ) {
      super(message)
      this.name = 'ApiError'
    }
  }
  ```
- USE discriminated unions for result types:
  ```typescript
  type Result<T, E = Error> =
    | { success: true; data: T }
    | { success: false; error: E }
  ```
- HANDLE errors at appropriate abstraction levels
- PROVIDE meaningful error messages with context

#### Async Error Handling
- USE try/catch for async operations
- AVOID unhandled promise rejections
- CONSIDER using error boundaries in Vue components
- LOG errors appropriately for debugging

### Testing with TypeScript

#### Type-Safe Testing
- USE Vitest or Jest with TypeScript configuration
- TYPE test fixtures and mocks properly
- LEVERAGE type inference in test assertions
- CREATE test utilities with proper types:
  ```typescript
  function createMockUser(overrides?: Partial<User>): User {
    return {
      id: 1,
      name: 'Test User',
      email: 'test@example.com',
      ...overrides,
    }
  }
  ```

#### Component Testing
- USE `@vue/test-utils` with TypeScript support
- TYPE component wrappers and props correctly
- MOCK composables and stores with proper types
- TEST component contracts (props, emits, slots)

### Code Style and Conventions

#### Naming Conventions
- USE `PascalCase` for classes, interfaces, types, and Vue components
- USE `camelCase` for variables, functions, methods, properties
- USE `UPPER_SNAKE_CASE` for constants and enum values
- PREFIX interfaces with `I` only in specific contexts (avoid by default)
- SUFFIX type names with descriptive intent (`UserData`, `ApiResponse`, not `IUser`, `UserInterface`)

#### Function and Method Design
- PREFER arrow functions for callbacks and short functions
- USE regular functions for methods and when `this` binding matters
- KEEP functions small and focused (single responsibility)
- PREFER pure functions when possible
- USE optional parameters sparingly (prefer overloads or default values)

#### Null Safety
- ENABLE `strictNullChecks` in tsconfig
- USE optional chaining (`?.`) and nullish coalescing (`??`) operators
- AVOID `null` and `undefined` in APIs (prefer throwing or returning empty values)
- BE explicit about nullable types: `string | null`, not implicit

### Vue Component Patterns

#### Composition API Patterns
- PREFER Composition API over Options API for new components
- ORGANIZE composable logic by concern, not lifecycle
- USE `computed` for derived state
- USE `watch` sparingly (prefer computed when possible)
- CLEAN up side effects in `onUnmounted`

#### Component Communication
- USE props for parent-to-child communication
- USE emits for child-to-parent communication
- USE provide/inject for deep component trees (with type safety):
  ```typescript
  // Provider
  const key = Symbol() as InjectionKey<User>
  provide(key, user)

  // Consumer
  const user = inject(key)
  ```
- USE Pinia stores for shared state across components
- AVOID prop drilling (use composition or state management)

#### Template Type Safety
- ENABLE Volar/Vue Language Features extension in VSCode
- USE `defineComponent` wrapper if not using `<script setup>`
- TYPE template refs properly:
  ```typescript
  const inputRef = ref<HTMLInputElement>()
  ```
- LEVERAGE template type checking for props and events

### Performance Considerations

#### Build Optimization
- USE tree-shaking friendly imports (named imports)
- AVOID importing entire libraries (`import _ from 'lodash'`)
- USE code splitting with dynamic imports:
  ```typescript
  const HeavyComponent = defineAsyncComponent(() =>
    import('./HeavyComponent.vue')
  )
  ```
- OPTIMIZE bundle size with proper TypeScript configuration

#### Runtime Performance
- USE `shallowRef` and `shallowReactive` for large immutable objects
- AVOID unnecessary reactivity with `markRaw`
- MEMOIZE expensive computations with `computed`
- USE `v-memo` directive for expensive list rendering
- PREFER `v-show` over `v-if` for frequently toggled elements

### Configuration Management

#### TypeScript Configuration
- EXTEND from Vue's base tsconfig (`@vue/tsconfig/tsconfig.app.json`)
- ENABLE strict mode and all strict flags
- CONFIGURE path aliases for clean imports
- SET appropriate `target` and `module` for browser compatibility
- ENABLE `skipLibCheck` for faster builds with third-party types

#### Environment Variables
- TYPE environment variables using declaration files:
  ```typescript
  // env.d.ts
  interface ImportMetaEnv {
    readonly VITE_API_URL: string
    readonly VITE_APP_TITLE: string
  }

  interface ImportMeta {
    readonly env: ImportMetaEnv
  }
  ```
- VALIDATE environment variables at application startup
- USE type-safe access to `import.meta.env`

### Common Anti-Patterns to Avoid

- Using `any` type liberally (defeats TypeScript's purpose)
- Ignoring type errors with `@ts-ignore` or `@ts-expect-error` without good reason
- Creating overly complex type gymnastics (keep types understandable)
- Mixing Options API and Composition API in same component
- Mutating props directly in child components
- Using reactive objects where refs would suffice
- Over-engineering with unnecessary abstractions
- Not leveraging TypeScript's utility types (`Partial`, `Pick`, `Omit`, etc.)

### TypeScript Utility Types

#### Built-in Utilities
- USE `Partial<T>` for optional properties
- USE `Required<T>` to make all properties required
- USE `Pick<T, K>` to select specific properties
- USE `Omit<T, K>` to exclude specific properties
- USE `Record<K, V>` for object with specific key-value types
- USE `ReturnType<typeof fn>` to extract function return types
- USE `Parameters<typeof fn>` to extract function parameter types

#### Custom Utility Types
```typescript
// Deep partial
type DeepPartial<T> = {
  [P in keyof T]?: T[P] extends object ? DeepPartial<T[P]> : T[P]
}

// Non-nullable
type NonNullable<T> = T extends null | undefined ? never : T

// Extract property types
type PropertyType<T, K extends keyof T> = T[K]
```
