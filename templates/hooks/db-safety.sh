#!/usr/bin/env bash
# PreToolUse hook (global, semua repo): defense-in-depth terhadap perintah
# destruktif ke DB. Pattern dibaca dari ~/.claude/db-safety-patterns (single
# source of truth, file yang sama juga dibaca plugin opencode).
#
# SELALU block kalau match pattern destruktif, no exception. Kalau command ini
# bener-bener perlu dijalankan, minta konfirmasi eksplisit user di turn yang
# sama dulu, baru jalankan manual (hook ini akan block lagi kalau dicoba lewat
# tool call).

set -euo pipefail

PATTERN_FILE="$HOME/.claude/db-safety-patterns"

input=$(cat)
command=$(printf '%s' "$input" | python3 -c 'import json,sys; print(json.load(sys.stdin).get("tool_input",{}).get("command",""))' 2>/dev/null || echo "")

pattern=$(grep -v '^[[:space:]]*#' "$PATTERN_FILE" | tr -d '\n' 2>/dev/null || true)

if [ -z "$pattern" ]; then
    exit 0
fi

if ! printf '%s' "$command" | grep -qiE "$pattern"; then
    exit 0
fi

echo "[db-safety] DESTRUCTIVE DB COMMAND DETECTED, BLOCKED:" >&2
echo "[db-safety]   $command" >&2
echo "[db-safety]" >&2
echo "[db-safety] Rule lengkap & cara restore: lihat section 'Database Safety' di CLAUDE.md." >&2
echo "[db-safety] Kalau command ini BENER-BENER perlu dijalankan:" >&2
echo "[db-safety]   1. Minta user konfirmasi eksplisit di turn yang sama." >&2
echo "[db-safety]   2. Baru jalankan manual (hook ini akan block lagi kalau dicoba lewat tool call)." >&2

exit 2
