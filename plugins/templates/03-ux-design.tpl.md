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
- **If asking UX preferences**: See UX Decisions section below
- **If asking for confirmation**: Respond 'yes' to proceed

### Step-by-Step Mapping (14 Steps)

| Step | Focus | Auto-Response Strategy |
|------|-------|------------------------|
| step-01-init | Setup | Confirm PRD discovered, select 'C' |
| step-02-discovery | UX Discovery | Extract from PRD user journeys and personas |
| step-03-core-experience | Core Experience | Define primary user flows from PRD |
| step-04-emotional-response | Emotional Design | Define emotional goals for key interactions |
| step-05-inspiration | Inspiration | Reference similar products and design patterns |
| step-06-design-system | Design System | Choose appropriate design framework for project type |
| step-07-defining-experience | Experience Mechanics | Define core interaction patterns |
| step-08-visual-foundation | Visual Foundation | Color palette, typography, visual hierarchy |
| step-09-design-directions | Design Directions | Explore design direction options |
| step-10-user-journeys | User Journeys | Map complete user flows from PRD |
| step-11-component-strategy | Components | Define UI component library |
| step-12-ux-patterns | UX Patterns | Consistency patterns across the product |
| step-13-responsive-accessibility | Responsive/A11y | Responsive design and accessibility |
| step-14-complete | Completion | Finalize specification |

### UX Decisions (Use These When Asked)

Extract from the PRD and product brief:
- **Target Platform**: Determine from PRD (web app, mobile, CLI, desktop, etc.)
- **Target Languages**: From project config or default to English
- **Core User Actions**: Extract from PRD functional requirements
- **Primary User Personas**: From PRD user journeys
- **Emotional Goals**: Derive from product value proposition
- **Design System Choice**: Appropriate to the platform (e.g., Material, Tailwind, Rich for CLI)
- **Visual Style**: Appropriate to product type and target audience
- **Key Interactions**: Map from PRD's core user flows

### Content Extraction from PRD

**For Discovery (step-02):**
- Extract primary users and their needs from PRD
- Identify pain points being solved

**For Core Experience (step-03):**
- Define the hero experience (most important user flow)
- Map secondary flows

**For Emotional Response (step-04):**
- Define how users should feel at each key interaction point

**For Components (step-11):**
- Define UI components needed to support the user flows

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
- The hero experience is the most important flow — design it excellently
- Consider both interactive and non-interactive/automated modes if applicable
- Error messages must be actionable: what failed, why, and what to do next
