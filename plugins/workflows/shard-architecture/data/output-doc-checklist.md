# Output Document Required Sections Checklist

Checklist for verifying every output document has all required sections.

## Universal Requirements (All Documents)

- [ ] Frontmatter with: title, source_document, date_generated, status
- [ ] Table of contents
- [ ] Source section references (heading paths back to source)
- [ ] All diagrams in valid Mermaid syntax
- [ ] Gaps & Open Questions section
- [ ] Cross-References section linking to related output docs
- [ ] Self-contained — readable without source document
- [ ] Expands beyond source — not just copied sections

## 01 — High-Level Design Architecture

- [ ] System context diagram (C4 Level 1) in Mermaid
- [ ] Container diagram (C4 Level 2) in Mermaid
- [ ] Key architectural drivers (business goals, quality attributes, constraints)
- [ ] Architecture style rationale
- [ ] Domain boundaries and bounded contexts
- [ ] Data flow overview
- [ ] Non-functional requirements summary with quantified targets
- [ ] Cross-cutting concerns overview
- [ ] Architecture decision records (ADRs)

## 02 — Tech Stack & Vendor Assessment

- [ ] Complete technology inventory with exact versions
- [ ] Per-technology: category, role, license, maturity, community health
- [ ] Vendor lock-in risk assessment (low/medium/high + mitigation)
- [ ] Alternative technologies comparison matrix
- [ ] Version compatibility matrix
- [ ] Upgrade path analysis
- [ ] Cost analysis (licensing, hosting, operational)
- [ ] Security posture per vendor
- [ ] Support & SLA comparison
- [ ] Technology radar classification (Adopt/Trial/Assess/Hold)

## 03 — Detailed Design Architecture

- [ ] Component diagrams (C4 Level 3) in Mermaid
- [ ] API contract specifications
- [ ] Service-to-service communication patterns
- [ ] Domain model (entities, value objects, aggregates)
- [ ] State machines for stateful entities
- [ ] Error handling strategy
- [ ] Caching strategy
- [ ] Configuration management
- [ ] Feature flag strategy
- [ ] Multi-tenancy implementation
- [ ] Naming conventions and coding standards

## 04 — Sequence Diagrams

- [ ] Authentication flow (login, token refresh, logout)
- [ ] Primary CRUD operation lifecycle
- [ ] Real-time data flow (SSE/WebSocket)
- [ ] Background job / async processing
- [ ] Multi-tenant request routing
- [ ] Webhook delivery lifecycle
- [ ] Admin operation (provisioning or config change)
- [ ] All diagrams use alt/opt/loop fragments
- [ ] Timing annotations where latency targets exist

## 05 — Deployment Architecture

- [ ] Infrastructure topology diagram in Mermaid
- [ ] Kubernetes resource specifications
- [ ] Container image strategy
- [ ] Helm chart structure
- [ ] CI/CD pipeline architecture
- [ ] Deployment strategies (blue/green, canary, rolling)
- [ ] Environment topology (dev/staging/prod)
- [ ] Resource sizing (CPU/memory per service)
- [ ] Health checks (liveness, readiness, startup)
- [ ] Local development setup
- [ ] Disaster recovery (RTO/RPO, backup, failover)
- [ ] Infrastructure as Code

## 06 — Network Architecture

- [ ] Network topology diagram in Mermaid
- [ ] Ingress architecture (LB, TLS, WAF, rate limiting)
- [ ] Service mesh configuration
- [ ] DNS strategy
- [ ] Network policies (Kubernetes NetworkPolicies)
- [ ] Firewall rules per tier
- [ ] API gateway configuration
- [ ] Inter-service communication
- [ ] External integration networking
- [ ] Observability networking
- [ ] Security zones
- [ ] CDN configuration

## 07 — Database Design

- [ ] Entity-relationship diagram in Mermaid
- [ ] Database selection rationale per data store
- [ ] Schema design (tables, columns, types, constraints)
- [ ] Index strategy with rationale
- [ ] Partitioning strategy
- [ ] Multi-tenancy data isolation (RLS)
- [ ] Migration strategy
- [ ] Connection pooling
- [ ] Backup & recovery
- [ ] Data lifecycle (archival, soft delete, GDPR)
- [ ] Vector database schema
- [ ] Cache schema (Redis)
- [ ] Performance targets
