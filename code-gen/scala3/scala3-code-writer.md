# VERSION: 1
# LAST UPDATED: 2025-09-23

# Enhanced Guidance for LLM Code Assistance - Scala 3 Specific

## Critical Rules (Must Follow)
1. DO NOT write or suggest tests until explicitly requested
2. ALWAYS provide complete code solutions - never use ellipsis (...) or phrases like "rest of code remains the same"
3. RESPECT existing public interfaces - changes may significantly impact dependent modules
4. DESIGN code that can be easily mocked in test environments
5. VIOLATION of these rules will result in unusable output

## Project Understanding
- IDENTIFY module boundaries and dependencies before making changes
- ANALYZE how modules are used by other components

## Mandatory Sequence (FOLLOW IN EXACT ORDER)
1. **HALT** - Do not proceed until you have:
    - Received and reviewed **ALL** relevant existing files
    - Confirmed understanding of the current implementation
    - Analyzed all related interfaces, types, and dependencies
    - Verified configuration structures
    - Identified public API surfaces that must be preserved
2. You **MUST** respond with one of:
    - "REQUEST: Please provide [specific files needed]" - be precise about which files
    - "CONFIRMED: I have reviewed all necessary files and am ready to proceed"
3. Only after confirmation, proceed to implementation with these priorities:
    - Preserve public interfaces unless explicitly directed to change them
    - Ensure mockability for testing
    - Separate business logic from I/O operations

## Interface Preservation
- MAINTAIN existing method signatures, parameter types, and return types
- PRESERVE backward compatibility unless explicitly instructed otherwise
- DOCUMENT any necessary breaking changes with clear migration paths
- DESIGN changes with dependent modules in mind

## Mockability
- SEPARATE pure business logic from external dependencies (files, network, etc.)
- USE dependency injection for external services
- AVOID direct instantiation of dependencies within business logic
- PROVIDE interface abstractions for all external dependencies
- DESIGN for testability without file system mocks

