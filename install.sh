#!/bin/bash

# RalphMAD Installer
# Installs RalphMAD as Claude Code commands (works on both CLI and cloud)
# Usage:
#   curl -sL https://raw.githubusercontent.com/hieutrtr/ralphmad/main/install.sh | bash
#   /path/to/install.sh [TARGET_DIR]
#   /path/to/install.sh --uninstall [TARGET_DIR]

set -euo pipefail

# --- Configuration ---
COMMANDS_DIR=".claude/commands"
ASSETS_DIR=".claude/ralphmad"
SCRIPTS_ROOT=".claude/scripts"
SETTINGS_FILE=".claude/settings.json"

COMMAND_FILES=(
  "ralphmad-loop"
  "ralphmad-status"
  "ralphmad-cancel"
  "ralphmad-help"
)

# --- Helpers ---
info()  { echo "  $1"; }
ok()    { echo "  [ok] $1"; }
err()   { echo "  [error] $1" >&2; }
warn()  { echo "  [warn] $1"; }

# --- Detect source directory (where this script + plugins/ live) ---
detect_source_dir() {
  if [[ -n "${BASH_SOURCE[0]:-}" ]] && [[ -f "${BASH_SOURCE[0]}" ]]; then
    local script_path
    script_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    if [[ -d "$script_path/plugins" ]]; then
      echo "$script_path"
      return
    fi
  fi

  # Fallback: clone to temp directory
  echo ""
}

