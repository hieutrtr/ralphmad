---
name: 'step-01-parse-source'
description: 'Read monolithic architecture document, extract all sections, build content map to output documents, identify gaps'

nextStepFile: './step-02-high-level-design.md'
contentMapFile: '{output_folder}/content-map-{source_name}.md'
gapReportFile: '{output_folder}/gap-report-{source_name}.md'
gapReportTemplate: '../templates/gap-report-template.md'
sourceMappingRules: '../data/source-mapping-rules.md'
outputDocChecklist: '../data/output-doc-checklist.md'
---

# Step 1: Parse & Analyze Source

## STEP GOAL:

To read the monolithic architecture document, extract all sections with their content types, build a content map identifying which source sections feed into which of the 7 output documents, and identify gaps where the source lacks detail that must be expanded.

## MANDATORY EXECUTION RULES (READ FIRST):

### Universal Rules:

- NEVER generate content without user input
- CRITICAL: Read the complete step file before taking any action
- CRITICAL: When loading next step with 'C', ensure entire file is read
- YOU ARE A FACILITATOR, not a content generator
- TOOL/SUBPROCESS FALLBACK: If subprocess/task capability unavailable, perform all operations in main thread

### Role Reinforcement:

- You are an Architecture Document Specialist
- We engage in collaborative dialogue, not command-response
- You bring expertise in architectural decomposition and C4 modeling
- User brings context about the system's purpose, constraints, and priorities

### Step-Specific Rules:

- Focus ONLY on parsing and mapping — do NOT generate output documents yet
- FORBIDDEN to modify the source architecture document
- Approach: read everything, build content map, identify gaps, present for confirmation
- Subprocess Pattern 1: Launch a subprocess to scan all sections of the source document

## EXECUTION PROTOCOLS:

- Read the entire source architecture document
- Parse all headings (H1-H6) and build a section hierarchy
- Extract architectural decisions, technology references, patterns, requirements, and structure definitions
- Map each source section to output documents using {sourceMappingRules}
- Identify gaps using {outputDocChecklist}
- FORBIDDEN to load next step until user selects 'C'

## CONTEXT BOUNDARIES:

- Available: the user-provided architecture document path
- Focus: parsing and content mapping only — no document generation yet
- Dependencies: none — this is the first step

## MANDATORY SEQUENCE

**CRITICAL:** Follow this sequence exactly. Do not skip, reorder, or improvise.

### 1. Request Source Document Path

"**Architecture Document Sharding**

I'll read your monolithic architecture document and decompose it into 7 focused sub-documents:

1. High-Level Design Architecture
2. Tech Stack & Vendor Assessment
3. Detailed Design Architecture
4. Sequence Diagrams
5. Deployment Architecture
6. Network Architecture
7. Database Design

Please provide the path to the architecture document to shard."

### 2. Read and Parse Source Document

Read the complete source document. Extract:

**Document structure:**
- Total line count
- All headings (H1-H6) with line numbers
- Section hierarchy (which headings are children of which)

**Architectural content:**
- Architectural decisions (ID, status, context, decision, consequences)
- Technology references (name, version, role)
- Non-functional requirements (category, target, metric)
- Directory/file structure definitions
- Named patterns (naming, communication, error handling, etc.)
- Integration points and external dependencies
- Diagrams (existing or described)

### 3. Build Content Map

Load {sourceMappingRules}. For each source section, determine:

| Source Section (heading path) | Content Type | Primary Output Doc | Secondary Output Docs | Detail Level |
|------------------------------|-------------|-------------------|----------------------|-------------|

**Content types:** decision, technology, requirement, pattern, structure, integration, diagram, narrative

**Detail levels:** comprehensive (enough for output doc), partial (needs expansion), mention-only (needs significant expansion)

### 4. Identify Gaps

Load {outputDocChecklist}. For each required section in each output document:

- Check if at least one source section maps to it
- If no source section maps → flag as **SILENT** gap
- If source section maps but detail level is "mention-only" → flag as **SHALLOW** gap
- If source contradicts itself → flag as **AMBIGUOUS** gap

### 5. Present Content Map and Gap Analysis

"**Content Map**

**Source:** {document path}
**Total sections:** {count}
**Total lines:** {count}

**Section-to-Output Mapping:**
{content map table from step 3}

**Coverage Summary:**
| Output Document | Source Sections Mapped | Gaps Found | Detail Level |
|----------------|----------------------|------------|-------------|
| 01 High-Level Design | {count} | {count} | {assessment} |
| 02 Tech Stack | {count} | {count} | {assessment} |
| 03 Detailed Design | {count} | {count} | {assessment} |
| 04 Sequence Diagrams | {count} | {count} | {assessment} |
| 05 Deployment | {count} | {count} | {assessment} |
| 06 Network | {count} | {count} | {assessment} |
| 07 Database Design | {count} | {count} | {assessment} |

**Gaps Found ({total_gaps}):**
{gap list by output document}

Does this content map look correct? Any sections I missed or misclassified?"

### 6. Initialize Gap Report

Create {gapReportFile} from {gapReportTemplate} with the content map and gap analysis.

### 7. Present MENU OPTIONS

Display: **Source Parsing Complete - Select an Option:** [C] Continue to High-Level Design Architecture

#### EXECUTION RULES:

- ALWAYS halt and wait for user input after presenting menu
- ONLY proceed to next step when user selects 'C'

#### Menu Handling Logic:

- IF C: Save content map to {contentMapFile} and gaps to {gapReportFile}, then load, read entire file, then execute {nextStepFile}
- IF Any other comments or queries: help user respond, then redisplay menu

---

## SYSTEM SUCCESS/FAILURE METRICS

### SUCCESS:

- Every source section parsed and categorized
- Content map built with source-to-output mappings
- Gaps identified for each output document
- Content map and gap report presented and confirmed by user
- Gap report document initialized

### FAILURE:

- Missing source sections from the content map
- Not identifying gaps
- Modifying the source document
- Proceeding without user confirmation
- Generating output documents in this step

**Master Rule:** Skipping steps is FORBIDDEN.
