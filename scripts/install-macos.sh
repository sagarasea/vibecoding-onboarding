#!/usr/bin/env bash
# Installer sekali jalan untuk macOS. Aman dijalankan ulang: yang sudah ada dilewati.
# Pakai:
#   bash scripts/install-macos.sh            # tools dasar
#   bash scripts/install-macos.sh --web      # + Vercel CLI, Supabase CLI
#   bash scripts/install-macos.sh --video    # + ffmpeg, yt-dlp, deno
#   bash scripts/install-macos.sh --agent    # + opencode, Hermes Agent, 9router
#   bash scripts/install-macos.sh --semua    # semua di atas
set -e

WEB=0; VIDEO=0; AGENT=0
for a in "$@"; do
  case "$a" in
    --web) WEB=1 ;;
    --video) VIDEO=1 ;;
    --agent) AGENT=1 ;;
    --semua) WEB=1; VIDEO=1; AGENT=1 ;;
  esac
done

ada() { command -v "$1" >/dev/null 2>&1; }
langkah() { printf "\n==> %s\n" "$1"; }

langkah "Homebrew"
if ! ada brew; then
  echo "Homebrew belum ada. Installer akan minta password Mac kamu (ketik sendiri, tidak terlihat saat diketik)."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  [ -x /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"
  grep -q 'brew shellenv' ~/.zprofile 2>/dev/null || echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
else
  echo "sudah ada"
fi

langkah "Tools dasar: git, gh, node, uv"
for p in git gh node uv; do
  if ada "$p"; then echo "$p sudah ada"; else brew install "$p"; fi
done

langkah "VS Code"
if ada code || [ -d "/Applications/Visual Studio Code.app" ]; then echo "sudah ada"; else brew install --cask visual-studio-code; fi

langkah "Claude Code (native installer, update otomatis)"
if ada claude; then echo "sudah ada: $(claude --version)"; else curl -fsSL https://claude.ai/install.sh | bash; fi

langkah "Claude Desktop"
if [ -d "/Applications/Claude.app" ]; then echo "sudah ada"; else brew install --cask claude; fi

if [ $WEB = 1 ]; then
  langkah "Jalur web: Vercel CLI, Supabase CLI"
  ada vercel || npm install -g vercel
  ada supabase || brew install supabase/tap/supabase
fi

if [ $VIDEO = 1 ]; then
  langkah "Jalur video: ffmpeg, yt-dlp, deno"
  for p in ffmpeg yt-dlp deno; do
    if ada "$p"; then echo "$p sudah ada"; else brew install "$p"; fi
  done
fi

if [ $AGENT = 1 ]; then
  langkah "Jalur agent: opencode, Hermes Agent, 9router"
  ada opencode || curl -fsSL https://opencode.ai/install | bash
  ada hermes || curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash
  ada 9router || npm install -g 9router
fi

langkah "Selesai. Buka terminal baru, lalu cek:"
echo "  bash scripts/cek-setup.sh"
