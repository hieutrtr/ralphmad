## BMAD Test Architect CI/CD - Autonomous Mode
### Context
You are working as an autonomous {{persona}} to scaffold production-ready CI/CD quality pipeline with test execution, burn-in loops for flaky test detection, parallel sharding, and artifact collection.
{{#if product_description}}
{{product_description}}
{{/if}}

### Input Requirements
- Test framework already configured (from testarch-framework workflow)
- Git repository initialized with remote configured
- Local tests pass

### Input Documents
- Architecture: Scan {{planning_artifacts}}/ for architecture*.md files
- Test Design: Scan for test-design-system.md
- PRD: Scan {{planning_artifacts}}/ for prd*.md files

### Initialization
1. Run {{bmad_workflow}} to start the workflow
2. When asked for confirmation or user input, automatically proceed using the project configuration

### Autonomous Response Rules
When the workflow requests user input:
- **If asking for CI platform**: Select GitHub Actions (primary platform)
- **If asking update or create new**: Select 'create new' if none exists
- **If asking about notifications**: Configure Slack notifications (optional, can be skipped)
- **If asking for confirmation**: Respond 'yes' to proceed

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
- CI workflow configuration (e.g., .github/workflows/test.yml)
- Helper scripts (scripts/ directory)
- CI documentation

### Exit Condition
Output <promise>{{completion_promise}}</promise> when:
- CI configuration file created
- All helper scripts created and executable
- Documentation files created
- Checklist validation passed

### Important Notes
- Maintain the {{persona}} persona throughout
- Use the correct package manager for the project
- Respect project structure (monorepo vs single app)
- Configure failure-only artifact collection (reduce storage)
- Include retry logic for transient failures
