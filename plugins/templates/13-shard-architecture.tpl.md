## Shard Architecture - Autonomous Mode
### Context
You are working as an autonomous {{persona}} to decompose a monolithic architecture document into 7 focused sub-documents.
{{#if product_description}}
{{product_description}}
{{/if}}

### Input Documents
- Architecture: Scan {{planning_artifacts}}/ for architecture*.md files

### Initialization
1. Load and read the full workflow file at {{bmad_workflow}}, then follow its instructions
2. When asked for the source document path, provide the architecture document found above
3. When asked for confirmation or user input, automatically proceed

### Autonomous Response Rules
When the workflow requests user input or presents a menu:
- **If menu has 'C' (Continue)**: Automatically select 'C' to proceed
- **If asking for source document path**: Provide the path to the architecture document discovered above
- **If asking for confirmation**: Respond 'yes' to proceed
- **If asking about content map or gaps**: Confirm and select 'C' to continue

### Step Mapping (8 Steps)

| Step | Focus | Auto-Response Strategy |
|------|-------|------------------------|
| step-01-parse-source | Parse & Map | Provide architecture doc path, confirm content map, select 'C' |
| step-02-high-level-design | High-Level Design | Let workflow generate, confirm, select 'C' |
| step-03-tech-stack | Tech Stack Assessment | Let workflow generate, confirm, select 'C' |
| step-04-detailed-design | Detailed Design | Let workflow generate, confirm, select 'C' |
| step-05-sequence-diagrams | Sequence Diagrams | Let workflow generate, confirm, select 'C' |
| step-06-deployment | Deployment Architecture | Let workflow generate, confirm, select 'C' |
| step-07-network | Network Architecture | Let workflow generate, confirm, select 'C' |
| step-08-database-design | Database Design | Let workflow generate, finalize |

{{#if tech_decisions}}
### Technology Decisions
{{tech_decisions}}
{{/if}}

### Output Files
- 7 sub-documents written to {{planning_artifacts}}/
- Gap report and content map

### Exit Condition
Output <promise>{{completion_promise}}</promise> when:
- All 8 steps have been completed AND
- All 7 output sub-documents have been saved AND
- The database design document (step 8) is finalized

### Important Notes
- Maintain the {{persona}} persona throughout
- Follow workflow step-file architecture strictly (NEVER skip steps)
- ALWAYS select 'C' to continue when menus are presented
- ALL diagrams MUST use valid Mermaid syntax — no ASCII art, no PlantUML
