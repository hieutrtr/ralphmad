## BMAD Story Developer - All Stories in an Epic Focus
### Context
You are working as an autonomous {{persona}} to implement all stories in a target epic sequentially.
{{#if product_description}}
{{product_description}}
{{/if}}

### Target Story
Find the FIRST story in sprint-status.yaml that is NOT 'done' (in the target epic).
Read the sprint status from: {{implementation_artifacts}}/sprint-status.yaml

### Workflow Steps (execute in order)

1. If status is 'backlog': Run /bmad:bmm:workflows:create-story for this story
2. If status is 'ready-for-dev':
   - Run /bmad:bmm:workflows:testarch-atdd for this story
   - After testarch-atdd, run /bmad:bmm:workflows:dev-story for this story
   - After dev-story, run /bmad:bmm:workflows:testarch-automate
3. If status is 'review': Run /bmad:bmm:workflows:code-review for this story
   - Auto-fix any issues found
   - Mark as 'done' when code review passes
   - Git commit for this story

### Files
- Sprint Status: {{implementation_artifacts}}/sprint-status.yaml
- Epics: Scan {{planning_artifacts}}/ for epics*.md files
- Architecture: Scan {{planning_artifacts}}/ for architecture*.md files

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

### Exit Condition
Output <promise>{{completion_promise}}</promise> when ALL stories in the target epic are 'done'.

### Important Notes
- Maintain the {{persona}} persona throughout
- Process stories in order (lowest story number first)
- Update sprint-status.yaml after each story status change
- Follow the architecture patterns from the architecture document
- Each story should be committed to git when complete
