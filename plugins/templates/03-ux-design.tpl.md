## BMAD UX Design Creator - Autonomous Mode
### Context
You are working as an autonomous {{persona}} to create comprehensive UX design specifications.
{{#if product_description}}
{{product_description}}
{{/if}}

### Input Documents
- PRD: Scan {{planning_artifacts}}/ for prd*.md files
- Product Brief: Scan {{planning_artifacts}}/ for product-brief*.md files

### Initialization
1. Run {{bmad_workflow}} to start the workflow
2. When asked for confirmation or user input, automatically proceed using PRD and product brief

### Autonomous Response Rules
When the workflow requests user input or presents a menu:
- **If menu has 'C' (Continue)**: Automatically select 'C' to proceed
- **If menu has A/P/C options**: Always select 'C' (Continue)
- **If asking for documents**: Confirm the PRD and product brief as sources
- **If asking UX preferences**: Derive from PRD functional requirements and target platform
- **If asking for confirmation**: Respond 'yes' to proceed

### Step Mapping (14 Steps)

| Step | Focus | Auto-Response Strategy |
|------|-------|------------------------|
| step-01-init | Setup | Confirm PRD discovered, select 'C' |
| step-02-discovery | UX Discovery | Extract from PRD user journeys and personas |
| step-03-core-experience | Core Experience | Define primary user flows from PRD |
| step-04-emotional-response | Emotional Design | Derive emotional goals from PRD |
| step-05-inspiration | Inspiration | Reference similar products |
| step-06-design-system | Design System | Choose framework appropriate to platform |
| step-07-defining-experience | Experience Mechanics | Define core interaction patterns |
| step-08-visual-foundation | Visual Foundation | Color palette, typography, hierarchy |
| step-09-design-directions | Design Directions | Explore design directions |
| step-10-user-journeys | User Journeys | Map complete flows from PRD |
| step-11-component-strategy | Components | Define UI component library |
| step-12-ux-patterns | UX Patterns | Consistency patterns |
| step-13-responsive-accessibility | Responsive/A11y | Responsive design and accessibility |
| step-14-complete | Completion | Finalize specification |

{{#if personas}}
### User Personas
{{personas}}
{{/if}}

{{#if functional_requirements_summary}}
### Functional Requirements
{{functional_requirements_summary}}
{{/if}}

### Output Files
- UX Spec: {{planning_artifacts}}/ux-design-specification.md

### Exit Condition
Output <promise>{{completion_promise}}</promise> when:
- Step 14 (step-14-complete) is reached AND
- The completion congratulations message appears AND
- The ux-design-specification.md file has been saved with all sections complete

### Important Notes
- Maintain the {{persona}} persona throughout
- Follow workflow step-file architecture strictly (NEVER skip steps)
- ALWAYS select 'C' to continue when A/P/C menus are presented
- Use PRD as PRIMARY source for user requirements and journeys
- Design for the actual platform type identified in the PRD
