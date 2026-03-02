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
- If asking for mode: Confirm Epic-Level mode (sprint-status.yaml exists)
- If asking for epic number: Specify the target epic number
- If asking for confirmation: Respond 'confirmed' to proceed
- If asking for design level: Select 'full' for comprehensive coverage

### Test Design Process

For the target epic:

1. **Read the epic stories** — extract all stories, their FRs, and acceptance criteria
2. **Identify risk areas** — analyze each story for potential risks
3. **Score risks** — Probability (1-3) x Impact (1-3) = Risk Score
4. **Design test coverage** — map stories to test levels (unit, integration, E2E, contract)
5. **Assign priorities** — P0 (critical), P1 (high), P2 (medium)
6. **Define execution order** — smoke -> P0 -> P1 -> P2

### Risk Categories

- **TECH** (Technical) — Implementation complexity, integration points, state management
- **DATA** (Data Integrity) — Data correctness, persistence, transformation accuracy
- **BUS** (Business Logic) — Business rules, workflow correctness, edge cases
- **UX** (User Experience) — Layout, responsiveness, interactions, accessibility
- **PERF** (Performance) — Rendering, API calls, memory, re-renders
- **SEC** (Security) — Access control, data exposure, injection, authorization
- **OPS** (Operational) — Connection resilience, browser compatibility, storage limits

### Risk Scoring

Risk Score = Probability x Impact

Probability:
  1 = Unlikely (<10%)
  2 = Possible (10-50%)
  3 = Likely (>50%)

Impact:
  1 = Minor (cosmetic, workaround exists)
  2 = Degraded (feature impaired)
  3 = Critical (feature unusable)

Score Thresholds:
  1-2 = Low (monitor)
  3-4 = Medium (plan mitigation)
  6-9 = High (immediate mitigation)

### Test Level Recommendations

**UNIT Tests:**
- Component rendering and behavior
- State management logic
- Utility functions and helpers
- Validation logic

**INTEGRATION Tests:**
- API endpoint interactions
- Data flow between components
- State persistence and retrieval

**E2E Tests (Critical paths):**
- Full user workflows
- Cross-component interactions
- Responsive behavior

**CONTRACT Tests:**
- API response schemas
- Data model field presence

### Priority Assignment

P0 (Critical - blocks feature usage):
- Core functionality must work
- Primary user flow must complete

P1 (High - blocks feature completeness):
- Secondary features work correctly
- Edge cases handled

P2 (Medium - quality assurance):
- Polish, animations, preferences
- Export, sharing, secondary flows

### Output Files
- Test Design: {{implementation_artifacts}}/test-design-epic-{N}.md

### Exit Condition
Output <promise>{{completion_promise}}</promise> when:
- Risk assessment matrix created with all categories AND
- Coverage matrix maps all stories to test levels AND
- Priority levels assigned (P0/P1/P2) AND
- Execution order defined (smoke -> P0 -> P1 -> P2) AND
- Resource estimates provided AND
- Quality gate criteria defined AND
- Output file saved

### Important Notes
- This is Epic-Level mode (Phase 4) since sprint-status.yaml exists
- Analyze ALL stories in the target epic
- Design tests proactively before implementation
- Consider dependencies between stories within the epic
- Use risk categories: SEC, TECH, PERF, DATA, BUS, OPS, UX
- High priority risks (score >= 6) need immediate mitigation
