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
- If asking for CI platform: Select GitHub Actions (primary platform)
- If asking update or create new: Select 'create new' if none exists
- If asking about notifications: Configure Slack notifications (optional, can be skipped)
- If asking for confirmation: Respond 'yes' to proceed

### Step-by-Step Execution

STEP 1 - PREFLIGHT CHECKS:
1. Verify Git repository (.git/ exists, remote configured)
2. Validate test framework exists (check for test config files)
3. Check for existing CI configuration (.github/workflows/)
4. Read project config files for language/runtime versions

STEP 2 - SCAFFOLD CI PIPELINE:
Create CI pipeline configuration based on the project's tech stack:
- Determine pipeline stages from the test framework setup
- Include: lint, unit test, integration test, E2E test (if applicable), report
- Configure appropriate language runtimes and service containers

STEP 3 - CONFIGURE CACHING:
- Cache package manager stores (npm, pip, pnpm, uv, etc.)
- Cache test framework assets (Playwright browsers, etc.)
- Use appropriate cache keys based on lock files

STEP 4 - CREATE HELPER SCRIPTS:
- Script to run tests for changed files only
- Script to mirror CI execution locally
- Script for burn-in execution (repeat tests N times for flaky detection)
- Make all scripts executable (chmod +x)

STEP 5 - CREATE DOCUMENTATION:
- Pipeline stages and purpose
- How to run locally
- Debugging failed CI runs
- Required secrets and environment variables
- Badge URLs for README

STEP 6 - PROJECT-SPECIFIC ADAPTATIONS:
Based on the Architecture, handle:
- Monorepo vs single-app structure
- Language-specific test runners
- Service containers (databases, caches, etc.)
- Environment variable management

### Technical Specifications

Derive from Architecture:
- CI Platform: GitHub Actions (default)
- Language versions from project config files
- Package managers from project setup
- Test runners from test framework setup
- Service containers from Architecture decisions

Pipeline Triggers:
- push to main/master, develop
- pull_request to main/master, develop
- schedule: weekly for burn-in

Concurrency:
- group: workflow-ref
- cancel-in-progress: true

### Performance Targets
- Lint stage: <3 minutes
- Unit tests: <10 minutes
- Integration tests: <10 minutes
- E2E tests: <15 minutes per shard
- Total pipeline: <30 minutes (with parallelism)

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
- Service containers should match Architecture decisions
