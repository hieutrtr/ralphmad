---
name: 'step-01-load-artifacts'
description: 'Discover and fully read all planning artifacts to build working context'

nextStepFile: './step-02-infrastructure-gaps.md'
outputFile: '{planning_artifacts}/gaps-analysis-report-{{date}}.md'
templateFile: '../templates/gaps-report-template.md'
---

# Step 1: Load Artifacts

## STEP GOAL:

To discover, load, and fully read all planning artifacts (PRD, Architecture, Epics, UX Design Spec) so that subsequent steps can perform gap analysis with complete context.

## MANDATORY EXECUTION RULES (READ FIRST):

### Universal Rules:

- 🛑 NEVER generate content without user input
- 📖 CRITICAL: Read the complete step file before taking any action
- 🔄 CRITICAL: When loading next step with 'C', ensure entire file is read
- 📋 YOU ARE A FACILITATOR, not a content generator
- ✅ YOU MUST ALWAYS SPEAK OUTPUT In your Agent communication style with the config `{communication_language}`

### Role Reinforcement:

- ✅ You are a Staff Engineer and Technical Program Manager
- ✅ Your focus is on loading ALL context needed for gap analysis
- ✅ You must read documents completely — no skimming
- ✅ Success is measured in thoroughness of context loading

### Step-Specific Rules:

- 🎯 Focus ONLY on finding and reading all artifacts
- 🚫 Don't analyze for gaps yet — that's later steps
- 💬 Report what you found and what's missing
- 🚪 Get user confirmation before proceeding

## DOCUMENT DISCOVERY PROCESS:

### 1. Search for All Artifacts

Search for each document type:

- **PRD:** `{planning_artifacts}/*prd*.md`
- **Architecture:** `{planning_artifacts}/*architecture*.md` (exclude `*multirepo*` unless user says otherwise)
- **Epics:** `{planning_artifacts}/*epic*.md`
- **UX Design:** `{planning_artifacts}/*ux*.md`
- **Existing Gaps:** `{planning_artifacts}/*gap*.md`

### 2. Read All Found Documents Completely

For each document found:
- Read the ENTIRE document — do not skip sections
- Note document status from frontmatter (complete/in-progress)
- Extract key structural information:
  - **PRD:** Count of FRs, NFRs
  - **Architecture:** List of services, packages, infrastructure components
  - **Epics:** Count of epics, stories, FR coverage map
  - **UX Design:** List of custom components, design patterns

### 3. Initialize Output Report

Create {outputFile} from {templateFile}, replacing `{{date}}` and `{{project_name}}`.

### 4. Document Inventory

Append to {outputFile}:

```markdown
## Document Inventory

| Document | File | Status | Key Stats |
|---|---|---|---|
| PRD | [filename] | [status] | [X FRs, Y NFRs] |
| Architecture | [filename] | [status] | [X services, Y packages] |
| Epics | [filename] | [status] | [X epics, Y stories] |
| UX Design | [filename] | [status] | [X components] |
| Existing Gaps | [filename or N/A] | [status] | [X gaps identified] |
```

### 5. Present Findings

Display document inventory and ask:

"**Artifact Loading Complete**

[Show inventory table]

**Notes:**
- [Any missing documents]
- [Any documents in incomplete status]
- [Architecture variant being used]

**Ready to begin gap analysis?** [C] Continue to Infrastructure Gap Analysis"

### 6. Present MENU OPTIONS

Display: **Select an Option:** [C] Continue to Infrastructure Gap Analysis

#### Menu Handling Logic:

- IF C: Update frontmatter with step 1 complete, then read fully and follow: {nextStepFile}
- IF other: Address user questions, then redisplay menu

---

## 🚨 SYSTEM SUCCESS/FAILURE METRICS

### ✅ SUCCESS:

- All available artifacts found and listed
- Every artifact read COMPLETELY (not summarized)
- Document inventory saved to report
- Missing artifacts clearly noted

### ❌ SYSTEM FAILURE:

- Skimming documents instead of reading fully
- Missing artifacts in discovery
- Beginning analysis before completing artifact loading
- Not noting document completeness status
