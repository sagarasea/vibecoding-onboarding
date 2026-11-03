#!/usr/bin/env bash
# Installer sekali jalan untuk macOS. Aman dijalankan ulang: yang sudah ada dilewati.
# Daftar lengkap dan fungsi tiap tool: referensi/katalog-tools.md
# Pakai:
#   bash scripts/install-macos.sh            # tools dasar + ekstensi VS Code + MCP Playwright & Chrome DevTools
#   bash scripts/install-macos.sh --web      # + Vercel, Supabase, Wrangler, Docker Desktop, browser Playwright, MCP Vercel
#   bash scripts/install-macos.sh --video    # + ffmpeg, yt-dlp, deno, ImageMagick, whisper.cpp
#   bash scripts/install-macos.sh --agent    # + opencode, Hermes Agent, 9router, Ollama, Gemini CLI
#   bash scripts/install-macos.sh --desain   # + Figma Desktop, MCP Jiro
#   bash scripts/install-macos.sh --craft    # + ArtCraft suite (FigCraft, EffectCraft, FilmCraft, dll) untuk laptop kuat
#   bash scripts/install-macos.sh --semua    # semua di atas kecuali --craft
set -e

WEB=0; VIDEO=0; AGENT=0; DESAIN=0; CRAFT=0
for a in "$@"; do
  case "$a" in
    --web) WEB=1 ;;
    --video) VIDEO=1 ;;
    --agent) AGENT=1 ;;
    --desain) DESAIN=1 ;;
    --craft) CRAFT=1 ;;
    --semua) WEB=1; VIDEO=1; AGENT=1; DESAIN=1 ;;
  esac
done

ada() { command -v "$1" >/dev/null 2>&1; }
langkah() { printf "\n==> %s\n" "$1"; }
brew_f() { for p in "$@"; do if brew list --formula "$p" >/dev/null 2>&1 || ada "$p"; then echo "$p sudah ada"; else brew install "$p"; fi; done; }
brew_c() { local cask="$1" app="$2"; if [ -d "/Applications/$app.app" ] || brew list --cask "$cask" >/dev/null 2>&1; then echo "$app sudah ada"; else brew install --cask "$cask"; fi; }
mcp_add() { local nama="$1"; shift; if claude mcp get "$nama" >/dev/null 2>&1; then echo "MCP $nama sudah ada"; else claude mcp add --scope user "$nama" "$@"; fi; }

langkah "Homebrew"
[ -x /opt/homebrew/bin/brew ] && ! ada brew && eval "$(/opt/homebrew/bin/brew shellenv)"
if ! ada brew; then
  if [ ! -t 0 ]; then
    # Dijalankan oleh AI agent (tanpa terminal interaktif): installer Homebrew butuh password,
    # jadi bukakan jendela Terminal baru untuk orangnya, lalu berhenti.
    osascript -e 'tell application "Terminal" to activate' \
      -e 'tell application "Terminal" to do script "/bin/bash -c \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\" && echo \"eval \\\"\\$(/opt/homebrew/bin/brew shellenv)\\\"\" >> ~/.zprofile && echo SELESAI, tutup jendela ini"'
    echo "Jendela Terminal baru dibuka untuk install Homebrew. Ketik password Mac di sana."
    echo "Setelah muncul SELESAI, jalankan ulang: bash scripts/install-macos.sh $*"
    exit 0
  fi
  echo "Homebrew belum ada. Installer akan minta password Mac kamu (ketik sendiri, tidak terlihat saat diketik)."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  [ -x /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"
  grep -q 'brew shellenv' ~/.zprofile 2>/dev/null || echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
else
  echo "sudah ada"
fi

langkah "Tools dasar: git, gh, node, uv, jq"
brew_f git gh node uv jq

langkah "Aplikasi: VS Code, Claude Desktop, Google Chrome"
brew_c visual-studio-code "Visual Studio Code"
brew_c claude "Claude"
brew_c google-chrome "Google Chrome"

langkah "Claude Code (native installer, update otomatis)"
if ada claude; then echo "sudah ada: $(claude --version)"; else curl -fsSL https://claude.ai/install.sh | bash; export PATH="$HOME/.local/bin:$PATH"; fi

langkah "Ekstensi VS Code"
CODE_BIN="code"
ada code || CODE_BIN="/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"
for ext in anthropic.claude-code dbaeumer.vscode-eslint esbenp.prettier-vscode bradlc.vscode-tailwindcss ms-python.python ms-playwright.playwright eamodio.gitlens; do
  "$CODE_BIN" --install-extension "$ext" --force >/dev/null 2>&1 && echo "$ext ok" || echo "$ext gagal (install manual dari VS Code)"
done

langkah "MCP dasar: Playwright, Chrome DevTools"
if ada claude; then
  mcp_add playwright -- npx @playwright/mcp@latest
  mcp_add chrome-devtools -- npx chrome-devtools-mcp@latest
  echo "Context7 butuh login di browser: jalankan manual 'npx ctx7 setup --claude' (modul 07)."
else
  echo "claude belum terbaca. Buka terminal baru lalu jalankan ulang script ini."
fi

if [ $WEB = 1 ]; then
  langkah "Jalur web: Vercel, Supabase, Wrangler, Docker Desktop, browser Playwright"
  ada vercel || npm install -g vercel
  ada wrangler || npm install -g wrangler
  ada supabase || brew install supabase/tap/supabase
  brew_c docker-desktop "Docker"
  npx -y playwright install chromium
  ada claude && mcp_add vercel --transport http https://mcp.vercel.com
fi

if [ $VIDEO = 1 ]; then
  langkah "Jalur video: ffmpeg, yt-dlp, deno, ImageMagick, whisper.cpp"
  brew_f ffmpeg yt-dlp deno imagemagick whisper-cpp
fi

if [ $AGENT = 1 ]; then
  langkah "Jalur agent: opencode, Hermes Agent, 9router, Ollama, Gemini CLI"
  ada opencode || curl -fsSL https://opencode.ai/install | bash
  ada hermes || curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash
  ada 9router || npm install -g 9router
  ada gemini || npm install -g @google/gemini-cli
  brew_c ollama-app "Ollama"
fi

if [ $DESAIN = 1 ]; then
  langkah "Jalur desain: Figma Desktop, MCP Jiro"
  brew_c figma "Figma"
  ada claude && mcp_add jiro --transport http https://mcp.jiro.build
fi

if [ $CRAFT = 1 ]; then
  langkah "Jalur laptop kuat: ArtCraft suite (FigCraft, EffectCraft, FilmCraft, PhotoCraft, VectorCraft, DeckCraft) + CLI"
  brew_c artcraft-launcher "ArtCraft Launcher"
  brew_c figcraft "FigCraft"
  brew_c effectcraft "EffectCraft"
  brew_c filmcraft "FilmCraft"
  brew_c photocraft "PhotoCraft"
  brew_c vectorcraft "VectorCraft"
  brew_c deckcraft "DeckCraft"
  brew_f filmcraft-cli photocraft-cli pdfcraft-cli
  echo "MCP FigCraft butuh figcraft-cli dari https://getartcraft.com/apps/figcraft, lalu:"
  echo "  claude mcp add --scope user figcraft -- bash \"$(pwd)/scripts/figcraft-mcp.sh\""
fi

langkah "Selesai. Buka terminal baru, lalu cek:"
echo "  bash scripts/cek-setup.sh"
echo "Langkah berikutnya yang butuh login di browser: gh auth login, claude (login), npx ctx7 setup --claude, /mcp untuk MCP OAuth."
