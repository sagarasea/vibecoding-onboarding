#!/usr/bin/env bash
# Pasang skill global buatan onboarding ke ~/.claude/skills/. Aman dijalankan ulang (versi lama diperbarui).
#
#   bash scripts/pasang-skill.sh
#
# belajar-lanjut: bisa dipanggil dari folder project mana pun saat bertanya "harus belajar apa lagi?".
# Skill-nya menunjuk ke folder onboarding ini, jadi kalau folder ini dipindah, jalankan ulang script ini.
# Windows: jalankan dari Git Bash.
set -e
DIR="$(cd "$(dirname "$0")/.." && (pwd -W 2>/dev/null || pwd))"

esc="${DIR//\\/\\\\}"; esc="${esc//&/\\&}"; esc="${esc//|/\\|}"
for src in "$DIR"/templates/skills/*/SKILL.md; do
  nama="$(basename "$(dirname "$src")")"
  tujuan="$HOME/.claude/skills/$nama"
  mkdir -p "$tujuan"
  sed "s|__ONBOARDING_DIR__|$esc|g" "$src" > "$tujuan/SKILL.md"
  echo "[OK] skill $nama terpasang di $tujuan (menunjuk ke $DIR)"
done
