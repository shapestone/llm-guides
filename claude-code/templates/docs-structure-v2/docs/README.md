# Internal Documentation

**Audience:** Internal team only (never published)

## Purpose

Documentation that stays in the repository for internal team use only. This includes architecture decisions, security assessments, performance benchmarks, and other materials that should not be made public.

## Structure

```
docs/
├── architecture/      # System architecture & ADRs
├── product/           # Product requirements & roadmap
├── security/          # Security assessments & threat models
├── performance/       # Performance benchmarks
├── database/          # Database schema & migrations
├── project/           # Project planning & reports
├── operations/        # Runbooks & deployment procedures
└── contributor/       # For code contributors (setup, testing, etc.)
```

## Subdirectories

Each subdirectory has its own README explaining:
- Purpose
- Which agent owns it
- What documents go there
- Naming conventions

See the READMEs in each subdirectory for details.

## Publishing

**IMPORTANT:** Documents in this directory should NEVER be published externally. They are for internal team use only.

If you need to publish documentation, use:
- `user-docs/` for end-user documentation
- `developer-docs/` for API/SDK documentation
- `design-system/` for design system documentation

## See Also

- [Document Project Layout](../../reference-documentation/document-project-layout.md)
- Published documentation templates in `../user-docs/`, `../developer-docs/`, `../design-system/`
