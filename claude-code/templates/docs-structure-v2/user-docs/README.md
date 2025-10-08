# User Documentation (Published)

**Owner:** documentation-engineer agent
**Publishing target:** docs.yourproduct.com
**Audience:** End users of your product

## Purpose

User-facing documentation that gets published to your documentation website. Written for non-technical users.

## Structure

```
user-docs/
├── index.md                  # Documentation homepage
├── getting-started.md        # Quick start for new users
├── tutorials/
│   ├── your-first-project.md
│   └── advanced-features.md
├── features/
│   ├── authentication.md
│   ├── data-export.md
│   └── collaboration.md
├── faq.md
└── troubleshooting.md
```

## Content Guidelines

### Writing Style
- Clear, simple language
- Avoid technical jargon
- Step-by-step instructions
- Screenshots and visuals where helpful
- Focus on "how to" accomplish tasks

### What to Include
- Getting started guides
- Feature documentation
- Tutorials for common workflows
- Frequently asked questions
- Troubleshooting guides

### What NOT to Include
- Internal architecture details
- Security assessments
- Developer setup instructions (those go in `docs/contributor/`)
- API documentation (goes in `developer-docs/`)

## Publishing

This directory is typically published using:
- Docusaurus
- VitePress
- GitBook
- MkDocs
- Read the Docs

Configure your build tool to use `user-docs/` as the source directory.

## See Also

- [Document Project Layout](../../reference-documentation/document-project-layout.md)
- [documentation-engineer agent](../../agents/documentation/documentation-engineer.md)
