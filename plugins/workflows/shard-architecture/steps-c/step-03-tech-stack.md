---
name: 'step-03-tech-stack'
description: 'Produce 02-tech-stack-vendor-assessment.md — technology inventory, vendor risk, alternatives, compatibility, cost, security'

nextStepFile: './step-04-detailed-design.md'
outputFile: '{output_folder}/02-tech-stack-vendor-assessment.md'
outputDocTemplate: '../templates/output-doc-template.md'
contentMapFile: '{output_folder}/content-map-{source_name}.md'
gapReportFile: '{output_folder}/gap-report-{source_name}.md'
outputDocChecklist: '../data/output-doc-checklist.md'
advancedElicitationTask: '{project-root}/_bmad/core/workflows/advanced-elicitation/workflow.xml'
partyModeWorkflow: '{project-root}/_bmad/core/workflows/party-mode/workflow.md'
---

# Step 3: Tech Stack & Vendor Assessment

## STEP GOAL:

To produce `02-tech-stack-vendor-assessment.md` containing a complete technology inventory with versions, per-technology assessment (license, maturity, lock-in risk), alternatives comparison, compatibility matrix, upgrade paths, cost analysis, security posture, and technology radar classification.

## MANDATORY EXECUTION RULES (READ FIRST):

### Universal Rules:

- NEVER generate content without user input
- CRITICAL: Read the complete step file before taking any action
- CRITICAL: When loading next step with 'C', ensure entire file is read
- YOU ARE A FACILITATOR, not a content generator

### Role Reinforcement:

- You are an Architecture Document Specialist producing the technology assessment
- We engage in collaborative dialogue, not command-response
- You bring expertise in technology evaluation, vendor risk assessment, and compatibility analysis
- User brings context about organizational constraints, budget, and technology preferences

### Step-Specific Rules:

- Focus ONLY on technology assessment — no design, deployment, or database details
- FORBIDDEN to modify the source architecture document
- Every technology must have an exact version number
- EXPAND beyond the source — add alternatives, risk assessment, cost analysis
- Flag gaps where source mentions technologies without versions or rationale

## EXECUTION PROTOCOLS:

- Read the content map to identify all technology references
- Extract every technology choice from the source
- Expand each with full assessment
- Present the complete draft for user review
- FORBIDDEN to load next step until user selects 'C'

## CONTEXT BOUNDARIES:

- Available: content map from step 1, source architecture document, previous output docs
- Focus: technology inventory and vendor assessment only
- Dependencies: content map from step 1

## MANDATORY SEQUENCE

**CRITICAL:** Follow this sequence exactly. Do not skip, reorder, or improvise.

### 1. Load Context

Read {contentMapFile} and identify all source sections mapped to "02 Tech Stack."
Load {outputDocChecklist} section "02 — Tech Stack & Vendor Assessment" for required sections.

### 2. Technology Inventory

Extract every technology from the source and build the master inventory:

| Technology | Version | Category | Role in System | License | Source Section |
|-----------|---------|----------|----------------|---------|---------------|

**Categories:** Language/Runtime, Framework, Database, Cache, Message Broker, Search/Vector, Auth/Security, Observability, Infrastructure, Frontend, Build/CI, Testing

**Expansion:** If source mentions a technology without a version, research the latest stable version and flag it. If source mentions a category without a specific technology, flag as gap.

### 3. Per-Technology Assessment

For each technology in the inventory:

**{Technology Name} v{Version}**
- **Category:** {category}
- **Role:** {specific role in this system}
- **License:** {license type — MIT, Apache 2.0, commercial, etc.}
- **Maturity:** {emerging/growing/mature/declining}
- **Community Health:** {active/stable/declining} — based on release frequency, contributor count, ecosystem size
- **Vendor Lock-in Risk:** {LOW/MEDIUM/HIGH}
- **Lock-in Mitigation:** {strategy to reduce lock-in}

### 4. Alternatives Comparison Matrix

For each major technology choice, compare with alternatives:

| Slot | Chosen | Alternative 1 | Alternative 2 | Key Differentiator |
|------|--------|--------------|---------------|-------------------|

Include at least 2 alternatives per slot for: primary database, cache, message broker, backend framework, frontend framework, auth provider, vector database, observability stack.

### 5. Version Compatibility Matrix

Document which versions work together:

| Component A | Version | Component B | Version | Compatible | Notes |
|------------|---------|------------|---------|-----------|-------|

Focus on critical compatibility pairs: framework + database driver, ORM + database, frontend + backend SDK, infrastructure + runtime.

### 6. Upgrade Path Analysis

For each technology:

| Technology | Current | Next Major | Breaking Changes | Migration Effort | Risk |
|-----------|---------|-----------|-----------------|-----------------|------|

### 7. Cost Analysis

| Component | Type | Licensing Cost | Hosting Cost | Operational Cost | Total |
|-----------|------|---------------|-------------|-----------------|-------|

Types: OSS (free license), Freemium, Commercial, Cloud-Managed

### 8. Security Posture

| Technology | CVE History (past 2yr) | Security Practices | Compliance Certs | Risk Rating |
|-----------|----------------------|-------------------|-----------------|------------|

### 9. Support & SLA Comparison

For commercial or cloud-managed dependencies:

| Vendor | SLA | Support Tiers | Response Time | Escalation Path |
|--------|-----|--------------|--------------|----------------|

### 10. Technology Radar

Classify every technology:

| Technology | Classification | Rationale |
|-----------|---------------|-----------|

Classifications: **Adopt** (proven, recommended), **Trial** (promising, limited risk), **Assess** (interesting, evaluate further), **Hold** (avoid for new work)

### 11. Assemble and Present Draft

Assemble all sections into {outputFile} using {outputDocTemplate}.

"**02 — Tech Stack & Vendor Assessment (Draft)**

{present the complete document}

**Checklist:**
{list each required section from outputDocChecklist with pass/fail}

**Gaps flagged:** {count}

Review the draft. Any corrections or additions before finalizing?"

### 12. Present MENU OPTIONS

Display: **Tech Stack Assessment Complete - Select an Option:** [A] Advanced Elicitation [P] Party Mode [C] Continue to Detailed Design Architecture

#### EXECUTION RULES:

- ALWAYS halt and wait for user input after presenting menu
- ONLY proceed to next step when user selects 'C'
- After other menu items execution, return to this menu

#### Menu Handling Logic:

- IF A: Execute {advancedElicitationTask}, and when finished redisplay the menu
- IF P: Execute {partyModeWorkflow}, and when finished redisplay the menu
- IF C: Save document to {outputFile}, update {gapReportFile}, then load, read entire file, then execute {nextStepFile}
- IF Any other comments or queries: help user respond, then redisplay menu

---

## SYSTEM SUCCESS/FAILURE METRICS

### SUCCESS:

- Every technology from source inventoried with version
- Per-technology assessment with lock-in risk
- Alternatives comparison for major choices
- Compatibility matrix for critical pairs
- Cost analysis and security posture documented
- Technology radar classification for all technologies
- Draft presented and confirmed by user

### FAILURE:

- Missing technologies from the inventory
- Technologies without version numbers
- Not assessing vendor lock-in risk
- Not providing alternatives
- Copying source without expansion

**Master Rule:** Skipping steps is FORBIDDEN.
