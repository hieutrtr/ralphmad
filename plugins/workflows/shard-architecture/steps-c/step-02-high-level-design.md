---
name: 'step-02-high-level-design'
description: 'Produce 01-high-level-design.md — C4 diagrams, ADRs, architectural drivers, domain boundaries, data flow'

nextStepFile: './step-03-tech-stack.md'
outputFile: '{output_folder}/01-high-level-design.md'
outputDocTemplate: '../templates/output-doc-template.md'
contentMapFile: '{output_folder}/content-map-{source_name}.md'
gapReportFile: '{output_folder}/gap-report-{source_name}.md'
mermaidStandards: '../data/mermaid-diagram-standards.md'
outputDocChecklist: '../data/output-doc-checklist.md'
advancedElicitationTask: '{project-root}/_bmad/core/workflows/advanced-elicitation/workflow.xml'
partyModeWorkflow: '{project-root}/_bmad/core/workflows/party-mode/workflow.md'
---

# Step 2: High-Level Design Architecture

## STEP GOAL:

To produce `01-high-level-design.md` containing C4 Level 1 and Level 2 diagrams, architectural drivers, architecture style rationale, domain boundaries, data flow overview, NFR summary, cross-cutting concerns, and architecture decision records — all in Mermaid syntax, expanded beyond the source document.

## MANDATORY EXECUTION RULES (READ FIRST):

### Universal Rules:

- NEVER generate content without user input
- CRITICAL: Read the complete step file before taking any action
- CRITICAL: When loading next step with 'C', ensure entire file is read
- YOU ARE A FACILITATOR, not a content generator

### Role Reinforcement:

- You are an Architecture Document Specialist producing the high-level design view
- We engage in collaborative dialogue, not command-response
- You bring expertise in C4 modeling, architectural decision records, and quality attribute analysis
- User brings context about business goals, constraints, and architectural intent

### Step-Specific Rules:

- Focus ONLY on high-level design — no detailed component design, deployment, or database topics
- FORBIDDEN to modify the source architecture document
- ALL diagrams must use valid Mermaid syntax per {mermaidStandards}
- EXPAND beyond the source — add context, rationale, trade-offs not in the original
- Flag gaps where source is silent on required high-level design topics

## EXECUTION PROTOCOLS:

- Read the content map to identify relevant source sections
- Load Mermaid diagram standards
- Generate each required section with diagrams
- Present the complete draft for user review
- FORBIDDEN to load next step until user selects 'C'

## CONTEXT BOUNDARIES:

- Available: content map from step 1, source architecture document, gap report
- Focus: high-level design only — C4 L1/L2, ADRs, drivers, domain boundaries
- Dependencies: content map from step 1

## MANDATORY SEQUENCE

**CRITICAL:** Follow this sequence exactly. Do not skip, reorder, or improvise.

### 1. Load Context

Read {contentMapFile} and identify all source sections mapped to "01 High-Level Design."
Load {mermaidStandards} for diagram formatting rules.
Load {outputDocChecklist} section "01 — High-Level Design Architecture" for required sections.

### 2. System Context Diagram (C4 Level 1)

From the source architecture, produce a Mermaid C4 Level 1 diagram showing:
- The system as a single box
- All external actors (users, admins, API consumers)
- All external systems (identity providers, cloud services, third-party APIs)
- Relationships with labeled edges

**Expansion:** If the source only lists actors or systems in text, infer relationships from the architectural description.

### 3. Container Diagram (C4 Level 2)

Produce a Mermaid C4 Level 2 diagram showing:
- All major containers within the system boundary (services, apps, databases, caches, message brokers, object stores)
- Technology annotations on each container (e.g., "FastAPI", "Next.js", "PostgreSQL")
- Relationships between containers with communication protocol labels
- External actors/systems from L1 diagram with their entry points

### 4. Architectural Drivers

Extract and expand:
- **Business goals** driving architectural decisions
- **Quality attributes** with quantified targets (latency <200ms, uptime 99.9%, etc.)
- **Constraints** (technical, regulatory, organizational)
- **Assumptions** (explicit and implicit)

**Expansion:** If source lists NFRs without quantified targets, flag as gap and provide industry-standard recommendations.

### 5. Architecture Style Rationale

Document:
- The chosen architecture style(s) (microservices, modular monolith, event-driven, etc.)
- Why this style was chosen over alternatives
- Trade-offs accepted (e.g., distributed complexity in exchange for independent deployability)
- How the style maps to the quality attributes

### 6. Domain Boundaries and Bounded Contexts

Document:
- Domain decomposition into bounded contexts
- Context map showing relationships between domains
- Communication patterns between contexts (shared kernel, anti-corruption layer, etc.)
- Data ownership per context

### 7. Data Flow Overview

Produce a Mermaid diagram showing:
- How data enters the system (API requests, events, imports)
- Major transformations (processing, enrichment, aggregation)
- How data exits the system (API responses, events, exports, notifications)
- Data stores involved at each stage

### 8. Non-Functional Requirements Summary

Present a table of NFRs with quantified targets:

| Category | Requirement | Target | Measurement |
|----------|------------|--------|-------------|

Categories: Performance, Scalability, Reliability, Security, Observability, Integration

### 9. Cross-Cutting Concerns

Summarize how these concerns are handled across all containers:
- Authentication & Authorization
- Observability (logging, metrics, tracing)
- Error handling & resilience
- Configuration management
- Multi-tenancy

### 10. Architecture Decision Records

For each architectural decision found in the source, expand to full ADR format:

**ADR-{ID}: {Title}**
- **Status:** {Accepted/Proposed/Deprecated}
- **Context:** {what problem or need prompted this decision}
- **Options Considered:** {list of alternatives evaluated}
- **Decision:** {what was chosen and why}
- **Consequences:** {positive and negative impacts}
- **Trade-offs:** {what was given up for what was gained}

### 11. Assemble and Present Draft

Assemble all sections into {outputFile} using {outputDocTemplate}.

"**01 — High-Level Design Architecture (Draft)**

{present the complete document}

**Checklist:**
{list each required section from outputDocChecklist with pass/fail}

**Gaps flagged:** {count}

Review the draft. Any corrections or additions before finalizing?"

### 12. Present MENU OPTIONS

Display: **High-Level Design Complete - Select an Option:** [A] Advanced Elicitation [P] Party Mode [C] Continue to Tech Stack & Vendor Assessment

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

- C4 Level 1 and Level 2 diagrams in valid Mermaid syntax
- All architectural drivers documented with quantified targets
- Architecture style rationale with alternatives considered
- Domain boundaries mapped
- All ADRs expanded to full format
- Draft presented and confirmed by user
- Output document written

### FAILURE:

- Missing required sections from the checklist
- Diagrams not in Mermaid syntax
- Copying source without expansion
- Not flagging gaps
- Modifying source document

**Master Rule:** Skipping steps is FORBIDDEN.
