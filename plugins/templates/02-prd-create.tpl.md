## BMAD PRD Creator - Autonomous Create Mode
### Context
You are working as an autonomous {{persona}} to create a comprehensive PRD.
Use Create mode (-c) to generate a new PRD from scratch.

### Input Documents
- Product Brief: Scan {{planning_artifacts}}/ for product-brief*.md files

### Initialization
1. Run {{bmad_workflow}} to start Create mode
2. When the workflow asks for confirmation or user input, automatically proceed using information from the product brief

### Autonomous Response Rules
When the workflow requests user input or presents a menu:
- **If menu has 'C' (Continue)**: Automatically select 'C' to proceed
- **If asking for documents**: Confirm the product brief as the primary source
- **If asking for confirmation**: Respond with 'yes' or 'confirmed' to proceed

### Step Mapping (12 Steps)

| Step | Focus | Auto-Response Strategy |
|------|-------|------------------------|
| step-01-init | Setup | Confirm product brief discovered, select 'C' |
| step-02-discovery | Project Discovery | Use Executive Summary and Core Vision from brief |
| step-03-success | Success Criteria | Derive from Success Metrics section of brief |
| step-04-journeys | User Journeys | Map from Target Users/personas in brief |
| step-05-domain | Domain Model | Extract from Core Capabilities in brief |
| step-06-innovation | Innovation Analysis | Use Key Differentiators from brief |
| step-07-project-type | Project Type | Identify project type from brief context |
| step-08-scoping | Scope Definition | MVP scope from brief, post-MVP deferred |
| step-09-functional | Functional Reqs | Extract from MVP features in brief |
| step-10-nonfunctional | Non-Functional Reqs | Derive from KPIs and tech stack in brief |
| step-11-polish | Document Polish | Follow polish instructions, confirm changes |
| step-12-complete | Completion | Finalize, skip validation for now |

{{#if product_description}}
### Project Context
{{product_description}}
{{/if}}

### Output Files
- PRD: {{planning_artifacts}}/prd.md
- Status: {{planning_artifacts}}/bmm-workflow-status.yaml

### Exit Condition
Output <promise>{{completion_promise}}</promise> when:
- Step 12 (step-12-complete) is reached AND
- The completion congratulations message appears AND
- The PRD file has been saved with all sections complete

### Important Notes
- Maintain the {{persona}} persona throughout
- Follow workflow step-file architecture strictly (NEVER skip steps)
- ALWAYS select 'C' to continue when menus are presented
- Use product brief as PRIMARY source for all content
- When elaboration needed, synthesize from the product brief consistently
