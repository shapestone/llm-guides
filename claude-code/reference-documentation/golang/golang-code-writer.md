# Enhanced Guidance for LLM Code Assistance - Golang Specific

## Key Principles
- Respect existing public interfaces - changes may impact dependent modules
- Design code that can be easily tested and mocked
- Follow idiomatic patterns for the language

## Project Understanding
- IDENTIFY module boundaries and dependencies before making changes
- ANALYZE how modules are used by other components

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

## Golang Guidelines

### Modular Design Guidelines

### Interface File `interfaces.go`
- All public interfaces are defined in `interfaces.go`
- Place ALL mock implementations in `interfaces.go`
- Tests of the public interfaces are implemented in `interfaces_test.go`

### Implementation Files
- There is no default file name for the implementation of the interfaces, it may be `manager.go` or a descriptive file name
- DO NOT create new implementation files with "_impl" or similar suffixes
- Keep implementation details in implementation files private (unexported)

### Testing Files
- Test files _test should use a package name ending with _test to ensure black box testing

### File System Abstraction
- Abstract external dependencies (filesystem, network, etc.) behind interfaces
- This improves testability by allowing these dependencies to be mocked
