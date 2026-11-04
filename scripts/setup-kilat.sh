#!/usr/bin/env bash
# Jalur kilat macOS: install tools dan konfigurasi agent dalam satu perintah.
# Aman dijalankan ulang: yang sudah ada dilewati, file yang sudah ada tidak ditimpa.
# Pakai (agent yang menjalankan, flag sesuai minat di PROGRESS.md):
#   GIT_NAME="Nama Kamu" GIT_EMAIL="email@kamu.com" bash scripts/setup-kilat.sh --web --video
# Flag sama dengan install-macos.sh: --web --video --agent --desain --craft --semua
# Urutan: 1 install tools, 2 identitas git, 3 aturan global agent, 4 pengaman, 5 plugin dasar, 6 cek, 7 daftar login.
set -e
cd "$(dirname "$0")/.."

VIDEO=0
for a in "$@"; do case "$a" in --video|--semua) VIDEO=1 ;; esac; done

langkah() { printf "\n==> [kilat %s] %s\n" "$1" "$2"; shift 2; for u in "$@"; do printf "    - %s\n" "$u"; done; }

langkah 1/7 "Install tools (scripts/install-macos.sh $*)"
bash scripts/install-macos.sh "$@"
[ -x /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="$HOME/.local/bin:$HOME/.opencode/bin:$PATH"
if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew belum selesai terpasang. Setelah jendela Terminal-nya bilang SELESAI, jalankan ulang perintah yang sama."
  exit 0
fi

langkah 2/7 "Identitas git" "nama dan email yang tercatat di setiap commit"
if [ -n "$(git config --global user.name)" ] && [ -n "$(git config --global user.email)" ]; then
  echo "sudah ada: $(git config --global user.name) <$(git config --global user.email)>"
elif [ -n "$GIT_NAME" ] && [ -n "$GIT_EMAIL" ]; then
  git config --global user.name "$GIT_NAME"
  git config --global user.email "$GIT_EMAIL"
  git config --global init.defaultBranch main
  echo "dipasang: $GIT_NAME <$GIT_EMAIL>"
else
  echo "BELUM: jalankan ulang dengan GIT_NAME dan GIT_EMAIL, atau isi manual (modul 05)."
fi

langkah 3/7 "Aturan kerja global agent" "~/.claude/CLAUDE.md untuk Claude Code, ~/.codex/AGENTS.md untuk Codex (Karpathy + aturan mentor)"
pasang_aturan() {
  local tujuan="$1"
  mkdir -p "$(dirname "$tujuan")"
  if [ ! -f "$tujuan" ]; then
    cp templates/CLAUDE.global.md "$tujuan"; echo "dipasang: $tujuan"
  elif cmp -s templates/CLAUDE.global.md "$tujuan"; then
    echo "sudah sama: $tujuan"
  else
    cp templates/CLAUDE.global.md "$tujuan.onboarding"
    echo "PERLU DIGABUNG: $tujuan sudah ada dan isinya beda. Template disimpan di $tujuan.onboarding, agent gabungkan bareng kamu."
  fi
}
pasang_aturan "$HOME/.claude/CLAUDE.md"
pasang_aturan "$HOME/.codex/AGENTS.md"

langkah 4/7 "Pengaman" "hook db-safety: perintah database yang menghapus data diblokir sebelum jalan"
bash scripts/pasang-pengaman.sh

langkah 5/7 "Plugin dasar Claude Code" "antislop: filter hasil generik" "frontend-design: UI yang tidak template" "(video) hyperframes dan watch"
if command -v claude >/dev/null 2>&1; then
  terpasang="$(claude plugin list 2>/dev/null || true)"
  plugin() {
    local id="$1" market="$2"
    if printf "%s" "$terpasang" | grep -q "$id"; then echo "$id sudah ada"; return; fi
    [ -n "$market" ] && { claude plugin marketplace add "$market" >/dev/null 2>&1 || true; }
    claude plugin install "$id" || echo "$id gagal, pasang manual lewat /plugin (modul 07)"
  }
  plugin antislop@anti-slop miqdadbadjuber/anti-slop
  plugin frontend-design@claude-plugins-official anthropics/claude-plugins-official   # di mesin baru marketplace resmi belum terdaftar sebelum sesi pertama
  if [ $VIDEO = 1 ]; then
    plugin hyperframes@hyperframes heygen-com/hyperframes
    plugin watch@claude-video bradautomates/claude-video
  fi
else
  echo "claude belum terbaca. Buka terminal baru, lalu jalankan ulang perintah yang sama."
fi

langkah 6/7 "Cek setup"
bash scripts/cek-setup.sh || true

langkah 7/7 "Tinggal login (butuh browser, satu per satu, agent yang membukakan)"
cat <<'EOF'
    1. claude            lalu /login, pilih akun Claude.ai (langganan Pro/Max)
    2. gh auth login --hostname github.com --git-protocol https --web
    3. codex login       (kalau punya ChatGPT Plus)
    4. opencode          lalu /models, pilih model -free
    5. npx ctx7 setup --claude          (Context7, dokumentasi library terbaru)
    6. npx antislop-ai   (antislop untuk Codex dan opencode, pilih global + mode during)
    7. --web:   vercel login, wrangler login, supabase login
    8. --agent: hermes setup (modul 10)
Setelah semua login: bash scripts/cek-setup.sh, lalu lanjut modul 13.
EOF
