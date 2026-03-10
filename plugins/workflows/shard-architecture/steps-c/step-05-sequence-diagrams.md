---
name: 'step-05-sequence-diagrams'
description: 'Produce 04-sequence-diagrams.md — Mermaid sequences for auth, CRUD, real-time, async, multi-tenant, webhooks, admin flows'

nextStepFile: './step-06-deployment.md'
outputFile: '{output_folder}/04-sequence-diagrams.md'
outputDocTemplate: '../templates/output-doc-template.md'
contentMapFile: '{output_folder}/content-map-{source_name}.md'
gapReportFile: '{output_folder}/gap-report-{source_name}.md'
mermaidStandards: '../data/mermaid-diagram-standards.md'
outputDocChecklist: '../data/output-doc-checklist.md'
advancedElicitationTask: '{project-root}/_bmad/core/workflows/advanced-elicitation/workflow.xml'
partyModeWorkflow: '{project-root}/_bmad/core/workflows/party-mode/workflow.md'
---

# Step 5: Sequence Diagrams

## STEP GOAL:

To produce `04-sequence-diagrams.md` containing detailed Mermaid sequence diagrams for every significant user journey and system interaction — including authentication, CRUD operations, real-time data flow, background processing, multi-tenant routing, webhook delivery, and admin operations — with alt/opt/loop fragments and timing annotations.

## MANDATORY EXECUTION RULES (READ FIRST):

### Universal Rules:

- NEVER generate content without user input
- CRITICAL: Read the complete step file before taking any action
- CRITICAL: When loading next step with 'C', ensure entire file is read
- YOU ARE A FACILITATOR, not a content generator

### Role Reinforcement:

- You are an Architecture Document Specialist producing interaction sequences
- We engage in collaborative dialogue, not command-response
- You bring expertise in sequence diagram authoring, interaction patterns, and flow analysis
- User brings context about their specific flows, edge cases, and latency requirements

### Step-Specific Rules:

- Focus ONLY on sequence diagrams — use detailed design and API contracts as input
- FORBIDDEN to modify the source architecture document
- ALL diagrams must use valid Mermaid sequence diagram syntax per {mermaidStandards}
- Every diagram MUST include alt/opt/loop fragments for conditional/repeated flows
- Include timing annotations where latency targets exist in NFRs
- DO NOT BE LAZY — produce ALL required diagrams, not just a sample

## EXECUTION PROTOCOLS:

- Read the content map, API contracts, and service communication patterns
- Identify all significant interactions
- Generate each diagram with full detail
- Present the complete draft for user review
- FORBIDDEN to load next step until user selects 'C'

## CONTEXT BOUNDARIES:

- Available: content map, source doc, 01-high-level-design.md, 02-tech-stack.md, 03-detailed-design.md
- Focus: interaction sequences only — using previous outputs as source of truth
- Dependencies: API contracts and service communication from step 4

## MANDATORY SEQUENCE

**CRITICAL:** Follow this sequence exactly. Do not skip, reorder, or improvise.

### 1. Load Context

Read {contentMapFile} for source sections mapped to "04 Sequence Diagrams."
Load {mermaidStandards} for sequence diagram formatting.
Load {outputDocChecklist} section "04 — Sequence Diagrams" for required diagrams.
Read 03-detailed-design.md for API contracts and service communication patterns.

### 2. Identify All Interactions

From the source architecture and detailed design, list every significant interaction:

| # | Flow Name | Actors | Services Involved | Type | Latency Target |
|---|-----------|--------|-------------------|------|---------------|

Types: request-response, async event, real-time push, background job, admin operation

### 3. Authentication Flow

Produce a Mermaid sequence diagram showing:
- User login (credential submission → token issuance)
- Token refresh flow
- Logout / token revocation
- Include: API gateway, auth service, identity provider, token store
- alt fragments: valid/invalid credentials, expired/active token
- Timing: response time targets from NFRs

### 4. Primary CRUD Operation

Produce a Mermaid sequence diagram showing the full lifecycle:
- CREATE: client → gateway → auth → service → repository → database → event publish
- READ: client → gateway → cache check → service → repository → database
- UPDATE: client → gateway → auth → service → validation → repository → database → event
- DELETE: client → gateway → auth → service → soft-delete → database → event
- Include: cache hits/misses, validation errors, concurrent modification handling

### 5. Real-Time Data Flow

Produce a Mermaid sequence diagram showing:
- SSE or WebSocket connection establishment
- Server-side event publication (from a service action)
- Event routing to connected clients
- Connection heartbeat / keep-alive
- Disconnection and reconnection handling
- Include: event bus, subscription management, client filtering

### 6. Background Job / Async Processing

Produce a Mermaid sequence diagram showing:
- Job submission (API request → queue publish)
- Worker pickup and execution
- Progress reporting
- Completion notification (event, callback, status update)
- Error handling and retry
- Include: message broker, worker pool, dead letter queue

### 7. Multi-Tenant Request Routing

Produce a Mermaid sequence diagram showing:
- Request with tenant context (header, subdomain, path)
- Tenant identification and validation
- Tenant context propagation through service layers
- Database query with RLS / tenant filter
- Response scoped to tenant
- alt fragment: invalid tenant, suspended tenant

### 8. Webhook Delivery Lifecycle

Produce a Mermaid sequence diagram showing:
- Triggering event occurs
- Webhook payload construction
- Delivery attempt with signing
- Retry on failure (exponential backoff)
- Dead letter after max retries
- Webhook verification endpoint
- Include: webhook registry, delivery queue, signing key management

### 9. Admin Operation

Produce a Mermaid sequence diagram showing:
- Admin initiates operation (tenant provisioning, configuration change, or user management)
- Authorization check (admin role verification)
- Operation execution with audit logging
- Cascading effects (e.g., new tenant → create namespace, seed data, configure integrations)
- Confirmation and notification

### 10. Additional Diagrams (If Applicable)

Review the source architecture for any additional significant interactions not covered above. Common additions:
- File upload processing
- Search / vector query flow
- Reporting / analytics generation
- Migration / data import flow

### 11. Assemble and Present Draft

Assemble all diagrams into {outputFile} using {outputDocTemplate}.

For each diagram, include:
- Title and description
- Participants list
- The Mermaid diagram
- Notes on error paths and edge cases
- Latency targets (where applicable)

"**04 — Sequence Diagrams (Draft)**

{present the complete document}

**Checklist:**
{list each required diagram from outputDocChecklist with pass/fail}

**Total diagrams:** {count}
**Gaps flagged:** {count}

Review the draft. Any corrections or additions before finalizing?"

### 12. Present MENU OPTIONS

Display: **Sequence Diagrams Complete - Select an Option:** [A] Advanced Elicitation [P] Party Mode [C] Continue to Deployment Architecture

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

- All 7+ required sequence diagrams produced in valid Mermaid
- Every diagram uses alt/opt/loop fragments for conditional flows
- Timing annotations present where latency targets exist
- Error paths shown in every diagram
- All participants labeled with technology
- Draft presented and confirmed by user

### FAILURE:

- Missing required diagrams
- Diagrams without alt/opt fragments
- Happy path only (no error paths)
- Invalid Mermaid syntax
- Producing only a sample instead of all required diagrams

**Master Rule:** Skipping steps is FORBIDDEN.
