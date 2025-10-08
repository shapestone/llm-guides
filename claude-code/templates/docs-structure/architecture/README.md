# Architecture Documentation

**Owner:** system-architect agent

## Purpose

System architecture, design decisions, and technical specifications.

## Subdirectories

### decisions/
Architecture Decision Records (ADRs) - append-only log of architectural decisions.

**Naming:** `NNNN-short-description.md` (e.g., `0001-use-postgresql.md`)

**When to create:**
- Choosing technologies or frameworks
- Significant architectural changes
- Trade-off decisions

### diagrams/
Visual representations of system architecture.

**Examples:**
- `context-diagram.md` - C4 Context diagram
- `container-diagram.md` - C4 Container diagram
- `component-diagrams/auth-service.md` - Component diagrams
- `sequence-diagrams/login-flow.md` - Sequence diagrams

### specifications/
Detailed technical design documents.

**Examples:**
- `system-overview.md` - High-level system architecture
- `api-design.md` - API design patterns
- `integration-patterns.md` - How services integrate
- `data-flow.md` - Data flow through the system

## See Also

- [ADR Template](../../../reference-documentation/document-project-layout.md#architecture-decision-record-adr)
- [system-architect agent](../../../agents/architecture/system-architect.md)
