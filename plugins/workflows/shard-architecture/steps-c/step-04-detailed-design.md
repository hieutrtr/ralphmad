---
name: 'step-04-detailed-design'
description: 'Produce 03-detailed-design.md — C4 L3 components, API contracts, domain model, state machines, error handling, caching, multi-tenancy'

nextStepFile: './step-05-sequence-diagrams.md'
outputFile: '{output_folder}/03-detailed-design.md'
outputDocTemplate: '../templates/output-doc-template.md'
contentMapFile: '{output_folder}/content-map-{source_name}.md'
gapReportFile: '{output_folder}/gap-report-{source_name}.md'
mermaidStandards: '../data/mermaid-diagram-standards.md'
outputDocChecklist: '../data/output-doc-checklist.md'
advancedElicitationTask: '{project-root}/_bmad/core/workflows/advanced-elicitation/workflow.xml'
partyModeWorkflow: '{project-root}/_bmad/core/workflows/party-mode/workflow.md'
---

# Step 4: Detailed Design Architecture

## STEP GOAL:

To produce `03-detailed-design.md` containing C4 Level 3 component diagrams for each major container, API contract specifications, service communication patterns, domain model, state machines, error handling strategy, caching strategy, configuration management, feature flags, multi-tenancy implementation, and naming conventions.

## MANDATORY EXECUTION RULES (READ FIRST):

### Universal Rules:

- NEVER generate content without user input
- CRITICAL: Read the complete step file before taking any action
- CRITICAL: When loading next step with 'C', ensure entire file is read
- YOU ARE A FACILITATOR, not a content generator

### Role Reinforcement:

- You are an Architecture Document Specialist producing the detailed design view
- We engage in collaborative dialogue, not command-response
- You bring expertise in component design, API contracts, domain modeling, and resilience patterns
- User brings context about their domain model, business rules, and implementation preferences

### Step-Specific Rules:

- Focus ONLY on detailed design — no deployment, network, or database schema details
- FORBIDDEN to modify the source architecture document
- ALL diagrams must use valid Mermaid syntax per {mermaidStandards}
- EXPAND beyond the source — add component interfaces, state transitions, error codes
- Subprocess Pattern 1: For large architectures, scan all API endpoints and patterns in parallel

## EXECUTION PROTOCOLS:

- Read the content map for relevant source sections
- Load Mermaid diagram standards
- Generate each required section
- Present the complete draft for user review
- FORBIDDEN to load next step until user selects 'C'

## CONTEXT BOUNDARIES:

- Available: content map, source document, 01-high-level-design.md, 02-tech-stack.md
- Focus: detailed component design, API contracts, domain model, patterns
- Dependencies: content map from step 1, container diagram from step 2

## MANDATORY SEQUENCE

**CRITICAL:** Follow this sequence exactly. Do not skip, reorder, or improvise.

### 1. Load Context

Read {contentMapFile} and identify all source sections mapped to "03 Detailed Design."
Load {mermaidStandards} and {outputDocChecklist} section "03 — Detailed Design Architecture."
Read the C4 Level 2 container diagram from 01-high-level-design.md for reference.

### 2. Component Diagrams (C4 Level 3)

For each major container identified in the Level 2 diagram, produce a Mermaid component diagram showing:
- Internal components (routers, services, repositories, middleware, workers)
- Interfaces between components
- External dependencies consumed by each component

### 3. API Contract Specifications

For each API boundary, document:

| Endpoint | Method | Auth | Request Schema | Response Schema | Status Codes | Rate Limit |
|----------|--------|------|---------------|----------------|-------------|-----------|

Group by API router/domain. Include request/response schema descriptions (key fields, types, constraints).

### 4. Service-to-Service Communication

Document each service-to-service interaction:

| From | To | Protocol | Pattern | Payload | Timeout | Retry |
|------|-----|----------|---------|---------|---------|-------|

Patterns: sync REST, async event, gRPC, WebSocket, SSE

### 5. Domain Model

Produce a Mermaid class diagram or ERD showing:
- Entities with key attributes
- Value objects
- Aggregates and their roots
- Relationships (one-to-many, many-to-many, composition, inheritance)

### 6. State Machines

For each stateful entity, produce a Mermaid state diagram:
- All states
- Transitions with trigger events
- Guards/conditions
- Entry/exit actions

### 7. Error Handling Strategy

Document:
- Error code taxonomy (ranges, categories, meanings)
- Retry policies per error type (retryable vs terminal, backoff strategy)
- Circuit breaker configuration (thresholds, timeouts, fallbacks)
- Dead letter queue handling
- Error response format (standard envelope)

### 8. Caching Strategy

| Cache Layer | Technology | What's Cached | TTL | Invalidation | Hit Rate Target |
|------------|-----------|---------------|-----|-------------|----------------|

### 9. Configuration Management

Document how configuration flows:
- Environment variables → service configuration
- Secrets management (vault, K8s secrets, external secrets operator)
- Feature flags (implementation pattern, flag store, rollout strategy)
- Configuration hierarchy (defaults → environment → overrides)

### 10. Multi-Tenancy Implementation

Document:
- Isolation model (shared database with RLS, schema-per-tenant, database-per-tenant)
- Tenant context propagation (header → middleware → service → repository → query)
- Cross-tenant prevention mechanisms
- Tenant-specific configuration

### 11. Naming Conventions and Coding Standards

Extract from source and organize:

| Context | Convention | Example |
|---------|-----------|---------|
| Database tables | | |
| API endpoints | | |
| Python code | | |
| TypeScript code | | |
| Events | | |
| Environment vars | | |

### 12. Assemble and Present Draft

Assemble all sections into {outputFile} using {outputDocTemplate}.

"**03 — Detailed Design Architecture (Draft)**

{present the complete document}

**Checklist:**
{list each required section from outputDocChecklist with pass/fail}

**Gaps flagged:** {count}

Review the draft. Any corrections or additions before finalizing?"

### 13. Present MENU OPTIONS

Display: **Detailed Design Complete - Select an Option:** [A] Advanced Elicitation [P] Party Mode [C] Continue to Sequence Diagrams

#### EXECUTION RULES:

- ALWAYS halt and wait for user input after presenting menu
- ONLY proceed to next step when user selects 'C'
- After other menu items execution, return to this menu

#### Menu Handling Logic:

- IF A: Execute {advancedElicitationTask}, and when finished redisplay the menu
- IF P: Execute {partyModeWorkflow}, and when finished redisplay the menu
- IF C: Save document to {outputFile}, update {gapReportFile}, then load, read entire file, then execute {nextStepFile}
- IF Any other comments or queries: help user respond, then redisplay menu

---

## SYSTEM SUCCESS/FAILURE METRICS

### SUCCESS:

- C4 Level 3 diagrams for every major container in valid Mermaid
- API contracts for every API boundary
- Domain model with entities, aggregates, relationships
- State machines for stateful entities
- Error handling, caching, config, multi-tenancy documented
- Naming conventions extracted and organized
- Draft presented and confirmed by user

### FAILURE:

- Missing component diagrams for containers
- API contracts without schema descriptions
- Not documenting error handling strategy
- Diagrams not in Mermaid syntax
- Copying source without expansion

**Master Rule:** Skipping steps is FORBIDDEN.
