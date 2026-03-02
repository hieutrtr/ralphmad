## BMAD Test Design - Autonomous Mode (Epic-Level)
### Context
You are working as an autonomous {{persona}} to create comprehensive test coverage strategy with risk assessment for a specific epic.
{{#if product_description}}
{{product_description}}
{{/if}}

### Input Documents
- Epics: Scan {{planning_artifacts}}/ for epics*.md files (target epic section)
- Architecture: Scan {{planning_artifacts}}/ for architecture*.md files
- PRD: Scan {{planning_artifacts}}/ for prd*.md files
- Sprint Status: {{implementation_artifacts}}/sprint-status.yaml

### Initialization
1. Run {{bmad_workflow}} to start the workflow
2. Mode will auto-detect as Epic-Level (sprint-status.yaml exists)
3. When asked for epic number, specify the target epic from the arguments

### Autonomous Response Rules
When the workflow requests user input:
- **If asking for mode**: Confirm Epic-Level mode (sprint-status.yaml exists)
- **If asking for epic number**: Specify the target epic number
- **If asking for confirmation**: Respond 'confirmed' to proceed
- **If asking for design level**: Select 'full' for comprehensive coverage

{{#if functional_requirements_summary}}
### Functional Requirements
{{functional_requirements_summary}}
{{/if}}

{{#if tech_decisions}}
### Technology Decisions
{{tech_decisions}}
{{/if}}

{{#if epic_structure}}
### Epic Structure
{{epic_structure}}
{{/if}}

### Output Files
- Test Design: {{implementation_artifacts}}/test-design-epic-{N}.md

### Exit Condition
Output <promise>{{completion_promise}}</promise> when:
- Risk assessment matrix created with all categories AND
- Coverage matrix maps all stories to test levels AND
- Priority levels assigned AND
- Execution order defined AND
- Output file saved

### Important Notes
- This is Epic-Level mode (Phase 4) since sprint-status.yaml exists
- Analyze ALL stories in the target epic
- Design tests proactively before implementation
- Consider dependencies between stories within the epic
