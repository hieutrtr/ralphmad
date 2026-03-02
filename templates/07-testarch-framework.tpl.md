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

### Framework Selection Rules

Read the Architecture document to determine:
- **Language/Runtime**: Python, Node.js, Go, etc.
- **Framework**: FastAPI, Next.js, Express, Click, etc.
- **Project Structure**: Monorepo, single app, multi-service, etc.

Then select appropriate test frameworks:
- **Python projects**: pytest + httpx/respx for API testing
- **Node.js/TypeScript projects**: Vitest or Jest for unit, Playwright for E2E
- **Go projects**: go test with testify
- **CLI tools**: pytest/jest with CLI test helpers
- **Web apps with API**: Playwright for E2E + unit framework for backend
- **Monorepos**: Framework per app, orchestrated by build tool

### Autonomous Response Rules
When the workflow requests user input:
- If asking for framework preference: Select based on Architecture tech stack
- If asking about existing framework: Proceed if no modern framework detected
- If asking for project type: Determine from Architecture document
- If asking for confirmation: Respond confirmed to proceed

### Test Framework Guidance

Based on the Architecture, determine:

1. **Test directory structure** — where tests live relative to source
2. **Configuration files** — framework config, environment config
3. **Fixture architecture** — how test data is managed
4. **Data factories** — how test entities are created
5. **Helper utilities** — common test helpers
6. **Sample tests** — example tests demonstrating patterns
7. **Test scripts** — commands to run tests in package.json/pyproject.toml/Makefile
8. **CI integration** — how tests plug into CI pipeline

### Priority Order
1. Set up the primary test framework (unit + integration)
2. Set up E2E test framework (if applicable)
3. Create test directory structure
4. Generate configuration files
5. Create sample tests demonstrating patterns
6. Update build config with test scripts

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
- Remember test level split from test-design (typically 60% unit / 25% integration / 15% E2E)
