---
description: "Show RalphMAD workflow status and prerequisites"
allowed-tools: ["Read", "Glob", "Grep"]
---

# RalphMAD Status

Show the status of all RalphMAD workflows for the current project.

## Instructions

1. Read `${CLAUDE_PLUGIN_ROOT}/templates/ralphmad-config.yaml` to get the workflow registry
2. Read `_bmad/bmm/config.yaml` to get the project config (planning_artifacts and implementation_artifacts paths)
3. If project config doesn't exist, report: "Not a BMAD-enabled project. No _bmad/bmm/config.yaml found."

4. For each workflow, check its status by scanning for produced artifacts:
   - Use the `artifact_patterns` from the config to glob for files
   - Check in the appropriate directory (planning_artifacts or implementation_artifacts)

5. Determine status for each workflow:
   - **DONE** — at least one artifact matching the pattern exists
   - **READY** — all prerequisites are DONE, workflow can run
   - **BLOCKED** — one or more prerequisites are missing; list which ones

6. Display results as a table grouped by phase:

```
RalphMAD Workflow Status — {project_name}
══════════════════════════════════════════

Phase 1: Analysis
  product-brief          DONE ✓    (product-brief-*.md found)

Phase 2: Planning
  prd-create             READY     (prereqs: product_brief ✓)
  ux-design              BLOCKED   (missing: prd)

Phase 3: Solutioning
  architecture           BLOCKED   (missing: prd, ux_design)
  epics-stories          BLOCKED   (missing: prd, architecture)
  test-design            BLOCKED   (missing: architecture, prd)
  testarch-framework     BLOCKED   (missing: test_design, architecture)
  testarch-ci            BLOCKED   (missing: test_framework)

Phase 4: Implementation
  sprint-planning        BLOCKED   (missing: epics)
  testarch-test-design   BLOCKED   (missing: epics, test_design)
  epic-dev               BLOCKED   (missing: sprint_status, epics, architecture)
  correct-course         BLOCKED   (missing: sprint_status)
```

7. Also check if there's an active RalphMAD loop by checking for `.claude/ralphmad-loop.local.md`.
   If active, display the current iteration and workflow info.
