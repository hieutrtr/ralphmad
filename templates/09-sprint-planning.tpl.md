## BMAD Sprint Planning - Autonomous Mode
### Context
You are working as an autonomous {{persona}} to generate sprint status tracking.
{{#if product_description}}
{{product_description}}
{{/if}}

### Input Documents
- Epics: Scan {{planning_artifacts}}/ for epics*.md files

### Initialization
1. Run {{bmad_workflow}} to start the workflow
2. Automatically discover and parse all epic files

### Autonomous Response Rules
When the workflow requests user input:
- If asking for confirmation: Respond 'confirmed' to proceed
- If asking about epic files: Confirm discovered files are correct
- If asking about validation: Confirm all checks pass

### Workflow Steps

STEP 1 - PARSE EPIC FILES:
- Discover all files matching *epic*.md pattern in {{planning_artifacts}}/
- Could be single epics.md or multiple epic-1.md, epic-2.md files
- Extract epic numbers from headers (## Epic 0:, ## Epic 1:, etc.)
- Extract story IDs and titles (### Story 0.1: Title, ### Story 1.1: Title)
- Convert to kebab-case keys (e.g., 0-1-initialize-project-structure)

STEP 2 - BUILD SPRINT STATUS STRUCTURE:
For each epic found, create entries:
- Epic entry: epic-{num} with status: backlog
- Story entries: {epic}-{story}-{title} with status: backlog
- Retrospective entry: epic-{num}-retrospective with status: optional

STEP 3 - APPLY INTELLIGENT STATUS DETECTION:
- Check if story files exist in {{implementation_artifacts}}/ folder
- If story file exists: upgrade status to ready-for-dev
- Preserve more advanced statuses (never downgrade)

STEP 4 - GENERATE SPRINT-STATUS.YAML:
Create file at: {{implementation_artifacts}}/sprint-status.yaml

STEP 5 - VALIDATE AND REPORT:
- Every epic appears in status file
- Every story appears in status file
- Every epic has retrospective entry
- All status values are legal
- File is valid YAML

### Status State Machine

Epic Status Flow:
backlog -> in-progress -> done

Story Status Flow:
backlog -> ready-for-dev -> in-progress -> review -> done

Retrospective Status:
optional <-> done

### Output Files
- Sprint Status: {{implementation_artifacts}}/sprint-status.yaml

### Exit Condition
Output <promise>{{completion_promise}}</promise> when:
- sprint-status.yaml file is generated AND
- All epics are included AND
- All stories are included AND
- All retrospective entries are included AND
- Validation checks pass AND
- Summary is displayed

### Important Notes
- Maintain the {{persona}} persona throughout
- Process ALL epic files (whole or sharded)
- Use kebab-case for story keys (lowercase, hyphens)
- Never downgrade status (preserve more advanced states)
- Order: epic, its stories, its retrospective, next epic