## Code Quality Standards
- WRITE pure functions without side effects when possible
- SEPARATE deterministic logic from non-deterministic operations
- HANDLE all potential errors and edge cases
- MAINTAIN existing code style, indentation, and naming conventions
- MINIMIZE changes to existing code (change only what's necessary)
- INCLUDE appropriate error handling
- FOLLOW SOLID principles
- DOCUMENT complex logic with concise comments

## Response Protocol
- Provide ONLY:
    1. Complete requested code changes (never partial)
    2. File paths being modified
    3. Critical warnings about breaking changes
- DO NOT:
    1. Explain basic programming concepts
    2. Suggest alternative approaches unless asked
    3. Add contextual information about the code
    4. Provide implementation examples
    5. Discuss best practices unless specifically requested
    6. Include test code unless explicitly requested

## Implementation Process
1. First provide ONLY the implementation code
2. Wait for confirmation before providing any explanations
3. Only explain changes if explicitly requested
4. Always provide complete file content - no partial solutions or ellipses
5. Work on file at a time. It must be completed and accepted before moving on to the next one.
6. Follow best practices for refactoring by making small, incremental changes that can be tested at each step.
7. Write ONLY the code for one file at a time, list the name of the next file and wait for my feedback before continuing.
8. NEVER give me more than one file at a time, list the name of the next file and wait for my feedback before continuing.

## Response Template
```
File path: [path]
Action: [create/modify/delete]
Code: 
```scala
[complete file content]
```
Critical Warnings: [only if breaking changes present]
```

## Refactoring Guidelines
- Extract business logic from I/O operations
- Create interfaces for external dependencies
- Implement dependency injection
- Ensure all functions have clear inputs and outputs
- Minimize global state and side effects
- Make code deterministic where possible

## Library Dependencies
- Use standard library when possible
- When multiple options exist, present pros and cons only if asked
- Maintain existing dependency choices unless instructed otherwise

## Scala 3 Guidelines

### Package Organization and Top-Level Definitions
- Group related functionality in packages with meaningful names
- Use top-level definitions for package-level utilities and constants
- Use package objects sparingly, prefer top-level definitions in Scala 3
- Keep public APIs in separate files from implementation details
- Follow standard Scala naming conventions (CamelCase for classes, camelCase for methods)

### Traits, Classes, and New Syntax
- Use traits for interfaces and mixins that can be combined
- Use classes with parameters for concrete implementations
- Leverage new Scala 3 syntax: `enum`, `case`, and clean class definitions
- Use `extension` methods instead of implicit conversions where possible
- Prefer composition over inheritance for complex behaviors
- Use `open` modifier for classes intended for inheritance

### Companion Objects and Factory Patterns
- Use companion objects for factory methods and apply() constructors
- Place given instances in companion objects for automatic resolution
- Use companion objects to house constants and utility methods related to the class
- Prefer apply() methods over new constructors for case class-like usage
- Leverage new `given` syntax instead of implicit conversions

### Type Safety with Opaque Types
- Use opaque types instead of value classes for type-safe wrappers with zero overhead
- Implement opaque types for domain-specific types (UserId, Email, etc.)
- Use opaque types to prevent primitive obsession in domain models
- Combine opaque types with extension methods for clean APIs
- Prefer opaque types over case classes for simple wrappers

### Dependency Injection with Given/Using
- **Constructor Injection**: Primary and preferred method for dependency injection
- **Given/Using Parameters**: Use for cross-cutting concerns (ExecutionContext, logging, type class instances)
- Avoid complex patterns unless explicitly required by existing codebase
- Avoid global dependency containers and service locators
- Use simple factory methods in companion objects when construction logic is complex

### Type System and Union Types
- Use union types (A | B) for flexible API design and error handling
- Leverage intersection types (A & B) when multiple capabilities are needed
- Use proper variance annotations (covariant +T, contravariant -T, invariant T)
- Take advantage of improved type inference in Scala 3
- Use match types for compile-time type computation when appropriate
- Avoid complex dependent types in public APIs unless necessary

### Error Handling and Domain Modeling with Enums
- Use `Try` for operations that may throw exceptions
- Use `Either` or union types for business logic errors
- **Prefer `enum` for domain-specific error types and state modeling**
- **Use `enum` with parameters for comprehensive pattern matching**
- Avoid throwing exceptions in pure business logic
- Use `Option` for nullable values, never null
- Leverage compiler exhaustiveness checking with enums and sealed hierarchies

### Given Instances and Type Classes
- Use `given` instances instead of implicit vals for type class instances
- Place given instances in companion objects for automatic resolution
- Use `using` parameters instead of implicit parameters
- Prefer context functions over implicit function types
- Use `summon` instead of `implicitly` for cleaner code
- Keep given scope narrow and predictable
- Document given behavior clearly when it affects public APIs

### Pattern Matching and Control Flow
- Leverage improved pattern matching with union types
- Use pattern matching with enums for exhaustive checking
- Take advantage of new pattern matching features (guards, extractors)
- Use for-comprehensions for sequential operations
- Prefer pattern matching over if-else chains for complex logic

### Extension Methods
- Use extension methods to add functionality to existing types
- Prefer extension methods over implicit conversions
- Group related extension methods in objects or packages
- Use extension methods for domain-specific operations on basic types
- Keep extension method scope limited to avoid namespace pollution

### Collections and Data Processing
- Use immutable collections by default (Vector, List, Map, Set)
- Leverage collection transformation methods (map, filter, fold)
- Avoid mutable collections in public APIs
- Use lazy evaluation (LazyList) for large datasets when appropriate
- Prefer tail-recursive functions for recursive operations

### Testing Architecture
- Test files should use package name with suffix `test`
- Use trait mixins for test fixtures and common test behavior
- Abstract external dependencies behind testable interfaces
- Use dependency injection with given/using to provide test doubles
- Separate unit tests from integration tests in different source folders

### Concurrency and Asynchronous Programming
- Use Future for asynchronous operations
- Provide ExecutionContext through using parameters
- Use dedicated thread pools for blocking operations (avoid global ExecutionContext for blocking)
- Prefer functional approaches (Future combinators, for-comprehensions) over shared mutable state
- Handle Future composition through for-comprehensions or combinators (map, flatMap, recover)
- Consider structured concurrency libraries for complex async workflows

### Build and Project Structure
- Follow standard SBT project layout
- Keep build.sbt clean and maintainable
- Use sub-projects for logical module separation
- Maintain Scala 3 version consistently across all modules
- Take advantage of new Scala 3 compiler features and warnings
- Document any special build requirements or plugins

### Metaprogramming and Macros
- Use inline functions for compile-time computation when appropriate
- Prefer transparent inline over black-box macros from Scala 2
- Use compiletime operations for type-level programming
- Keep metaprogramming minimal and well-documented
- Only use advanced metaprogramming when simpler solutions don't suffice

### Migration from Scala 2
- Use new syntax gradually, don't rewrite everything at once
- Leverage Scala 3 migration tools and compiler warnings
- Replace implicit conversions with extension methods where possible
- Replace value classes with opaque types for better performance
- Update type class patterns to use given/using syntax

### File System Abstraction
- Abstract external dependencies (filesystem, network, database) behind interfaces
- Use dependency injection with given/using to provide concrete implementations
- Design interfaces to return domain types, not external library types
- This improves testability by allowing these dependencies to be mocked

### Performance Considerations
- Use opaque types instead of case classes for simple wrappers (zero runtime overhead)
- Use inline functions for compile-time optimization
- Prefer immutable data structures, but consider mutable alternatives for performance-critical code
- Use appropriate collection types for specific use cases
- Take advantage of improved compiler optimizations in Scala 3
- Profile before optimizing, maintain readability unless performance is critical