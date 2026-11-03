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
cek "jq"         jq      "jq --version"
cek "gitleaks"   gitleaks "gitleaks version"
cek "VS Code"    code    "code --version"
cek "Claude Code" claude "claude --version"
cek "Codex"      codex   "codex --version"
cek "opencode"   opencode "opencode --version"

echo
echo "Tools opsional (sesuai jalur minat)"
cek "Bun"        bun     "bun --version"
cek "ffmpeg"     ffmpeg  "ffmpeg -version"
cek "yt-dlp"     yt-dlp  "yt-dlp --version"
cek "Vercel CLI" vercel  "vercel --version"
cek "Supabase"   supabase "supabase --version"
cek "Wrangler"   wrangler "wrangler --version"
cek "cloudflared" cloudflared "cloudflared --version"
cek "Docker"     docker  "docker --version"
cek "ImageMagick" magick "magick -version"
cek "whisper.cpp" whisper-cli "echo terpasang"
cek "Ollama"     ollama  "ollama --version"
cek "Gemini CLI" gemini  "gemini --version"
cek "9router"    9router "echo terpasang"
cek "Hermes"     hermes  "hermes --version"

echo
echo "MCP (Claude Code)"
if command -v claude >/dev/null 2>&1; then
  for m in playwright chrome-devtools context7; do
    if claude mcp get "$m" >/dev/null 2>&1; then echo "  [OK]    MCP $m"; else echo "  [BELUM] MCP $m (modul 07)"; fi
  done
fi

echo
echo "Akun dan identitas"
if command -v gh >/dev/null 2>&1 && gh auth status >/dev/null 2>&1; then
  echo "  [OK]    GitHub login: $(gh api user --jq .login 2>/dev/null)"
else
  echo "  [BELUM] GitHub login (jalankan: gh auth login)"
fi
n="$(git config --global user.name 2>/dev/null)"; e="$(git config --global user.email 2>/dev/null)"
if [ -n "$n" ] && [ -n "$e" ]; then echo "  [OK]    git identity: $n <$e>"; else echo "  [BELUM] git identity (git config --global user.name / user.email)"; fi
grep -q db-safety "$HOME/.claude/settings.json" 2>/dev/null && echo "  [OK]    hook db-safety aktif" || echo "  [BELUM] hook db-safety (bash scripts/pasang-pengaman.sh)"
[ -f "$HOME/.claude/CLAUDE.md" ] && echo "  [OK]    ~/.claude/CLAUDE.md ada" || echo "  [BELUM] ~/.claude/CLAUDE.md (lihat modul 06)"

echo
echo "Ringkasan: $ok terpasang, $miss belum."
