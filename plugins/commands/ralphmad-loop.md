---
description: "Run a BMAD workflow autonomously via RalphMAD"
argument-hint: "WORKFLOW_NAME [--max-iterations N]"
allowed-tools: ["Bash(${CLAUDE_PLUGIN_ROOT}/scripts/setup-ralphmad.sh:*)", "Read", "Glob", "Grep"]
hide-from-slash-command-tool: "true"
---

# RalphMAD — BMAD Workflow Runner

You are the RalphMAD orchestrator. Follow these steps exactly:

## Step 1: Parse Arguments

The first argument is the workflow name. Extract it from: $ARGUMENTS

Valid workflow names: product-brief, prd-create, ux-design, architecture,
epics-stories, test-design, testarch-framework, testarch-ci,
sprint-planning, testarch-test-design-epic, epic-dev, correct-course

Also extract any `--max-iterations N` if provided (overrides the config default).

If no valid workflow name is found, display the list of valid workflows with their descriptions and exit.

## Step 2: Load Workflow Registry

Read the file: `${CLAUDE_PLUGIN_ROOT}/templates/ralphmad-config.yaml`

Find the entry matching the workflow name. Extract:
- `template` — the template filename
- `bmad_workflow` — the BMAD workflow command to invoke
- `promise` — the completion promise string
- `persona` — the persona to adopt
- `phase` — which SDLC phase this belongs to
- `prerequisites` — list of artifact types that must exist
- `produces` — what artifact this workflow creates
- `max_iterations` — default max iterations (can be overridden by CLI arg)

## Step 3: Load Project Config

Read: `_bmad/bmm/config.yaml` from the current project root.

Extract:
- `project_name` — the project name
- `user_name` — the user's name
- `planning_artifacts` — path to planning artifacts (replace `{project-root}` with `.`)
- `implementation_artifacts` — path to implementation artifacts (replace `{project-root}` with `.`)
- `output_folder` — base output path (replace `{project-root}` with `.`)

If this file doesn't exist, STOP and tell the user:
"This project is not BMAD-enabled. Create `_bmad/bmm/config.yaml` first.
You can use `/bmad:bmm:workflows:install` to set up BMAD."

## Step 4: Check Prerequisites

For each item in the workflow's `prerequisites` list:
1. Look up the artifact discovery config in `ralphmad-config.yaml` under `artifact_discovery`
2. Determine the search directory (planning_artifacts or implementation_artifacts)
3. Use Glob to scan for files matching the artifact's patterns
4. If ANY prerequisite artifact is missing, STOP and report:
   - Which artifacts are missing
   - Which workflow should be run first to produce them
   - Example: "Missing: prd. Run `/ralphmad-loop:ralphmad-loop prd-create` first."

## Step 5: Discover & Extract Context

Scan the planning and implementation artifact directories for existing artifacts.
For each found artifact, read it and extract key context variables:

**From product brief** (if exists):
- `{{product_description}}` — full product description paragraph
- `{{tagline}}` — product tagline
- `{{target_users}}` — target user list
- `{{mvp_scope}}` — MVP scope section
- `{{tech_stack}}` — technology stack section
- `{{business_model}}` — business model description
- `{{core_capabilities}}` — list of core capabilities

**From PRD** (if exists):
- `{{functional_requirements_summary}}` — summarized FRs
- `{{personas}}` — persona descriptions
- `{{domain_model}}` — domain model entities

**From architecture** (if exists):
- `{{tech_decisions}}` — key technical decisions
- `{{architecture_patterns}}` — implementation patterns
- `{{project_structure}}` — folder/file organization

**From UX design** (if exists):
- `{{design_system}}` — design system choices
- `{{ux_patterns}}` — UX pattern descriptions

**From epics** (if exists):
- `{{epic_structure}}` — epic list with story counts

Also check for `docs/product-concept.md` for the product-brief bootstrap case.
If found, set `{{product_concept_full}}` to its full contents.

## Step 6: Load & Populate Template

Read: `${CLAUDE_PLUGIN_ROOT}/templates/{template_file}` (the template filename from Step 2).

Replace all `{{variable}}` placeholders with the discovered values from Step 5.

For variables that have no discovered value:
- If the variable is critical (like `{{product_concept_full}}` for product-brief), STOP and tell the user what's missing
- If the variable is supplementary context, replace with a note: `[Not yet available — will be populated when the corresponding artifact is created]`

Handle `{{#if var}}...{{/if}}` conditional blocks:
- If the variable exists and is non-empty, include the block content
- If the variable doesn't exist, remove the entire block

Also substitute these standard variables:
- `{{project_name}}` — from project config
- `{{user_name}}` — from project config
- `{{planning_artifacts}}` — resolved path
- `{{implementation_artifacts}}` — resolved path
- `{{completion_promise}}` — from workflow config
- `{{persona}}` — from workflow config
- `{{bmad_workflow}}` — from workflow config

## Step 7: Execute

Take the populated prompt text and the completion promise from the workflow config.

Determine max_iterations: use CLI override if provided, otherwise use config default.

Run the setup script:

```!
"${CLAUDE_PLUGIN_ROOT}/scripts/setup-ralphmad.sh" POPULATED_PROMPT --completion-promise "PROMISE" --max-iterations N
```

Where:
- POPULATED_PROMPT is the fully populated template content
- PROMISE is the completion promise from the workflow config
- N is the max_iterations value

Then follow the populated prompt instructions exactly, maintaining the specified persona throughout.

CRITICAL RULE: If a completion promise is set, you may ONLY output it when the statement is completely and unequivocally TRUE. Do not output false promises to escape the loop, even if you think you're stuck or should exit for other reasons. The loop is designed to continue until genuine completion.
