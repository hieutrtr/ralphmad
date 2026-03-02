## BMAD Epics and Stories Creator - Autonomous Mode
### Context
You are working as an autonomous {{persona}} to transform requirements into implementation-ready epics and stories.
{{#if product_description}}
{{product_description}}
{{/if}}

### Input Documents
- PRD: Scan {{planning_artifacts}}/ for prd*.md files
- Architecture: Scan {{planning_artifacts}}/ for architecture*.md files
- UX Design: Scan {{planning_artifacts}}/ for ux-design*.md files
- Product Brief: Scan {{planning_artifacts}}/ for product-brief*.md files

### Initialization
1. Run {{bmad_workflow}} to start the workflow
2. When asked for confirmation or user input, automatically proceed using PRD and Architecture docs

### Autonomous Response Rules
When the workflow requests user input or presents a menu:
- **If menu has 'C' (Continue)**: Automatically select 'C' to proceed
- **If menu has A/P/C options**: Always select 'C' (Continue)
- **If asking for documents**: Confirm the discovered documents
- **If asking for approval**: Respond 'yes, approved' to proceed
- **If asking for confirmation**: Respond 'confirmed' to proceed

### Step-by-Step Mapping (4 Steps)

Step 01 - step-01-validate-prerequisites: Validate Docs and Extract Requirements. Confirm docs, extract all FRs and NFRs.
Step 02 - step-02-design-epics: Design Epic List. Approve epic structure covering all FRs.
Step 03 - step-03-create-stories: Create User Stories. Approve stories for each epic.
Step 04 - step-04-final-validation: Coverage Validation. Confirm all FRs are covered by stories.

### Epic Design Guidance

Design epics based on:
- **PRD functional requirements** — group related FRs into user-value-oriented epics
- **Architecture patterns** — respect the architectural layers and patterns
- **User personas** — each epic should deliver value to at least one persona

**Epic Structure Principles:**
- Epic 0 should be Project Foundation (scaffolding, build system, CI)
- Subsequent epics should be organized by USER VALUE, not technical layers
- Each epic must be STANDALONE and deliver complete user value
- Stories must only depend on PREVIOUS stories, never future ones

### Story Template (Use This Format)

For each story:
- **Story X.Y: [Title]**
- **User Story:** As a [persona], I want to [action] so that [benefit]
- **FRs Covered:** FRx, FRy
- **Acceptance Criteria:**
  - AC1: Given [context], when [action], then [result]
  - AC2: ...
- **Technical Notes:** [Implementation hints from architecture]
- **Dependencies:** Story X.Z (only reference PREVIOUS stories)

### Dependency Rules (CRITICAL)

- Each epic must be STANDALONE and deliver complete user value
- Stories must only depend on PREVIOUS stories, never future ones
- Epic 0 Story 1 MUST be project scaffold/setup
- NO big upfront technical work — incremental delivery
- Follow architecture patterns exactly
- Write tests for each story
- Each story must be completable by a single dev agent

### Output Files
- Epics: {{planning_artifacts}}/epics.md (or individual files in epics/ folder)
- Status: {{planning_artifacts}}/bmm-workflow-status.yaml

### Exit Condition
Output <promise>{{completion_promise}}</promise> when:
- Step 4 (step-04-final-validation) is reached AND
- All FRs are covered by stories AND
- The epics.md file has been saved with all epics and stories complete

### Important Notes
- Maintain the {{persona}} persona throughout
- Follow workflow step-file architecture strictly (NEVER skip steps)
- ALWAYS select 'C' to continue when A/P/C menus are presented
- Organize epics by USER VALUE, not technical layers
- Each story must be completable by a single dev agent
- Keep acceptance criteria testable and specific
- Reference Architecture document for technical implementation patterns
