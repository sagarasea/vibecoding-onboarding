#!/usr/bin/env bash
# Pasang dua pengaman. Aman dijalankan ulang.
#
#   bash scripts/pasang-pengaman.sh          # global: hook db-safety untuk Claude Code (semua project)
#   bash scripts/pasang-pengaman.sh --repo   # di folder project saat ini: scan rahasia (gitleaks) sebelum tiap commit
#
# 1. db-safety: Claude Code menolak menjalankan perintah database yang menghapus data
#    (migrate:fresh, DROP TABLE, TRUNCATE, dll). Aturannya juga tertulis di CLAUDE.md global,
#    tapi hook ini yang benar-benar memblokir, jadi agent tidak bisa "lupa".
# 2. gitleaks pre-commit: git menolak commit yang berisi API key atau token.
#
# Windows: jalankan dari Git Bash.
set -e
DIR="$(cd "$(dirname "$0")/.." && pwd)"

if [ "${1:-}" = "--repo" ]; then
  git rev-parse --git-dir >/dev/null 2>&1 || { echo "Bukan folder git. Masuk ke folder project dulu (cd nama-project)."; exit 1; }
  command -v gitleaks >/dev/null 2>&1 || { command -v brew >/dev/null 2>&1 && brew install gitleaks || echo "Install gitleaks dulu: winget install Gitleaks.Gitleaks"; }
  HOOK="$(git rev-parse --git-path hooks)/pre-commit"
  if [ -f "$HOOK" ] && ! grep -q 'gitleaks' "$HOOK"; then
    echo "Sudah ada pre-commit hook lain di $HOOK. Tidak ditimpa. Gabungkan manual bersama agent."
    exit 1
  fi
  cp "$DIR/templates/hooks/pre-commit" "$HOOK" && chmod +x "$HOOK"
  echo "[OK] Scan rahasia aktif di repo ini. Commit yang berisi API key atau token akan ditolak."
  exit 0
fi

mkdir -p "$HOME/.claude/hooks"
cp "$DIR/templates/hooks/db-safety.sh" "$HOME/.claude/hooks/db-safety.sh"
chmod +x "$HOME/.claude/hooks/db-safety.sh"
[ -f "$HOME/.claude/db-safety-patterns" ] || cp "$DIR/templates/hooks/db-safety-patterns" "$HOME/.claude/db-safety-patterns"

S="$HOME/.claude/settings.json"
[ -f "$S" ] || echo '{}' > "$S"
if grep -q 'db-safety.sh' "$S"; then
  echo "[OK] Hook db-safety sudah terdaftar di $S"
else
  cp "$S" "$S.bak-pengaman"
  CMD="$HOME/.claude/hooks/db-safety.sh"
  jq --arg cmd "$CMD" '.hooks.PreToolUse = ((.hooks.PreToolUse // []) + [{"matcher":"Bash","hooks":[{"type":"command","command":$cmd}]}])' "$S.bak-pengaman" > "$S"
  echo "[OK] Hook db-safety ditambahkan ke $S (cadangan: $S.bak-pengaman)"
fi
echo "Mulai sesi Claude Code baru supaya hook terbaca. Cek dengan /hooks."
