# RalphMAD — Autonomous BMAD Workflow Execution

RalphMAD is a Claude Code plugin that combines the [Ralph Loop](https://ghuntley.com/ralph/) self-referential AI loop technique with [BMAD](https://github.com/bmad-method/bmad-method) structured SDLC workflows. It provides templatized, project-agnostic workflow automation — install once, use with any BMAD-enabled project.

## Prerequisites

- [Claude Code](https://claude.com/claude-code) CLI — RalphMAD is a Claude Code plugin and requires Claude Code to run. Install it first if you haven't already.

## Quick Start

### 1. Install BMAD Method in your project

Open Claude Code in your project directory and install the BMM + TEA modules:

```bash
# Interactive (recommended — follow the prompts, select bmm and tea modules, pick claude-code as tool)
npx bmad-method install

# Or non-interactive
npx bmad-method install --modules bmm tea --tools claude-code --yes
```

This creates the `_bmad/` directory with workflows, agents, and config. After installation, run `/bmad-help` inside Claude Code to verify everything is set up.

### 2. Install RalphMAD

#### Option A: Commands (recommended — works on CLI and cloud)

From your project directory:
```bash
# One-liner (clones and installs automatically)
curl -sL https://raw.githubusercontent.com/hieutrtr/ralphmad/main/install.sh | bash

# Or clone first, then install
git clone https://github.com/hieutrtr/ralphmad.git /tmp/ralphmad
/tmp/ralphmad/install.sh .
```

This installs RalphMAD as commands in `.claude/commands/` and registers the stop hook in `.claude/settings.json`. Works with both Claude Code CLI and Claude Code on claude.ai (cloud sessions).

To uninstall:
```bash
/tmp/ralphmad/install.sh --uninstall .
```

#### Option B: Plugin (CLI only)

From your terminal (non-interactive):
```bash
claude plugin marketplace add hieutrtr/ralphmad
claude plugin install ralphmad@ralphmad
```

Or from inside a Claude Code session:
```
/plugin marketplace add hieutrtr/ralphmad
/plugin install ralphmad
```

For local development:
```bash
claude plugin marketplace add ./ralphmad
claude plugin install ralphmad@ralphmad --scope local
```

> **Note**: Plugins are not currently supported in Claude Code cloud sessions (claude.ai). Use Option A for cloud compatibility.

### 3. Create your product concept

Create `docs/product-concept.md` describing your product idea.
See `plugins/templates/product-concept-template.md` for a starter template.

### 4. Check status & run

```
/ralphmad-status
/ralphmad-loop product-brief
```

> If using the plugin installation (Option B), prefix commands with `ralphmad:` (e.g., `/ralphmad:ralphmad-status`).

## How It Works

```
User invokes: /ralphmad-loop product-brief
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
| 4 | Epic Dev | `epic-dev` | Implement all stories in an epic (auto-fixes high+medium test issues) |
| 4 | Correct Course | `correct-course` | Manage sprint changes |

## Commands

| Command (installed) | Command (plugin) | Description |
|-------------------|-------------------|-------------|
| `/ralphmad-loop WORKFLOW [--max-iterations N]` | `/ralphmad:ralphmad-loop ...` | Run a workflow |
| `/ralphmad-status` | `/ralphmad:ralphmad-status` | Show workflow status |
| `/ralphmad-cancel` | `/ralphmad:ralphmad-cancel` | Cancel active loop |
| `/ralphmad-help` | `/ralphmad:help` | Plugin documentation |

## Template System

Templates use `{{placeholder}}` syntax and are populated at runtime from:
- **Project config** (`_bmad/bmm/config.yaml`) — project name, artifact paths
- **Existing artifacts** (`_bmad-output/`) — context from previous workflows
- **Workflow config** (`ralphmad-config.yaml`) — promises, personas, prerequisites

This means the same templates work with any BMAD-enabled project.

### Configurable Options

The `epic-dev` workflow supports an `autofix_severity` option in `ralphmad-config.yaml`:

```yaml
epic-dev:
  # ...
  autofix_severity: "high and medium"   # default — auto-fix high+medium, log low as warnings
  # autofix_severity: "all"             # auto-fix all severity levels without prompting
```

This controls which test issue severities are automatically fixed during the autonomous loop. By default, only high and medium severity issues are auto-fixed to keep the loop running, while low severity issues are logged as warnings. Set to `"all"` to auto-fix every severity level.

## Coexistence with Ralph Loop

RalphMAD uses a separate state file (`.claude/ralphmad-loop.local.md`) from ralph-loop (`.claude/ralph-loop.local.md`), so both plugins can be installed simultaneously.

## Repository Structure

```
ralphmad/                          # GitHub repo / marketplace root
  install.sh               # Commands installer (CLI + cloud)
  .claude-plugin/
    marketplace.json               # Marketplace manifest
  plugins/                         # Plugin content (source)
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
  README.md
  LICENSE
```

## License

Apache License 2.0 — See [LICENSE](LICENSE)
