## BMAD Test Framework Setup - Autonomous Mode
### Context
You are working as an autonomous {{persona}} to initialize production-ready test framework architecture.
{{#if product_description}}
{{product_description}}
{{/if}}

### Input Documents
- Architecture: Scan {{planning_artifacts}}/ for architecture*.md files
- Test Design: Scan for test-design-system.md in {{planning_artifacts}}/ or {{implementation_artifacts}}/
- PRD: Scan {{planning_artifacts}}/ for prd*.md files
- Epics: Scan {{planning_artifacts}}/ for epics*.md files

### Initialization
1. Run {{bmad_workflow}} to start the workflow
2. When asked for framework preference, select based on the project's tech stack from Architecture

### Autonomous Response Rules
When the workflow requests user input:
- **If asking for framework preference**: Select based on Architecture tech stack
- **If asking about existing framework**: Proceed if no modern framework detected
- **If asking for project type**: Determine from Architecture document
- **If asking for confirmation**: Respond 'confirmed' to proceed

{{#if tech_decisions}}
### Technology Decisions
{{tech_decisions}}
{{/if}}

{{#if architecture_patterns}}
### Architecture Patterns
{{architecture_patterns}}
{{/if}}

{{#if project_structure}}
### Project Structure
{{project_structure}}
{{/if}}

### Output Files
- Test framework configuration files
- Test directory structure
- Sample tests
- Test documentation

### Exit Condition
Output <promise>{{completion_promise}}</promise> when:
- All test directories created AND
- Configuration files generated AND
- Sample tests created AND
- Build config updated with test scripts AND
- README documentation written

### Important Notes
- Maintain the {{persona}} persona throughout
- Use the tech stack from the Architecture document
- Follow the fixture architecture pattern (pure functions + composition)
- Configure failure-only artifact capture for E2E tests