# --- Uninstall ---
uninstall() {
  local target_dir="${1:-.}"
  echo ""
  echo "RalphMAD Uninstaller"
  echo "===================="
  echo ""

  local removed=0

  for cmd in "${COMMAND_FILES[@]}"; do
    local cmd_file="$target_dir/$COMMANDS_DIR/$cmd.md"
    if [[ -f "$cmd_file" ]]; then
      rm "$cmd_file"
      ok "Removed $COMMANDS_DIR/$cmd.md"
      ((removed++))
    fi
  done

  if [[ -d "$target_dir/$ASSETS_DIR" ]]; then
    rm -rf "$target_dir/$ASSETS_DIR"
    ok "Removed $ASSETS_DIR/"
    ((removed++))
  fi

  local hook_script="$target_dir/$SCRIPTS_ROOT/ralphmad-stop-hook.sh"
  if [[ -f "$hook_script" ]]; then
    rm "$hook_script"
    ok "Removed $SCRIPTS_ROOT/ralphmad-stop-hook.sh"
    ((removed++))
  fi

  # Remove stop hook from settings.json
  local settings="$target_dir/$SETTINGS_FILE"
  if [[ -f "$settings" ]] && command -v jq &>/dev/null; then
    if jq -e '.hooks.Stop' "$settings" &>/dev/null; then
      local updated
      updated=$(jq '
        .hooks.Stop = [.hooks.Stop[] | select(.hooks | all(.command != ".claude/scripts/ralphmad-stop-hook.sh"))]
        | if (.hooks.Stop | length) == 0 then del(.hooks.Stop) else . end
        | if (.hooks | length) == 0 then del(.hooks) else . end
      ' "$settings")
      echo "$updated" > "$settings"
      ok "Removed stop hook from $SETTINGS_FILE"
      ((removed++))
    fi
  fi

  echo ""
  if [[ $removed -gt 0 ]]; then
    echo "Uninstalled $removed RalphMAD components."
  else
    echo "Nothing to uninstall — RalphMAD not found."
  fi
}

# --- Install ---
install() {
  local source_dir="$1"
  local target_dir="$2"
  local cloned_tmp=""

  echo ""
  echo "RalphMAD Installer"
  echo "=================="
  echo ""

  # If no local source, clone from GitHub
  if [[ -z "$source_dir" ]]; then
    cloned_tmp="$(mktemp -d)"
    info "Cloning RalphMAD from GitHub..."
    git clone --depth 1 --quiet https://github.com/hieutrtr/ralphmad.git "$cloned_tmp"
    source_dir="$cloned_tmp"
    ok "Cloned to temporary directory"
  fi

  local plugins_dir="$source_dir/plugins"

  # Validate source
  if [[ ! -d "$plugins_dir/commands" ]]; then
    err "Source directory missing plugins/commands/. Not a valid RalphMAD repo."
    [[ -n "$cloned_tmp" ]] && rm -rf "$cloned_tmp"
    exit 1
  fi

  # Resolve target to absolute
  target_dir="$(cd "$target_dir" && pwd)"

  info "Source:  $plugins_dir"
  info "Target:  $target_dir"
  echo ""

  # --- Create directories ---
  mkdir -p "$target_dir/$COMMANDS_DIR"
  mkdir -p "$target_dir/$ASSETS_DIR/templates"
  mkdir -p "$target_dir/$ASSETS_DIR/scripts"
  mkdir -p "$target_dir/$SCRIPTS_ROOT"

  # --- Path replacement value ---
  local assets_path=".claude/ralphmad"

  # --- Copy command files with transformations ---
  copy_command() {
    local cmd_name="$1"
    local src_file="$2"
    local src="$plugins_dir/commands/$src_file"
    local dst="$target_dir/$COMMANDS_DIR/$cmd_name.md"

    sed \
      -e "s|\${CLAUDE_PLUGIN_ROOT}|$assets_path|g" \
      -e 's|/ralphmad-loop:ralphmad-loop |/ralphmad-loop |g' \
      -e 's|/ralphmad-loop:ralphmad-status|/ralphmad-status|g' \
      -e 's|/ralphmad-loop:ralphmad-cancel|/ralphmad-cancel|g' \
      -e 's|/ralphmad-loop:help|/ralphmad-help|g' \
      -e 's|/ralphmad:ralphmad-loop |/ralphmad-loop |g' \
      -e 's|/ralphmad:ralphmad-status|/ralphmad-status|g' \
      -e 's|/ralphmad:ralphmad-cancel|/ralphmad-cancel|g' \
      -e 's|/ralphmad:help|/ralphmad-help|g' \
      "$src" > "$dst"
    ok "Installed $COMMANDS_DIR/$cmd_name.md"
  }

  copy_command "ralphmad-loop"   "ralphmad-loop.md"
  copy_command "ralphmad-status" "ralphmad-status.md"
  copy_command "ralphmad-cancel" "ralphmad-cancel.md"
  copy_command "ralphmad-help"   "help.md"

  # --- Copy templates ---
  local template_count=0
  for tpl in "$plugins_dir"/templates/*; do
    local filename
    filename="$(basename "$tpl")"
    cp "$tpl" "$target_dir/$ASSETS_DIR/templates/$filename"
    ((template_count++))
  done
  # Transform namespace references in product-concept-template.md
  local concept_tpl="$target_dir/$ASSETS_DIR/templates/product-concept-template.md"
  if [[ -f "$concept_tpl" ]]; then
    sed -i.bak \
      -e 's|/ralphmad-loop:ralphmad-loop |/ralphmad-loop |g' \
      -e 's|/ralphmad:ralphmad-loop |/ralphmad-loop |g' \
      "$concept_tpl"
    rm -f "$concept_tpl.bak"
  fi
  ok "Installed $template_count templates to $ASSETS_DIR/templates/"

  # --- Copy scripts ---
  cp "$plugins_dir/scripts/setup-ralphmad.sh" "$target_dir/$ASSETS_DIR/scripts/setup-ralphmad.sh"
  chmod +x "$target_dir/$ASSETS_DIR/scripts/setup-ralphmad.sh"
  ok "Installed $ASSETS_DIR/scripts/setup-ralphmad.sh"

  # --- Copy stop hook ---
  cp "$plugins_dir/hooks/stop-hook.sh" "$target_dir/$SCRIPTS_ROOT/ralphmad-stop-hook.sh"
  chmod +x "$target_dir/$SCRIPTS_ROOT/ralphmad-stop-hook.sh"
  ok "Installed $SCRIPTS_ROOT/ralphmad-stop-hook.sh"

  # --- Merge stop hook into settings.json ---
  local settings="$target_dir/$SETTINGS_FILE"
  local hook_entry='{"type":"command","command":".claude/scripts/ralphmad-stop-hook.sh"}'

  if command -v jq &>/dev/null; then
    if [[ -f "$settings" ]]; then
      local has_hook
      has_hook=$(jq --arg cmd ".claude/scripts/ralphmad-stop-hook.sh" '
        (.hooks.Stop // []) | map(.hooks[]? | select(.command == $cmd)) | length
      ' "$settings" 2>/dev/null || echo "0")

      if [[ "$has_hook" -gt 0 ]]; then
        warn "Stop hook already registered in $SETTINGS_FILE (skipped)"
      else
        local updated
        updated=$(jq --argjson entry "$hook_entry" '
          .hooks //= {}
          | .hooks.Stop //= []
          | .hooks.Stop += [{"hooks": [$entry]}]
        ' "$settings")
        echo "$updated" > "$settings"
        ok "Registered stop hook in $SETTINGS_FILE"
      fi
    else
      mkdir -p "$(dirname "$settings")"
      jq -n --argjson entry "$hook_entry" '
        {
          "hooks": {
            "Stop": [
              {"hooks": [$entry]}
            ]
          }
        }
      ' > "$settings"
      ok "Created $SETTINGS_FILE with stop hook"
    fi
  else
    warn "jq not found — cannot register stop hook in $SETTINGS_FILE"
    warn "Manually add to $SETTINGS_FILE:"
    warn '  "hooks": {"Stop": [{"hooks": ['"$hook_entry"']}]}'
  fi

  # --- Cleanup temp clone ---
  if [[ -n "$cloned_tmp" ]]; then
    rm -rf "$cloned_tmp"
  fi

  # --- Summary ---
  echo ""
  echo "Installation complete!"
  echo ""
  echo "Installed commands:"
  echo "  /ralphmad-loop    — Run a BMAD workflow autonomously"
  echo "  /ralphmad-status  — Show workflow status and prerequisites"
  echo "  /ralphmad-cancel  — Cancel active RalphMAD loop"
  echo "  /ralphmad-help    — Documentation"
  echo ""
  echo "Next steps:"
  echo "  1. Open Claude Code in your project"
  echo "  2. Run /ralphmad-status to check workflow readiness"
  echo "  3. Run /ralphmad-loop product-brief to start"
}

# --- Main ---
main() {
  local action="install"
  local target_dir="."

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --uninstall)
        action="uninstall"
        shift
        ;;
      -h|--help)
        echo "Usage: install.sh [OPTIONS] [TARGET_DIR]"
        echo ""
        echo "Install RalphMAD as Claude Code commands in a target project."
        echo ""
        echo "Arguments:"
        echo "  TARGET_DIR         Project directory (default: current directory)"
        echo ""
        echo "Options:"
        echo "  --uninstall        Remove RalphMAD from the target project"
        echo "  -h, --help         Show this help message"
        echo ""
        echo "Examples:"
        echo "  # Install in current directory"
        echo "  ./install.sh"
        echo ""
        echo "  # Install in a specific project"
        echo "  ./install.sh /path/to/my-project"
        echo ""
        echo "  # Install via curl (from target project directory)"
        echo "  curl -sL https://raw.githubusercontent.com/hieutrtr/ralphmad/main/install.sh | bash"
        echo ""
        echo "  # Uninstall"
        echo "  ./install.sh --uninstall"
        exit 0
        ;;
      *)
        target_dir="$1"
        shift
        ;;
    esac
  done

  if [[ ! -d "$target_dir" ]]; then
    err "Target directory does not exist: $target_dir"
    exit 1
  fi

  if [[ "$action" == "uninstall" ]]; then
    uninstall "$target_dir"
  else
    local source_dir
    source_dir="$(detect_source_dir)"
    install "$source_dir" "$target_dir"
  fi
}

main "$@"
