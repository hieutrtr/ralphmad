---
name: 'step-06-remediation-plan'
description: 'Compile all gaps into a prioritized remediation plan with specific story recommendations'

outputFile: '{planning_artifacts}/gaps-analysis-report-{{date}}.md'
---

# Step 6: Gap Summary & Prioritized Remediation Plan

## STEP GOAL:

To compile all gaps from Steps 2-5 into a single prioritized remediation plan with concrete recommendations — new stories to add, existing stories to expand, or new epics to create. The output should be directly actionable by the team.

## MANDATORY EXECUTION RULES (READ FIRST):

### Universal Rules:

- 🛑 NEVER generate content without user input
- 📖 CRITICAL: Read the complete step file before taking any action
- 📋 YOU ARE A FACILITATOR providing synthesis, not generating new requirements
- ✅ YOU MUST ALWAYS SPEAK OUTPUT In your Agent communication style with the config `{communication_language}`

### Role Reinforcement:

- ✅ You are a Technical Program Manager delivering an actionable remediation plan
- ✅ Every recommendation must be specific enough to execute
- ✅ Prioritization is based on: what blocks the most work first
- ✅ Success is a plan that prevents sprint-0 surprises

### Step-Specific Rules:

- 🎯 Synthesize — don't repeat all details from previous steps
- 🚫 Don't add new gaps — only compile and prioritize what was found
- 💬 Group related gaps into remediation actions
- 🚪 Be concrete: "Add Story 0.1" not "consider adding infrastructure"

## REMEDIATION PLAN PROCESS:

### 1. Compile All Gaps

Review {outputFile} and collect all gaps from:
- **I-{N}:** Infrastructure & Platform gaps (Step 2)
- **D-{N}:** Dependency & Ordering gaps (Step 3)
- **C-{N}:** Cross-Cutting Concern gaps (Step 4)
- **T-{N}:** Architecture Traceability gaps (Step 5)

### 2. Deduplicate and Merge

Some gaps will overlap across steps:
- Infrastructure gap "no K8s cluster" and traceability gap "AR-12 not traced" are the same root issue
- Merge overlapping gaps and reference all related gap IDs

### 3. Prioritize by Impact

#### Priority 1: Blocks Everything (Must fix before ANY development)
- Infrastructure that all services need
- Shared packages/libraries that all stories import
- Authentication/authorization bootstrap
- Development environment setup

#### Priority 2: Blocks Specific Epics (Must fix before those epics start)
- Service-specific infrastructure
- Missing prerequisite stories
- Cross-epic dependency resolution

#### Priority 3: Blocks Production Readiness (Must fix before release)
- Observability and monitoring setup
- Security hardening
- Performance testing infrastructure
- Operational runbooks

#### Priority 4: Improvement (Should fix, not blocking)
- Documentation gaps
- Configuration management improvements
- Nice-to-have automation

### 4. Generate Remediation Actions

For each priority group, create specific actions:

```markdown
### Action R-{N}: {Action Title}

**Priority:** [P1/P2/P3/P4]
**Resolves Gaps:** [I-1, D-3, T-7] (list all related gap IDs)
**Type:** [New Epic / New Story / Expand Story / Reorder Stories]
**Recommendation:**

[If New Story:]
> **Story {X.Y}: {Title}**
> As a **{role}**, I want {capability}, so that {value}.
> **Key Acceptance Criteria:**
> - {criterion 1}
> - {criterion 2}
> **Suggested Epic:** {which epic to add to}

[If Expand Story:]
> **Expand Story {X.Y}** to include:
> - {additional acceptance criterion}
> - {additional acceptance criterion}

[If New Epic:]
> **Epic 0: {Title}**
> {Goal description}
> Stories: {list of stories}

[If Reorder:]
> Move Story {X.Y} before Story {P.Q} because {reason}
```

### 5. Impact Summary

Calculate overall impact:

```markdown
### Impact Summary

| Metric | Count |
|---|---|
| Total gaps identified | [count] |
| P1 (blocks everything) | [count] |
| P2 (blocks specific epics) | [count] |
| P3 (blocks production) | [count] |
| P4 (improvements) | [count] |
| New stories recommended | [count] |
| Existing stories to expand | [count] |
| New epics recommended | [count] |
| Story reorders needed | [count] |
```

### 6. Finalize Report

Append to {outputFile}:

```markdown
## Gap Summary & Prioritized Remediation Plan

### Overall Gap Statistics

[Impact summary table from section 5]

### Priority 1: Blocks Everything

[All P1 remediation actions from section 4]

### Priority 2: Blocks Specific Epics

[All P2 remediation actions]

### Priority 3: Blocks Production Readiness

[All P3 remediation actions]

### Priority 4: Improvements

[All P4 remediation actions]

### Recommended Execution Order

1. [First thing to do]
2. [Second thing to do]
3. [Continue...]

### Final Assessment

**Current Implementation Readiness:** [Ready / Needs Work / Not Ready]
**After Remediation:** [Expected readiness level]
**Estimated Additional Stories:** [count]
```

Update frontmatter: `stepsCompleted: [1, 2, 3, 4, 5, 6]`, `status: 'complete'`, `completedAt: '{{date}}'`

### 7. Present Completion

Display:
"**Implementation Gaps Analysis Complete**

Report: {outputFile}

**Summary:**
- [X] total gaps identified across [Y] categories
- [A] P1 gaps that block all development
- [B] new stories recommended
- [C] existing stories to expand

The remediation plan provides specific, actionable recommendations to close all gaps before development begins."

### 8. Present Final MENU

Display: **[C] Complete Workflow**

When C selected: Workflow complete.

Implementation Gaps Analysis complete. Read fully and follow: `{project-root}/_bmad/core/tasks/help.md`

Upon completion: offer to answer questions about the gaps or help implement the remediation actions.

---

## 🚨 SYSTEM SUCCESS/FAILURE METRICS

### ✅ SUCCESS:

- All gaps from Steps 2-5 compiled and deduplicated
- Clear priority assignment based on blocking impact
- Concrete remediation actions (not vague suggestions)
- Execution order provided
- Report is self-contained and actionable

### ❌ SYSTEM FAILURE:

- Vague recommendations ("consider adding infrastructure")
- Not deduplicating overlapping gaps
- Priority based on severity alone, not blocking impact
- Missing the execution order
- Recommendations not specific enough to create stories from
