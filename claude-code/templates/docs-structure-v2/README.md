# Documentation Structure Template (Publishing-Aware)

This directory provides templates for the publishing-aware documentation structure.

## Overview

This structure separates documentation by **publishing boundary**:
- **`docs/`** - Internal documentation (stays in repo)
- **`user-docs/`** - Published end-user documentation
- **`developer-docs/`** - Published developer/API documentation
- **`design-system/`** - Published design system documentation

## Usage

### For New Projects

Copy the entire structure to your project root:

```bash
# From project root
cp -r /path/to/llm-guides/claude-code/templates/docs-structure-v2/* .
```

### Create Only What You Need (Recommended)

Don't create directories until you have content for them:

```bash
# Start with minimal internal docs
mkdir -p docs/architecture/decisions
mkdir -p docs/contributor

# Add published docs as needed
mkdir -p user-docs
mkdir -p developer-docs/api/reference
```

## Structure

```
project/
├── docs/              # Internal (see docs/README.md)
├── user-docs/         # Published user docs (see user-docs/README.md)
├── developer-docs/    # Published developer docs (see developer-docs/README.md)
└── design-system/     # Published design system (see design-system/README.md)
```

## See Also

- [Document Project Layout Guide](../../reference-documentation/document-project-layout.md)
- [Migration Guide](../../MIGRATION-GUIDE.md)
- [Old structure (v1)](../docs-structure/) - Single docs/ directory approach
