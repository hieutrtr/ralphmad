# RalphMAD — Autonomous BMAD Workflow Execution

RalphMAD is a Claude Code plugin that combines the [Ralph Loop](https://ghuntley.com/ralph/) self-referential AI loop technique with [BMAD](https://github.com/bmad-method/bmad-method) structured SDLC workflows. It provides templatized, project-agnostic workflow automation — install once, use with any BMAD-enabled project.

## Quick Start

### 1. Install the plugin

```bash
# From GitHub
/plugins install github:hieutrtr/ralphmad

# Or local development
/plugins install /path/to/ralphmad
```

### 2. Set up your project

Ensure your project has BMAD installed (`_bmad/` directory) with a config at `_bmad/bmm/config.yaml`.

For the first workflow (product-brief), create `docs/product-concept.md` describing your product idea.
See `templates/product-concept-template.md` for a starter template.

### 3. Check status

```
/ralphmad:ralphmad-status
```

### 4. Run a workflow

```
/ralphmad:ralphmad-loop product-brief
```

## How It Works

```
User invokes: /ralphmad:ralphmad-loop product-brief
  → Reads workflow registry (ralphmad-config.yaml)
  → Reads project config (_bmad/bmm/config.yaml)
  → Checks prerequisites (scans for required artifacts)
  → Reads template (01-product-brief.tpl.md)
  → Populates {{placeholders}} with project context
  → Activates ralph-loop mechanism
  → Claude executes BMAD workflow autonomously
  → Loop continues until completion promise detected
```

## Available Workflows

| Phase | Workflow | Command | Description |
|-------|----------|---------|-------------|
| 1 | Product Brief | `product-brief` | Create product brief from concept |
| 2 | PRD | `prd-create` | Create PRD from product brief |
| 2 | UX Design | `ux-design` | Create UX design specification |
| 3 | Architecture | `architecture` | Create architecture decisions |
| 3 | Epics & Stories | `epics-stories` | Create epics and user stories |
| 3 | Test Design | `test-design` | Create test design with risk assessment |
| 3 | Test Framework | `testarch-framework` | Set up test framework |
| 3 | CI/CD | `testarch-ci` | Set up CI/CD pipeline |
| 4 | Sprint Planning | `sprint-planning` | Generate sprint status tracking |
| 4 | Epic Test Design | `testarch-test-design-epic` | Test design for specific epic |
| 4 | Epic Dev | `epic-dev` | Implement all stories in an epic |
| 4 | Correct Course | `correct-course` | Manage sprint changes |

## Commands

| Command | Description |
|---------|-------------|
| `/ralphmad:ralphmad-loop WORKFLOW [--max-iterations N]` | Run a workflow |
| `/ralphmad:ralphmad-status` | Show workflow status |
| `/ralphmad:ralphmad-cancel` | Cancel active loop |
| `/ralphmad:help` | Plugin documentation |

## Template System

Templates use `{{placeholder}}` syntax and are populated at runtime from:
- **Project config** (`_bmad/bmm/config.yaml`) — project name, artifact paths
- **Existing artifacts** (`_bmad-output/`) — context from previous workflows
- **Workflow config** (`ralphmad-config.yaml`) — promises, personas, prerequisites

This means the same templates work with any BMAD-enabled project.

## Coexistence with Ralph Loop

RalphMAD uses a separate state file (`.claude/ralphmad-loop.local.md`) from ralph-loop (`.claude/ralph-loop.local.md`), so both plugins can be installed simultaneously.

## Project Structure

```
ralphmad/
  .claude-plugin/
    plugin.json                  # Plugin metadata
  commands/
    ralphmad-loop.md             # Main workflow runner
    ralphmad-status.md           # Status checker
    ralphmad-cancel.md           # Cancel active loop
    help.md                      # Plugin documentation
  hooks/
    hooks.json                   # Stop hook configuration
    stop-hook.sh                 # Stop hook script
  scripts/
    setup-ralphmad.sh            # Loop state file creator
  templates/
    ralphmad-config.yaml         # Workflow registry
    _base-workflow.tpl.md        # Template reference
    01-product-brief.tpl.md      # through
    12-correct-course.tpl.md     # 12 workflow templates
    product-concept-template.md  # Starter for new projects
```

## Prerequisites

- [Claude Code](https://claude.com/claude-code) CLI
- [BMAD Method](https://github.com/bmad-method/bmad-method) installed in your project
- Project config at `_bmad/bmm/config.yaml`

## License

Apache License 2.0 — See [LICENSE](LICENSE)
