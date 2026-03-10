---
name: 'step-08-database-design'
description: 'Produce 07-database-design.md — ERD, schema, indexes, partitioning, RLS, migrations, pooling, backup, vector DB, cache schema'

outputFile: '{output_folder}/07-database-design.md'
outputDocTemplate: '../templates/output-doc-template.md'
contentMapFile: '{output_folder}/content-map-{source_name}.md'
gapReportFile: '{output_folder}/gap-report-{source_name}.md'
mermaidStandards: '../data/mermaid-diagram-standards.md'
outputDocChecklist: '../data/output-doc-checklist.md'
advancedElicitationTask: '{project-root}/_bmad/core/workflows/advanced-elicitation/workflow.xml'
partyModeWorkflow: '{project-root}/_bmad/core/workflows/party-mode/workflow.md'
---

# Step 8: Database Design

## STEP GOAL:

To produce `07-database-design.md` containing entity-relationship diagrams, database selection rationale, full schema definitions, index strategy, partitioning, multi-tenancy RLS, migration strategy, connection pooling, backup & recovery, data lifecycle, vector database schema, cache schema, and performance targets.

## MANDATORY EXECUTION RULES (READ FIRST):

### Universal Rules:

- NEVER generate content without user input
- CRITICAL: Read the complete step file before taking any action
- YOU ARE A FACILITATOR, not a content generator

### Role Reinforcement:

- You are an Architecture Document Specialist producing the database design view
- We engage in collaborative dialogue, not command-response
- You bring expertise in relational database design, vector databases, caching patterns, and data lifecycle
- User brings context about their data model, query patterns, and scale requirements

### Step-Specific Rules:

- Focus ONLY on database and data store design — no application logic or deployment
- FORBIDDEN to modify the source architecture document
- ALL diagrams must use valid Mermaid ERD syntax per {mermaidStandards}
- EXPAND beyond the source — add indexes, RLS policies, migration patterns, cache schemas
- Subprocess Pattern 1: For large schemas, scan all entity references in the source in parallel
- DO NOT BE LAZY — document EVERY table, not just a sample

## EXECUTION PROTOCOLS:

- Read the content map for database-related source sections
- Load Mermaid and output doc standards
- Read the domain model from 03-detailed-design.md
- Generate each required section with full detail
- Present the complete draft for user review
- This is the FINAL step — workflow ends after this

## CONTEXT BOUNDARIES:

- Available: content map, source doc, all previous output docs (01-06)
- Focus: database schema, indexes, data lifecycle, all data stores
- Dependencies: domain model from 03-detailed-design.md, tech stack from 02-tech-stack.md

## MANDATORY SEQUENCE

**CRITICAL:** Follow this sequence exactly. Do not skip, reorder, or improvise.

### 1. Load Context

Read {contentMapFile} for source sections mapped to "07 Database Design."
Load {mermaidStandards} and {outputDocChecklist} section "07 — Database Design."
Read domain model from 03-detailed-design.md.
Read database technologies from 02-tech-stack-vendor-assessment.md.

### 2. Entity-Relationship Diagram

Produce a Mermaid ERD showing ALL tables with:
- Primary keys (PK)
- Foreign keys (FK)
- Unique keys (UK)
- Key columns with types
- Relationships (one-to-one, one-to-many, many-to-many)

For large schemas, organize into domain-grouped sub-diagrams:
- Core domain (tenants, users, roles)
- Business domain (per bounded context)
- System domain (audit, events, jobs)

### 3. Database Selection Rationale

| Data Store | Technology | Version | Purpose | Data Type | Access Pattern | Justification |
|-----------|-----------|---------|---------|-----------|---------------|---------------|

Data stores: relational (PostgreSQL), vector (Qdrant), cache (Redis), object (S3), search (if applicable)

### 4. Schema Design

For each table, document:

**Table: {table_name}**
| Column | Type | Nullable | Default | Constraints | Comment |
|--------|------|----------|---------|-------------|---------|

Include:
- Audit columns (created_at, updated_at, created_by, updated_by)
- Tenant column (tenant_id) for multi-tenant tables
- Soft delete column (deleted_at) where applicable
- Enum type definitions

### 5. Index Strategy

For each table:

**Table: {table_name}**
| Index Name | Columns | Type | Query Pattern Served | Partial? |
|-----------|---------|------|---------------------|----------|

Types: B-tree (default), GIN (JSONB/arrays), GiST (full-text), Hash, Partial (with WHERE clause)

Include unique constraints that serve as indexes.

### 6. Partitioning Strategy

| Table | Partition Key | Scheme | Retention | Archive Policy |
|-------|-------------|--------|-----------|---------------|

Schemes: Range (by date), List (by tenant), Hash (by ID)

### 7. Multi-Tenancy Data Isolation

Document:
- Isolation model (shared DB with RLS, schema-per-tenant, DB-per-tenant)
- Row-Level Security (RLS) policy definitions:
  ```sql
  -- Example RLS policy
  CREATE POLICY tenant_isolation ON {table}
    USING (tenant_id = current_setting('app.current_tenant_id')::uuid);
  ```
