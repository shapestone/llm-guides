# Enhanced Guidance for LLM Code Assistance - Python Specific

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

## Python Guidelines

### Project Structure Guidelines

#### Package Organization
- Use `__init__.py` to define public APIs and control what gets imported with `from package import *`
- Keep implementation details private using underscore prefixes (`_private_function`)
- Organize related functionality into logical packages
- Use `if __name__ == "__main__":` pattern for executable modules
- Place complex interfaces in dedicated modules only when necessary

#### Pythonic Interface Design (Follow This Priority Order)
1. **Duck Typing First**: "If it walks like a duck and quacks like a duck, it's a duck"
2. **`typing.Protocol`**: For structural typing when type hints are needed
3. **`abc.ABC`**: Only for true abstract base classes with shared implementation
- EMBRACE Python's dynamic nature - don't over-engineer interfaces
- FOLLOW "Easier to Ask for Forgiveness than Permission" (EAFP) principle
- PREFER composition over inheritance
- USE context managers (`with` statements) for resource management

#### Pythonic Patterns
- LEVERAGE decorators for cross-cutting concerns
- USE generators and iterators for memory efficiency
- IMPLEMENT dunder methods (`__str__`, `__repr__`, `__len__`, etc.) when creating custom types
- PREFER list/dict/set comprehensions over explicit loops when readable
- USE dataclasses for simple data containers
- IMPLEMENT context managers for resource cleanup

### Type Hinting and Documentation (Gradual Typing Philosophy)
- USE type hints for **public APIs** and **complex function signatures**
- SKIP obvious type hints (e.g., `def get_name() -> str: return "John"`)
- FOCUS type hints where they provide the most value: function boundaries, complex data structures
- USE `typing.Union` → `|` operator (Python 3.10+) when available
- USE `typing.Optional` → `| None` (Python 3.10+) when available
- DOCUMENT complex type relationships with docstrings
- USE `from __future__ import annotations` for forward references when needed

### Import Management (Pythonic Style)
- ORGANIZE imports: standard library, third-party, local (separated by blank lines)
- USE absolute imports for external packages, relative for internal package navigation
- USE `from module import specific_item` for frequently used items
- AVOID `from module import *` except in `__init__.py` for public API definition
- HANDLE circular dependencies through refactoring or late imports

### Error Handling (Pythonic Exception Philosophy)
- FOLLOW "Easier to Ask for Forgiveness than Permission" (EAFP)
- USE `try/except` rather than checking conditions when possible
- CREATE custom exception classes that inherit from appropriate built-in exceptions
- USE exception chaining (`raise NewError() from original_error`) to preserve context
- HANDLE exceptions at the appropriate abstraction level
- BE specific with exception catching - avoid bare `except:` clauses
- PROVIDE meaningful error messages with context

### Testing Architecture (Pragmatic Python Testing)
- DESIGN for Python's dynamic testing capabilities
- USE `unittest.mock` for patching and mocking external dependencies  
- LEVERAGE Python's flexibility - monkey patching is acceptable in tests
- SEPARATE pure business logic from I/O operations for easier testing
- USE pytest fixtures for complex setup, but don't over-engineer
- CONSIDER doctests for simple function documentation and testing
- FOLLOW the principle: make testing easy, don't sacrifice code clarity for "perfect" testability

### Code Style and Conventions (PEP 8 + Pythonic Idioms)
- FOLLOW PEP 8 naming conventions: `snake_case` for variables/functions, `PascalCase` for classes
- USE descriptive names but don't over-verbalize (`items` vs `list_of_items_to_process`)
- PREFER Python idioms:
  - `for item in items:` not `for i in range(len(items)):`
  - `if items:` not `if len(items) > 0:`
  - `item in items` not `items.index(item) >= 0`
- EMBRACE "There should be one obvious way to do it" principle
- USE list/dict comprehensions when they improve readability
- PREFER `pathlib.Path` over `os.path` for file operations
- USE f-strings for string formatting (Python 3.6+)

### File System and I/O Operations
- USE `pathlib.Path` instead of string manipulation for file paths
- LEVERAGE context managers (`with open()`) for automatic resource cleanup
- ABSTRACT file operations behind simple function interfaces (not necessarily formal protocols)
- USE Python's built-in capabilities: `json.load()`, `csv.reader()`, etc.
- DESIGN file operations to work with file-like objects for flexibility
- CONSIDER using `tempfile` module for testing file operations

### Configuration Management
- USE environment variables for deployment-specific settings
- PROVIDE configuration classes with type hints
- VALIDATE configuration at startup
- SEPARATE configuration loading from business logic
