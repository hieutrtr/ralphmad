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

## Template Philosophy: Thin Wrappers

Templates are thin wrappers (~30-50 lines) that provide **project context** (data) so the AI
can answer workflow questions. Templates do NOT duplicate **workflow logic** — the BMAD workflow
step files already contain all instructions, templates, scoring rules, and formats.

If a template contains step-by-step execution instructions, risk scoring formulas, story templates,
framework selection rules, or content extraction guides, it is over-engineered and will cause the
workflow to malfunction (template instructions conflict with the workflow's own steps).

## Step 5: Load Template & Discover Required Context

First, read the template file: `${CLAUDE_PLUGIN_ROOT}/templates/{template_file}` (from Step 2).

Scan the template for all `{{variable}}` references (including inside `{{#if variable}}` blocks).
This determines which artifacts you actually need to load — do NOT load artifacts the template doesn't reference.

Use the variable-to-artifact mapping below to identify which source artifacts to read:

| Source Artifact | Provides Variables | Discovery patterns (from `artifact_discovery` in config) |
|---|---|---|
| product_brief | product_description, tagline, target_users, mvp_scope, tech_stack, business_model, core_capabilities | `product-brief*.md` in planning_artifacts |
| prd | functional_requirements_summary, personas, domain_model | `prd.md`, `prd-*.md` in planning_artifacts |
| architecture | tech_decisions, architecture_patterns, project_structure | `architecture.md`, `architecture-*.md` in planning_artifacts |
| ux_design | design_system, ux_patterns | `ux-design*.md` in planning_artifacts |
| epics | epic_structure | `epics.md`, `epics-*.md` in planning_artifacts |

For each source artifact whose variables appear in the template:
1. Use the discovery patterns and search directory from `artifact_discovery` in `ralphmad-config.yaml`
2. Glob for matching files; if found, read and extract only the relevant fields
3. If not found, the variable stays unset (handled during population)

Special case: only check for `docs/product-concept.md` if the template references `{{product_concept_full}}`.

## Step 6: Populate Template

Replace all `{{variable}}` placeholders in the template with the discovered values from Step 5.

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

Now use the Bash tool to call the setup script with the ACTUAL computed values from previous steps. Do NOT use placeholder text — substitute real values:

```
"${CLAUDE_PLUGIN_ROOT}/scripts/setup-ralphmad.sh" <ACTUAL_POPULATED_PROMPT> --completion-promise "<ACTUAL_PROMISE>" --max-iterations <ACTUAL_NUMBER>
```

Substitution rules:
- Replace `<ACTUAL_POPULATED_PROMPT>` with the fully populated template text from Step 6
- Replace `<ACTUAL_PROMISE>` with the `promise` string from the workflow config (Step 2)
- Replace `<ACTUAL_NUMBER>` with the resolved max_iterations integer (CLI override from Step 1, or config default from Step 2)

IMPORTANT: All three values MUST be real values, not placeholders. The script validates that max-iterations is a number and will reject literal text like "N".

Then follow the populated prompt instructions exactly, maintaining the specified persona throughout.

CRITICAL RULE: If a completion promise is set, you may ONLY output it when the statement is completely and unequivocally TRUE. Do not output false promises to escape the loop, even if you think you're stuck or should exit for other reasons. The loop is designed to continue until genuine completion.