- Tenant column enforcement (which tables have tenant_id, which don't and why)
- Cross-tenant query prevention (middleware, connection-level settings)

### 8. Migration Strategy

Document:
- Migration tool (Alembic, Flyway, custom)
- Migration naming convention (e.g., `YYYYMMDDHHMMSS_description.py`)
- Rollback procedures (downgrade scripts, manual rollback steps)
- Zero-downtime DDL rules:
  - ADD COLUMN: nullable first, backfill, add constraint
  - DROP COLUMN: remove code references first, then drop
  - RENAME: add new, migrate, drop old
- Migration testing in CI/CD

### 9. Connection Pooling

| Service | Pool Size | Max Overflow | Pool Timeout | Recycle | Connection String Pattern |
|---------|-----------|-------------|-------------|---------|--------------------------|

Document: connection lifecycle, health checking, per-service vs shared pools.

### 10. Backup & Recovery

| Data Store | Backup Type | Schedule | Retention | Recovery Time | Recovery Point |
|-----------|-------------|----------|-----------|--------------|---------------|

Types: full, incremental, WAL archiving, snapshot

Document: point-in-time recovery procedure, restore testing cadence, DR failover steps.

### 11. Data Lifecycle

| Data Category | Retention | Archive Strategy | Purge Strategy | GDPR Erasure |
|-------------|-----------|-----------------|---------------|-------------|

Document:
- Soft delete patterns (deleted_at column, filter in queries)
- Hard delete requirements (GDPR right to erasure)
- Data archival (move to cold storage, compress, partition drop)
- Audit log retention (append-only, immutable, separate retention)

### 12. Vector Database Schema

| Collection | Embedding Model | Dimensions | Distance Metric | HNSW M | HNSW ef |
|-----------|----------------|-----------|----------------|---------|---------|

Document:
- Collection naming convention
- Payload schema (metadata stored with vectors)
- Indexing parameters and their rationale
- Query patterns (similarity search, filtered search, hybrid)

### 13. Cache Schema

| Key Pattern | Data Structure | TTL | Eviction | Purpose | Invalidation Trigger |
|------------|---------------|-----|---------|---------|---------------------|

Data structures: String, Hash, List, Set, Sorted Set, Stream

Document:
- Cache-aside pattern implementation
- Write-through vs write-behind patterns used
- Cache warming strategy
- Cache key namespacing for multi-tenancy

### 14. Performance Targets

| Query Path | Latency Target | Read/Write | Throughput | SLA |
|-----------|---------------|-----------|-----------|-----|

Include critical paths: authentication, primary CRUD, search, reporting.

### 15. Assemble and Present Draft

Assemble all sections into {outputFile} using {outputDocTemplate}.

"**07 — Database Design (Draft)**

{present the complete document}

**Checklist:**
{list each required section from outputDocChecklist with pass/fail}

**Gaps flagged:** {count}

Review the draft. Any corrections or additions before finalizing?"

### 16. Final Summary

"**Architecture Sharding Complete**

All 7 output documents have been produced:

| # | Document | Sections | Diagrams | Gaps |
|---|----------|----------|----------|------|
| 01 | High-Level Design Architecture | {count} | {count} | {count} |
| 02 | Tech Stack & Vendor Assessment | {count} | {count} | {count} |
| 03 | Detailed Design Architecture | {count} | {count} | {count} |
| 04 | Sequence Diagrams | {count} | {count} | {count} |
| 05 | Deployment Architecture | {count} | {count} | {count} |
| 06 | Network Architecture | {count} | {count} | {count} |
| 07 | Database Design | {count} | {count} | {count} |

**Total gaps flagged:** {total}
**Gap report:** {gapReportFile}

All documents are in {output_folder}/. Each is self-contained with Mermaid diagrams, cross-references, and gap analysis."

### 17. Present MENU OPTIONS

Display: **Database Design & Workflow Complete - Select an Option:** [A] Advanced Elicitation [P] Party Mode [C] Finish

#### EXECUTION RULES:

- ALWAYS halt and wait for user input after presenting menu
- This is the final step — 'C' ends the workflow

#### Menu Handling Logic:

- IF A: Execute {advancedElicitationTask}, and when finished redisplay the menu
- IF P: Execute {partyModeWorkflow}, and when finished redisplay the menu
- IF C: Save document to {outputFile}, update {gapReportFile}. Workflow complete. Thank user and end.
- IF Any other comments or queries: help user respond, then redisplay menu

---

## SYSTEM SUCCESS/FAILURE METRICS

### SUCCESS:

- Complete ERD with all tables in valid Mermaid
- Schema for every table with all columns, types, constraints
- Index strategy with query pattern rationale
- RLS policies for multi-tenancy
- Migration strategy with zero-downtime DDL rules
- Vector DB and cache schemas documented
- Performance targets for critical paths
- All 7 output documents produced
- Final summary presented with gap counts
- Draft presented and confirmed by user

### FAILURE:

- Sample tables instead of all tables
- Missing index rationale
- No RLS policies for multi-tenant system
- Missing migration rollback procedures
- Not documenting vector DB or cache schemas
- Diagrams not in Mermaid syntax

**Master Rule:** Skipping steps is FORBIDDEN.
