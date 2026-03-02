---
description: "Cancel active RalphMAD Loop"
allowed-tools: ["Bash(test -f .claude/ralphmad-loop.local.md:*)", "Bash(rm .claude/ralphmad-loop.local.md)", "Read(.claude/ralphmad-loop.local.md)"]
hide-from-slash-command-tool: "true"
---

# Cancel RalphMAD

To cancel the RalphMAD loop:

1. Check if `.claude/ralphmad-loop.local.md` exists using Bash: `test -f .claude/ralphmad-loop.local.md && echo "EXISTS" || echo "NOT_FOUND"`

2. **If NOT_FOUND**: Say "No active RalphMAD loop found."

3. **If EXISTS**:
   - Read `.claude/ralphmad-loop.local.md` to get the current iteration number from the `iteration:` field
   - Remove the file using Bash: `rm .claude/ralphmad-loop.local.md`
   - Report: "Cancelled RalphMAD loop (was at iteration N)" where N is the iteration value
