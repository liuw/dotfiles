#!/usr/bin/env bash
#
# Link all supported agent CLIs to a single canonical user-level instructions file.
#
# Canonical source of truth:  ~/.config/agents/AGENTS.md
# Edit that one file; every tool below reads it via a symlink.
#
# Safe to re-run: existing correct symlinks are left alone, and any real file or
# wrong symlink is backed up to <path>.bak before being replaced.

set -euo pipefail

CANON="${HOME}/.config/agents/AGENTS.md"

# Tool path -> canonical file. Add new tools here.
TARGETS=(
  "${HOME}/.copilot/copilot-instructions.md"   # GitHub Copilot CLI
  "${HOME}/.pi/agent/AGENTS.md"                 # pi
  "${HOME}/.config/opencode/AGENTS.md"          # opencode
  "${HOME}/.claude/CLAUDE.md"                   # claude
)

if [[ ! -f "${CANON}" ]]; then
  echo "error: canonical file not found: ${CANON}" >&2
  echo "create it first, then re-run this script." >&2
  exit 1
fi

link_one() {
  local target="$1"
  local dir
  dir="$(dirname "${target}")"

  # Only create the parent dir if the tool already uses it; otherwise skip so we
  # don't scaffold config for tools that aren't installed.
  if [[ ! -d "${dir}" ]]; then
    echo "skip:   ${target} (parent dir ${dir} does not exist)"
    return
  fi

  # Already the correct symlink -> nothing to do.
  if [[ -L "${target}" && "$(readlink -f "${target}")" == "${CANON}" ]]; then
    echo "ok:     ${target} (already linked)"
    return
  fi

  # Existing symlink pointing elsewhere, or a real file/dir -> back it up.
  if [[ -e "${target}" || -L "${target}" ]]; then
    local backup="${target}.bak"
    if [[ -e "${backup}" || -L "${backup}" ]]; then
      backup="${target}.bak.$(date +%Y%m%d%H%M%S)"
    fi
    mv "${target}" "${backup}"
    echo "backup: ${target} -> ${backup}"
  fi

  ln -s "${CANON}" "${target}"
  echo "link:   ${target} -> ${CANON}"
}

for t in "${TARGETS[@]}"; do
  link_one "${t}"
done

echo "done."
