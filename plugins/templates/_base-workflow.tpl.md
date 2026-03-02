# RalphMAD Base Workflow Template — Shared Boilerplate

This file documents the shared patterns used across all RalphMAD workflow templates.
It is NOT directly used as a template — it serves as a reference for template authors.

## CRITICAL: Templates Are Thin Wrappers

Templates provide **project context** (data: FRs, epics, tech stack) so the AI can answer
workflow questions autonomously. Templates do NOT provide **workflow logic** (how to design
epics, risk scoring formulas, story templates, framework selection rules, etc.).

The BMAD workflow step files already contain all the logic. Duplicating it in templates
causes conflicts — the template instructions override or contradict the workflow's own steps.

### DO NOT include in templates:
- Step-by-step execution instructions (the workflow handles this)
- Risk scoring formulas or priority assignment rules
- Story/epic/test templates or formats
- Framework selection decision trees
- Content extraction guides (how to read the PRD, etc.)
- Performance targets or technical specifications
- Checklist guidance or scope classification rules

### DO include in templates:
- Context (role + product description in 2-3 lines)
- Input document scan patterns
- Initialization (run workflow + auto-proceed)
- Autonomous response rules (menu/confirmation handling)
- Step mapping table (step → auto-response strategy, brief)
- Project context blocks ({{variable}} placeholders from discovered artifacts)
- Output file paths
- Exit condition
- Important notes (3-5 lines)

## Standard Variables (available in all templates)

- `{{project_name}}` — Project name from _bmad/bmm/config.yaml
- `{{user_name}}` — User name from config
- `{{planning_artifacts}}` — Resolved path to planning artifacts directory
- `{{implementation_artifacts}}` — Resolved path to implementation artifacts directory
- `{{completion_promise}}` — The promise string for this workflow
- `{{persona}}` — The persona to maintain throughout
- `{{bmad_workflow}}` — The BMAD workflow command to invoke

## Context Variables (from discovered artifacts)

- `{{product_description}}` — Product description paragraph (from product brief)
- `{{product_concept_full}}` — Full product concept (from docs/product-concept.md)
- `{{functional_requirements_summary}}` — Summarized FRs (from PRD)
- `{{personas}}` — Persona descriptions (from PRD)
- `{{domain_model}}` — Domain model entities (from PRD)
- `{{tech_decisions}}` — Key technical decisions (from architecture)
- `{{architecture_patterns}}` — Implementation patterns (from architecture)
- `{{project_structure}}` — Folder/file organization (from architecture)
- `{{design_system}}` — Design system choices (from UX design)
- `{{epic_structure}}` — Epic list with story counts (from epics)

## Conditional Blocks

Use `{{#if variable}}...{{/if}}` to conditionally include sections:

```
{{#if product_description}}
### Product Context
{{product_description}}
{{/if}}
```

## Standard Autonomous Response Rules

All templates should include these rules:

```
### Autonomous Response Rules
When the workflow requests user input or presents a menu:
- **If menu has 'C' (Continue)**: Automatically select 'C' to proceed
- **If menu has A/P/C options**: Always select 'C' (Continue)
- **If asking for documents**: Confirm the discovered documents as sources
- **If asking for confirmation**: Respond 'yes' or 'confirmed' to proceed
```

## Standard Exit Condition

```
### Exit Condition
Output <promise>{{completion_promise}}</promise> when:
- All workflow steps are completed AND
- The completion message appears AND
- The output file has been saved
```

## Standard Important Notes

```
### Important Notes
- Maintain the {{persona}} persona throughout
- Follow workflow step-file architecture strictly (NEVER skip steps)
- ALWAYS select 'C' to continue when A/P/C menus are presented
- Do NOT skip steps or optimize the sequence
```
