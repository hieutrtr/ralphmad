# RalphMAD Base Workflow Template — Shared Boilerplate

This file documents the shared patterns used across all RalphMAD workflow templates.
It is NOT directly used as a template — it serves as a reference for template authors.

## Standard Variables (available in all templates)

- `{{project_name}}` — Project name from _bmad/bmm/config.yaml
- `{{user_name}}` — User name from config
- `{{planning_artifacts}}` — Resolved path to planning artifacts directory
- `{{implementation_artifacts}}` — Resolved path to implementation artifacts directory
- `{{completion_promise}}` — The promise string for this workflow
- `{{persona}}` — The persona to maintain throughout
- `{{bmad_workflow}}` — The BMAD workflow command to invoke

## Conditional Blocks

Use `{{#if variable}}...{{/if}}` to conditionally include sections:

```
{{#if product_concept_full}}
### Product Concept
{{product_concept_full}}
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
