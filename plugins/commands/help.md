---
description: "RalphMAD plugin help and documentation"
---

# RalphMAD Plugin Help

Please explain the following to the user:

## What is RalphMAD?

RalphMAD is an autonomous BMAD-METHOD workflow execution plugin for Claude Code. It combines:

1. **Ralph Loop** — The self-referential AI loop technique (by Geoffrey Huntley) where the same prompt is repeatedly fed to Claude until a task completion promise is detected
2. **BMAD Workflows** — Structured SDLC workflows from the BMAD methodology (Business Analyst, PM, Architect, etc.)
3. **Template System** — Project-agnostic templates that auto-populate with your project's context

**Key Innovation**: Unlike hardcoded ralph-prompts, RalphMAD templates read your project's `_bmad/bmm/config.yaml` and existing artifacts to automatically build context-rich prompts. One plugin works with ANY BMAD-enabled project.

## Available Commands

### /ralphmad-loop WORKFLOW_NAME [--max-iterations N]

Run a BMAD workflow autonomously. This is the main command.

**Workflow names:**
- `product-brief` — Create product brief from product concept (Phase 1)
- `prd-create` — Create PRD from product brief (Phase 2)
- `ux-design` — Create UX design specification (Phase 2)
- `architecture` — Create architecture decisions (Phase 3)
- `epics-stories` — Create epics and user stories (Phase 3)
- `test-design` — Create test design with risk assessment (Phase 3)
- `testarch-framework` — Set up test framework (Phase 3)
- `testarch-ci` — Set up CI/CD pipeline (Phase 3)
- `sprint-planning` — Generate sprint status tracking (Phase 4)
- `testarch-test-design-epic` — Test design for specific epic (Phase 4)
- `epic-dev` — Implement all stories in an epic (Phase 4)
- `correct-course` — Manage sprint changes (Phase 4)

**Usage:**
```
/ralphmad-loop product-brief
/ralphmad-loop prd-create --max-iterations 10
/ralphmad-loop architecture
```

### /ralphmad-status

Show the status of all workflows — which are DONE, READY, or BLOCKED (with missing prerequisites).

### /ralphmad-cancel

Cancel an active RalphMAD loop.

## How It Works

1. You invoke `/ralphmad-loop WORKFLOW_NAME`
2. RalphMAD reads the workflow registry (`ralphmad-config.yaml`)
3. Reads your project config (`_bmad/bmm/config.yaml`)
4. Checks prerequisites (do required artifacts exist?)
5. Scans existing artifacts for context
6. Populates the workflow template with your project's specifics
7. Activates the ralph-loop mechanism
8. Claude executes the BMAD workflow autonomously
9. Loop continues until the completion promise is detected

## Prerequisites

- BMAD must be installed in your project (`_bmad/` directory)
- Project config at `_bmad/bmm/config.yaml`
- For `product-brief`: a `docs/product-concept.md` file describing your product idea
- For subsequent workflows: the artifacts from previous workflows must exist

## Workflow Phases

| Phase | Name | Workflows |
|-------|------|-----------|
| 1 | Analysis | product-brief |
| 2 | Planning | prd-create, ux-design |
| 3 | Solutioning | architecture, epics-stories, test-design, testarch-framework, testarch-ci |
| 4 | Implementation | sprint-planning, testarch-test-design-epic, epic-dev, correct-course |

## Getting Started with a New Project

1. Install BMAD in your project (if not already done)
2. Create `docs/product-concept.md` with your product idea
3. Run `/ralphmad-loop:ralphmad-status` to see available workflows
4. Run `/ralphmad-loop:ralphmad-loop product-brief` to start
5. Follow the workflow phases in order

## Coexistence with Ralph Loop

RalphMAD uses a separate state file (`.claude/ralphmad-loop.local.md`) from ralph-loop (`.claude/ralph-loop.local.md`), so both plugins can be installed simultaneously without conflict.

## Template System

Templates live in `${CLAUDE_PLUGIN_ROOT}/templates/` and use `{{placeholder}}` syntax.
They are populated at runtime from:
- Project config (`_bmad/bmm/config.yaml`)
- Existing artifacts (`_bmad-output/planning-artifacts/`, etc.)
- Workflow config (`ralphmad-config.yaml`)

This means the same templates work with any BMAD-enabled project.
