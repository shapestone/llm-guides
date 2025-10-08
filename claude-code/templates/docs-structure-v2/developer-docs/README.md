# Developer Documentation (Published)

**Owner:** documentation-engineer agent
**Publishing target:** developers.yourproduct.com or api.yourproduct.com
**Audience:** Developers integrating with your API/SDK

## Purpose

Documentation for external developers who want to integrate with your API, use your SDKs, or build on your platform.

## Structure

```
developer-docs/
├── index.md                  # Developer portal homepage
├── getting-started.md        # Quick start for API users
├── api/
│   ├── reference/           # API reference documentation
│   │   ├── openapi.yaml    # OpenAPI/Swagger spec
│   │   └── endpoints/      # Detailed endpoint docs
│   └── guides/              # API usage guides
│       ├── authentication.md
│       ├── pagination.md
│       ├── rate-limiting.md
│       └── webhooks.md
├── sdk/                      # SDK documentation (if applicable)
│   ├── javascript.md
│   ├── python.md
│   └── go.md
└── changelog.md              # API changelog
```

## Content Guidelines

### Writing Style
- Technical but accessible
- Include code examples in multiple languages
- Show request/response examples
- Link to live API playground if available

### What to Include
- API reference documentation
- Authentication guides
- Quick start tutorials
- SDK installation and usage
- Code examples
- Error codes and handling
- Rate limits and quotas
- Webhook setup guides
- API versioning and changelog

### What NOT to Include
- Internal implementation details
- Security threat models
- Internal deployment procedures
- Performance benchmarks (internal)

## API Reference

### OpenAPI Specification

Keep your OpenAPI/Swagger spec in `api/reference/openapi.yaml`:

```yaml
# developer-docs/api/reference/openapi.yaml
openapi: 3.0.0
info:
  title: Your API
  version: 1.0.0
paths:
  /users:
    get:
      summary: List users
      # ... endpoint definition
```

### Auto-Generated Docs

You can auto-generate API reference from OpenAPI spec using tools like:
- Redoc
- Swagger UI
- Stoplight Elements

## Publishing

This directory is typically published using:
- Docusaurus
- VitePress
- Redoc/Swagger UI (for API reference)
- GitBook
- ReadMe.io

## See Also

- [Document Project Layout](../../reference-documentation/document-project-layout.md)
- [documentation-engineer agent](../../agents/documentation/documentation-engineer.md)
