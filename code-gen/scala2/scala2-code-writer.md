# VERSION: 1
# LAST UPDATED: 2025-09-23

# Enhanced Guidance for LLM Code Assistance - Scala 2 Specific

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

## Scala 2 Guidelines

### Package Organization
- Group related functionality in packages with meaningful names
- Use package objects sparingly for package-level utilities and type aliases
- Keep public APIs in separate files from implementation details
- Follow standard Scala naming conventions (CamelCase for classes, camelCase for methods)

### Companion Objects and Factory Patterns
- Use companion objects for factory methods and apply() constructors
- Place implicit instances and conversions in companion objects for automatic resolution
- Use companion objects to house constants and utility methods related to the class
- Prefer apply() methods over new constructors for case class-like usage
- Keep implicit conversions in companion objects minimal and well-documented
- Use traits for interfaces and mixins that can be combined
- Use abstract classes when constructor parameters are needed
- Prefer composition over inheritance for complex behaviors
- Design traits to be stackable when appropriate
- Keep trait dependencies explicit through self-types or abstract members

### Dependency Injection Patterns
- **Constructor Injection**: Primary and preferred method for dependency injection
- **Implicit Parameters**: Use for cross-cutting concerns (ExecutionContext, logging, type class instances)
- Avoid complex patterns like Cake Pattern unless explicitly required by existing codebase
- Avoid global dependency containers and service locators
- Use simple factory methods in companion objects when construction logic is complex

### Type System for Mockability
- Use generic type parameters to allow mock substitution
- Leverage type classes for behavior abstraction (prefer over inheritance)
- Apply variance annotations correctly (covariant +T, contravariant -T, invariant T)
- Use bounded type parameters to constrain dependencies appropriately
- Avoid path-dependent types in public APIs unless necessary
- Design with proper variance to enable substitution and testing

### Error Handling and Domain Modeling
- Use `Try` for operations that may throw exceptions
- Use `Either` for business logic errors with meaningful left types
- **Prefer sealed trait ADTs for domain-specific error types and state modeling**
- **Use sealed traits with case classes/objects for comprehensive pattern matching**
- Avoid throwing exceptions in pure business logic
- Use `Option` for nullable values, never null
- Leverage compiler exhaustiveness checking with sealed hierarchies

### Functional Programming Principles
- Separate pure functions from side effects
- Use immutable data structures by default
- Leverage case classes for data modeling
- Use pattern matching for control flow when appropriate
- Prefer function composition over inheritance
- Use for-comprehensions for sequential operations

### Collections and Data Processing
- Use immutable collections by default (Vector, List, Map, Set)
- Leverage collection transformation methods (map, filter, fold)
- Avoid mutable collections in public APIs
- Use lazy evaluation (View, Stream) for large datasets when appropriate
- Prefer tail-recursive functions for recursive operations

### Testing Architecture
- Test files should use package name with suffix `test`
- Use trait mixins for test fixtures and common test behavior
- Abstract external dependencies behind testable interfaces
- Use dependency injection to provide test doubles
- Separate unit tests from integration tests in different source folders

### Concurrency and Asynchronous Programming
- Use Future for asynchronous operations
- Provide explicit ExecutionContext through implicit parameters
- Use dedicated thread pools for blocking operations (avoid global ExecutionContext for blocking)
- Prefer functional approaches (Future combinators, for-comprehensions) over shared mutable state
- Handle Future composition through for-comprehensions or combinators (map, flatMap, recover)
- Use Akka actors only when message-passing concurrency is specifically required

### Implicit Parameters and Type Classes
- Use implicit parameters for ExecutionContext, type class instances, and configuration
- Keep implicit scope narrow and predictable
- Prefer type classes over inheritance for polymorphic behavior
- Place implicit instances in companion objects for automatic resolution
- Use context bounds (A: TypeClass) for cleaner method signatures
- Avoid implicit conversions except in well-justified cases
- Document implicit behavior clearly when it affects public APIs
- Follow standard SBT project layout
- Keep build.sbt clean and maintainable
- Use sub-projects for logical module separation
- Maintain consistent Scala version across all modules
- Document any special build requirements or plugins

### File System Abstraction
- Abstract external dependencies (filesystem, network, database) behind interfaces
- Use dependency injection to provide concrete implementations
- Design interfaces to return domain types, not external library types
- This improves testability by allowing these dependencies to be mocked

### Performance Considerations
- Avoid creating unnecessary objects in hot code paths
- Use lazy evaluation for expensive computations that may not be needed
- Prefer tail recursion over regular recursion for large datasets
- Use appropriate collection types for specific use cases
- Profile before optimizing, maintain readability unless performance is critical