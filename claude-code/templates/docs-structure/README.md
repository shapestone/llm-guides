# Documentation Structure Template

This directory provides a template for the standardized documentation structure.

## Usage

Copy this structure to your project's `docs/` directory:

```bash
# From your project root
cp -r /path/to/llm-guides/claude-code/templates/docs-structure/* docs/
```

Or create directories as needed (recommended - don't create until needed):

```bash
# Only create directories for documentation you actually have
mkdir -p docs/architecture/decisions
mkdir -p docs/product/requirements
mkdir -p docs/guides/developer
```

## Structure

Each subdirectory contains a README.md explaining:
- Purpose of the directory
- Which agent owns it
- What documents go there
- Naming conventions
- Examples

## See Also

- [Document Project Layout Guide](../../reference-documentation/document-project-layout.md)
- [Migration Guide](../../MIGRATION-GUIDE.md)
