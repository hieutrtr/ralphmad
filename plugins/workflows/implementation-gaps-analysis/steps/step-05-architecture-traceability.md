---
name: 'step-05-architecture-traceability'
description: 'Validate that every architecture decision and component has a traceable implementation path in stories'

nextStepFile: './step-06-remediation-plan.md'
outputFile: '{planning_artifacts}/gaps-analysis-report-{{date}}.md'
---

# Step 5: Architecture-to-Story Traceability

## STEP GOAL:

To verify that every architecture decision (AR), technology choice, service definition, and design pattern specified in the architecture document has a clear implementation path in the stories. Architecture decisions without stories are documentation — not implementation.

## MANDATORY EXECUTION RULES (READ FIRST):

### Universal Rules:

- 🛑 NEVER generate content without user input
- 📖 CRITICAL: Read the complete step file before taking any action
- 🔄 CRITICAL: When loading next step with 'C', ensure entire file is read
- 📋 YOU ARE A FACILITATOR, not a content generator
- ✅ YOU MUST ALWAYS SPEAK OUTPUT In your Agent communication style with the config `{communication_language}`

### Role Reinforcement:

- ✅ You are a Staff Engineer who ensures architecture becomes reality
- ✅ Architecture on paper means nothing without implementation stories
- ✅ Every technology choice implies setup, configuration, and integration work
- ✅ Success is 100% traceability from architecture to stories

### Step-Specific Rules:

- 🎯 Focus ONLY on architecture → story traceability
- 🚫 Don't duplicate infrastructure analysis (Step 2) — focus on DECISIONS and PATTERNS
- 💬 A technology choice is not just "install it" — it's configure, integrate, test, and document
- 🚪 Architecture requirements (AR-XX) must map to specific story acceptance criteria

## ARCHITECTURE TRACEABILITY PROCESS:

### 1. Extract Architecture Decisions

From the Architecture document, extract ALL:

#### A. Explicit Architecture Requirements (AR-XX)
- List every numbered AR with its full description
- These are the PRIMARY traceability targets

#### B. Technology Stack Choices
- Each technology (framework, database, library, tool) implies work:
  - Initial setup and configuration
  - Integration with other components
  - Team expertise/training
  - Testing approach

#### C. Design Patterns & Conventions
- Communication patterns (gRPC, REST, events, pub/sub)
- Data patterns (schema-per-tenant, CQRS, event sourcing)
- Security patterns (zero-trust, mTLS, OPA sidecar)
- Deployment patterns (canary, blue-green, rolling)

#### D. Service Definitions
- Each service in the architecture must have stories that build it
- Each shared package must have stories that create and use it

### 2. Trace Each Item to Stories

For each extracted item:

1. Search the epics document for references to this item
2. Check if any story's acceptance criteria explicitly implement this
3. Determine the traceability status:

- **FULLY TRACED:** Story acceptance criteria directly implement this decision
- **PARTIALLY TRACED:** Story mentions it but doesn't fully implement it
- **REFERENCED ONLY:** Stories mention the technology but no story sets it up
- **NOT TRACED:** Architecture specifies it, no story references it at all

### 3. Document Traceability Gaps

For each gap:

```markdown
### Gap T-{N}: {Architecture Decision/Component}

**Architecture Ref:** [AR-XX or section/technology]
**Description:** [What the architecture specifies]
**Traceability Status:** [Partially Traced/Referenced Only/Not Traced]
**Evidence:** [What stories say vs what architecture requires]
**Impact:** [What happens if this isn't implemented]
**Recommendation:** [Which story should own this, or new story needed]
```

### 4. Service Coverage Check

For each service defined in the architecture:

| Service | Epic(s) | Stories | Endpoints Covered | Data Model Covered | Status |
|---|---|---|---|---|---|
| [service] | [epics] | [stories] | [yes/partial/no] | [yes/partial/no] | [status] |

### 5. Shared Package Coverage Check

For each shared package:

| Package | Created In | Used By | All Exports Covered | Status |
|---|---|---|---|---|
| [package] | [story] | [stories] | [yes/partial/no] | [status] |

### 6. Append to Report

Append to {outputFile}:

```markdown
## Architecture-to-Story Traceability Gaps

### Architecture Requirement Traceability

| AR | Description | Story Coverage | Status |
|---|---|---|---|
| [AR-XX] | [description] | [Story X.Y or NONE] | [Traced/Gap] |

### Technology Stack Traceability

| Technology | Purpose | Setup Story | Integration | Status |
|---|---|---|---|---|
| [tech] | [purpose] | [story or NONE] | [story or NONE] | [status] |

### Service Coverage

[Table from section 4]

### Shared Package Coverage

[Table from section 5]

### Identified Gaps

[All Gap T-{N} entries from section 3]

### Traceability Statistics

- Architecture requirements: [total] | Traced: [count] | Gaps: [count]
- Technology choices: [total] | Traced: [count] | Gaps: [count]
- Services: [total] | Fully covered: [count] | Gaps: [count]
- Shared packages: [total] | Fully covered: [count] | Gaps: [count]
```

### 7. Present MENU OPTIONS

Display: **Select an Option:** [C] Continue to Remediation Plan

#### Menu Handling Logic:

- IF C: Update frontmatter, then read fully and follow: {nextStepFile}
- IF other: Address user questions, then redisplay menu

---

## 🚨 SYSTEM SUCCESS/FAILURE METRICS

### ✅ SUCCESS:

- Every AR-XX checked against stories
- Every technology choice verified for setup coverage
- Every service has story implementation path
- Gaps clearly documented with evidence

### ❌ SYSTEM FAILURE:

- Only checking AR-XX and missing technology/pattern gaps
- Treating "story mentions the tech" as "story implements the tech"
- Not verifying shared package creation and usage
- Missing service-level coverage gaps
