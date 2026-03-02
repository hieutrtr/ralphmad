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

### Step-by-Step Mapping (12 Steps)

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
| step-09-functional | Functional Requirements | Extract from MVP features in brief |
| step-10-nonfunctional | Non-Functional Requirements | Derive from KPIs and Technical Stack in brief |
| step-11-polish | Document Polish | Follow polish instructions, confirm changes |
| step-12-complete | Completion | Finalize, skip validation for now |

### Content Extraction Guide

**For Discovery (step-02):**
- Read the product brief to extract the problem statement, solution vision, and core capabilities
- Summarize the product's unique value proposition

**For Success Criteria (step-03):**
- Extract user metrics and business objectives from the product brief
- Derive KPIs appropriate to the project type

**For User Journeys (step-04):**
- Map personas from the product brief
- Create user journey flows for each persona

**For Domain Model (step-05):**
- Extract core entities from the product's capabilities
- Define relationships and data flows

**For Innovation (step-06):**
- Identify key differentiators from the product brief
- Analyze competitive advantages

**For Functional Requirements (step-09):**
- Extract MVP feature requirements from the brief
- Organize by capability area

**For Non-Functional Requirements (step-10):**
- Derive performance, security, compatibility requirements
- Base on the technical stack and target users from the brief

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
- Use product brief as PRIMARY source
- When elaboration needed, synthesize from the product brief consistently
- MVP scope from the brief defines what's in and what's deferred to post-MVP
