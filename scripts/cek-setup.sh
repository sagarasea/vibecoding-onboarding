#!/usr/bin/env bash
# Cek tools vibe coding di macOS / Linux. Tidak menginstall apa pun.
# Pakai: bash scripts/cek-setup.sh

ok=0; miss=0
cek() {
  local nama="$1" cmd="$2" ver="$3"
  if command -v "$cmd" >/dev/null 2>&1; then
    printf "  [OK]    %-12s %s\n" "$nama" "$(eval "$ver" 2>/dev/null | head -1)"
    ok=$((ok+1))
  else
    printf "  [BELUM] %-12s\n" "$nama"
    miss=$((miss+1))
  fi
}

echo "Tools dasar"
[ "$(uname)" = "Darwin" ] && cek "Homebrew" brew "brew --version"
cek "Git"        git     "git --version"
cek "GitHub CLI" gh      "gh --version"
cek "Node.js"    node    "node --version"
cek "npm"        npm     "npm --version"
cek "Python"     python3 "python3 --version"
cek "uv"         uv      "uv --version"
cek "VS Code"    code    "code --version"
cek "Claude Code" claude "claude --version"

echo
echo "Tools opsional (sesuai jalur minat)"
cek "Bun"        bun     "bun --version"
cek "ffmpeg"     ffmpeg  "ffmpeg -version"
cek "yt-dlp"     yt-dlp  "yt-dlp --version"
cek "Vercel CLI" vercel  "vercel --version"
cek "Supabase"   supabase "supabase --version"
cek "opencode"   opencode "opencode --version"
cek "Hermes"     hermes  "hermes --version"

echo
echo "Akun dan identitas"
if command -v gh >/dev/null 2>&1 && gh auth status >/dev/null 2>&1; then
  echo "  [OK]    GitHub login: $(gh api user --jq .login 2>/dev/null)"
else
  echo "  [BELUM] GitHub login (jalankan: gh auth login)"
fi
n="$(git config --global user.name 2>/dev/null)"; e="$(git config --global user.email 2>/dev/null)"
if [ -n "$n" ] && [ -n "$e" ]; then echo "  [OK]    git identity: $n <$e>"; else echo "  [BELUM] git identity (git config --global user.name / user.email)"; fi
[ -f "$HOME/.claude/CLAUDE.md" ] && echo "  [OK]    ~/.claude/CLAUDE.md ada" || echo "  [BELUM] ~/.claude/CLAUDE.md (lihat modul 06)"

echo
echo "Ringkasan: $ok terpasang, $miss belum."
