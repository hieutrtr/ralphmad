---
name: 'step-03-dependency-gaps'
description: 'Analyze story dependencies and ordering to find implicit assumptions, circular dependencies, and missing prerequisite stories'

nextStepFile: './step-04-cross-cutting-gaps.md'
outputFile: '{planning_artifacts}/gaps-analysis-report-{{date}}.md'
---

# Step 3: Story Dependency & Ordering Gaps

## STEP GOAL:

To analyze the dependency graph between stories — both within and across epics — finding implicit assumptions, missing prerequisite stories, circular dependencies, and ordering problems that would block parallel development.

## MANDATORY EXECUTION RULES (READ FIRST):

### Universal Rules:

- 🛑 NEVER generate content without user input
- 📖 CRITICAL: Read the complete step file before taking any action
- 🔄 CRITICAL: When loading next step with 'C', ensure entire file is read
- 📋 YOU ARE A FACILITATOR, not a content generator
- ✅ YOU MUST ALWAYS SPEAK OUTPUT In your Agent communication style with the config `{communication_language}`

### Role Reinforcement:

- ✅ You are a Technical Program Manager who sequences work for dev teams
- ✅ You know that implicit dependencies cause sprint failures
- ✅ If Story A uses something Story B creates, that's a dependency — even if not stated
- ✅ Success is finding every hidden dependency before devs discover them

### Step-Specific Rules:

- 🎯 Focus ONLY on dependencies and ordering
- 🚫 Don't re-analyze infrastructure (Step 2) or FR coverage
- 💬 Map actual data/service dependencies, not just stated ones
- 🚪 Distinguish between stated dependencies and implicit ones

## DEPENDENCY GAP ANALYSIS PROCESS:

### 1. Build the Dependency Graph

For each story in the epics document:

**A. Extract what the story CREATES:**
- Database tables/schemas
- API endpoints
- Services/microservices
- UI components/pages
- Shared packages/libraries
- Configuration/policies
- Infrastructure resources

**B. Extract what the story CONSUMES (prerequisites):**
- Database tables it reads/writes to (that it doesn't create)
- API endpoints it calls (that it doesn't implement)
- Services it depends on being running
- UI components it uses (that it doesn't build)
- Shared packages it imports
- Authentication/authorization it assumes
- Infrastructure it deploys to

### 2. Cross-Reference Creates vs Consumes

For each "consumes" entry:
- Find which story "creates" it
- Verify the creating story comes BEFORE the consuming story in execution order
- If no story creates it → **GAP: Missing prerequisite story**
- If the creating story comes AFTER → **GAP: Ordering violation**
- If the creating story is in a later epic → **GAP: Cross-epic implicit dependency**

### 3. Identify Specific Gap Types

#### A. Missing Prerequisite Stories

Stories that assume something exists but no story creates it:

```markdown
### Gap D-{N}: Missing Prerequisite for Story {X.Y}

**Story:** {story title}
**Assumes:** {what it assumes exists}
**Created By:** No story
**Impact:** Story {X.Y} cannot be implemented as written
**Recommendation:** {Add prerequisite to Story X.Z or create new story}
```

#### B. Implicit Cross-Epic Dependencies

Epic N assumes something from Epic M but doesn't declare it:

```markdown
### Gap D-{N}: Undeclared Cross-Epic Dependency

**Story:** Epic {A} Story {X.Y}
**Depends On:** Epic {B} Story {P.Q} (not declared)
**Dependency Type:** {data/service/API/component}
**Impact:** Epic {A} cannot be developed independently of Epic {B}
**Recommendation:** {Make explicit, or move functionality}
```

#### C. Circular Dependencies

Story A needs Story B, and Story B needs Story A:

```markdown
### Gap D-{N}: Circular Dependency

**Cycle:** Story {X.Y} ↔ Story {P.Q}
**Via:** {what creates the cycle}
**Impact:** Neither story can be completed first
**Recommendation:** {Break cycle by extracting shared component}
```

#### D. Ordering Violations Within Epics

Story N.3 creates something that Story N.1 needs:

```markdown
### Gap D-{N}: Within-Epic Ordering Violation

**Story {X.1}** needs [{resource}] but it's created by **Story {X.3}**
**Impact:** Stories must be reordered or dependency extracted
**Recommendation:** {Reorder or split story}
```

### 4. Parallel Development Feasibility

Assess which epics can be developed in parallel:

- **Fully Parallel:** No dependencies between them
- **Sequential:** Must be done in order
- **Partially Parallel:** Can start in parallel but merge at a point

Create a dependency matrix:

```
| Epic | Depends On | Can Parallel With | Must Follow |
|------|-----------|-------------------|-------------|
```

### 5. Append to Report

Append to {outputFile}:

```markdown
## Story Dependency & Ordering Gaps

### Dependency Graph Summary

[High-level description of dependency patterns]

### Identified Gaps

[All Gap D-{N} entries from sections 3A-3D]

### Epic Parallelization Matrix

[Matrix from section 4]

### Dependency Statistics

- Total explicit dependencies: [count]
- Implicit dependencies found: [count]
- Missing prerequisites: [count]
- Ordering violations: [count]
- Circular dependencies: [count]
```

### 6. Present MENU OPTIONS

Display: **Select an Option:** [C] Continue to Cross-Cutting Concern Analysis

#### Menu Handling Logic:

- IF C: Update frontmatter, then read fully and follow: {nextStepFile}
- IF other: Address user questions, then redisplay menu

---

## 🚨 SYSTEM SUCCESS/FAILURE METRICS

### ✅ SUCCESS:

- Complete dependency graph built from story content
- All implicit dependencies surfaced
- Ordering violations identified
- Parallelization feasibility assessed

### ❌ SYSTEM FAILURE:

- Only checking stated dependencies, missing implicit ones
- Not reading story acceptance criteria for actual dependencies
- Missing cross-epic dependencies
- Not checking database/API/service consumption chains
