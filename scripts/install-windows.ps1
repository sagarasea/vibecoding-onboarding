# Installer sekali jalan untuk Windows 10/11. Aman dijalankan ulang: yang sudah ada dilewati.
# Daftar lengkap dan fungsi tiap tool: referensi\katalog-tools.md
# Jalankan di PowerShell biasa (bukan Administrator):
#   powershell -ExecutionPolicy Bypass -File scripts\install-windows.ps1
#   tambahkan -Web, -Video, -Agent, -Desain, -Craft (laptop kuat), atau -Semua (semua kecuali -Craft).
param([switch]$Web, [switch]$Video, [switch]$Agent, [switch]$Desain, [switch]$Craft, [switch]$Semua)
if ($Semua) { $Web = $true; $Video = $true; $Agent = $true; $Desain = $true }

function Ada($cmd) { [bool](Get-Command $cmd -ErrorAction SilentlyContinue) }
function Langkah($t, [string[]]$untuk = @()) { Write-Host "`n==> $t" -ForegroundColor Cyan; foreach ($u in $untuk) { Write-Host "    - $u" } }
function Winget($id, $cmd) {
  if ($cmd -and (Ada $cmd)) { Write-Host "$cmd sudah ada"; return }
  winget install --id $id -e --source winget --accept-package-agreements --accept-source-agreements
}
function Segarkan-Path {
  $env:Path = [Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [Environment]::GetEnvironmentVariable("Path", "User")
}
function Mcp-Add($nama, [string[]]$argumen) {
  claude mcp get $nama *> $null
  if ($LASTEXITCODE -eq 0) { Write-Host "MCP $nama sudah ada" } else { & claude mcp add --scope user $nama @argumen }
}

if (-not (Ada winget)) {
  Write-Host "winget belum ada. Buka Microsoft Store, install/update 'App Installer', lalu jalankan ulang script ini." -ForegroundColor Yellow
  exit 1
}

Langkah "Tools dasar: git, gh, node, uv, jq" @('git: version history kode, bisa balik kalau agent merusak sesuatu', 'gh: agent bisa bikin repo, branch, PR, dan login GitHub dari terminal', 'node: mesin JavaScript, dibutuhkan web app, MCP, dan banyak CLI (npm, npx ikut terpasang)', 'uv: Python dan library-nya, untuk script otomatis, AI, dan video', 'jq: baca JSON di terminal, dipakai hook dan script')
Winget "Git.Git" "git"
Winget "GitHub.cli" "gh"
Winget "OpenJS.NodeJS.LTS" "node"
Winget "astral-sh.uv" "uv"
Winget "jqlang.jq" "jq"

Langkah "Pengaman: gitleaks" @('gitleaks: menolak commit yang berisi API key atau token (dipasang per project lewat scripts/pasang-pengaman.sh --repo dari Git Bash)')
Winget "Gitleaks.Gitleaks" "gitleaks"

Langkah "Aplikasi: VS Code, Claude Desktop, Google Chrome" @('VS Code: editor untuk lihat file, diff, dan ngobrol dengan agent', 'Claude Desktop: Claude dengan tab Code, sesi paralel, browser bawaan', 'Chrome: browser yang dikendalikan agent untuk mengetes aplikasi')
Winget "Microsoft.VisualStudioCode" "code"
Winget "Anthropic.Claude" $null
Winget "Google.Chrome" $null

Langkah "Claude Code (native installer, update otomatis)" @('Claude Code: agent coding utama, login pakai langganan Claude')
if (Ada claude) { Write-Host "sudah ada" } else { irm https://claude.ai/install.ps1 | iex }
Segarkan-Path

Langkah "Codex (OpenAI) dan opencode" @('Codex: agent coding OpenAI, login pakai akun ChatGPT, bagus untuk review silang', 'opencode: agent coding dengan model gratis atau token murah')
Winget "OpenAI.Codex" "codex"
if (-not (Ada opencode)) { npm install -g opencode-ai }
Segarkan-Path

Langkah "Ekstensi VS Code" @('Claude Code, Codex, opencode di editor + ESLint, Prettier, Tailwind, Python, Playwright, GitLens untuk bantu baca dan rapikan kode')
if (Ada code) {
  foreach ($ext in @("anthropic.claude-code","openai.chatgpt","sst-dev.opencode","dbaeumer.vscode-eslint","esbenp.prettier-vscode","bradlc.vscode-tailwindcss","ms-python.python","ms-playwright.playwright","eamodio.gitlens")) {
    code --install-extension $ext --force *> $null
    if ($LASTEXITCODE -eq 0) { Write-Host "$ext ok" } else { Write-Host "$ext gagal (install manual dari VS Code)" }
  }
} else { Write-Host "code belum terbaca. Buka PowerShell baru lalu jalankan ulang script ini." }

Langkah "MCP dasar: Playwright, Chrome DevTools" @('MCP Playwright + Chrome DevTools: mata agent, buka aplikasi, klik, screenshot, baca error')
if (Ada claude) {
  Mcp-Add "playwright" @("--", "npx", "@playwright/mcp@latest")
  Mcp-Add "chrome-devtools" @("--", "npx", "chrome-devtools-mcp@latest")
  Write-Host "Context7 butuh login di browser: jalankan manual 'npx ctx7 setup --claude' (modul 07)."
} else { Write-Host "claude belum terbaca. Buka PowerShell baru lalu jalankan ulang script ini." }

if ($Web) {
  Langkah "Jalur web: Vercel, Wrangler, Docker Desktop, browser Playwright (Supabase CLI lewat npx supabase)" @('Vercel CLI: deploy dan cek project Vercel', 'Wrangler: CLI Cloudflare (Workers, Pages, DNS)', 'Docker Desktop: jalankan database, n8n, dan layanan lain dalam container', 'cloudflared: kasih link publik sementara ke localhost (demo ke klien, terima webhook)', 'browser Playwright: browser khusus untuk test otomatis')
  if (-not (Ada vercel)) { npm install -g vercel }
  if (-not (Ada wrangler)) { npm install -g wrangler }
  Winget "Cloudflare.cloudflared" "cloudflared"
  Winget "Docker.DockerDesktop" "docker"
  npx -y playwright install chromium
  if (Ada claude) { Mcp-Add "vercel" @("--transport", "http", "https://mcp.vercel.com") }
}

if ($Video) {
  Langkah "Jalur video: ffmpeg, yt-dlp, deno, ImageMagick" @('ffmpeg: potong, gabung, convert, render video dan audio', 'yt-dlp + deno: download video referensi', 'ImageMagick: olah gambar massal')
  Winget "Gyan.FFmpeg" "ffmpeg"
  Winget "yt-dlp.yt-dlp" "yt-dlp"
  Winget "DenoLand.Deno" "deno"
  Winget "ImageMagick.ImageMagick" "magick"
  Write-Host "Transkrip audio di Windows: pakai API (Whisper/Gemini) dulu, lihat modul 12."
}

if ($Agent) {
  Langkah "Jalur agent: Hermes Agent, 9router, Ollama, Gemini CLI" @('Hermes: asisten 24 jam yang bisa di-chat dari Telegram', '9router: satu endpoint untuk banyak model AI dengan fallback', 'Ollama: jalankan model AI di laptop, offline', 'Gemini CLI: agent coding cadangan dari Google')
  if (-not (Ada hermes)) { iex (irm https://hermes-agent.nousresearch.com/install.ps1) }
  if (-not (Ada 9router)) { npm install -g 9router }
  if (-not (Ada gemini)) { npm install -g @google/gemini-cli }
  Winget "Ollama.Ollama" "ollama"
}

if ($Desain) {
  Langkah "Jalur desain: Figma Desktop, MCP Jiro" @('Figma: desain sebelum dikodekan', 'MCP Jiro: 1.400+ referensi desain untuk agent')
  Winget "Figma.Figma" $null
  if (Ada claude) { Mcp-Add "jiro" @("--transport", "http", "https://mcp.jiro.build") }
}

if ($Craft) {
  Langkah "Jalur laptop kuat: ArtCraft suite"
  Write-Host "Membuka halaman download ArtCraft Launcher. Install Launcher, lalu pilih FigCraft, EffectCraft, FilmCraft, PhotoCraft dari dalamnya."
  Start-Process "https://getartcraft.com/"
}

Langkah "Selesai. Tutup dan buka PowerShell baru, lalu cek:"
Write-Host "  powershell -ExecutionPolicy Bypass -File scripts\cek-setup.ps1"
Write-Host "Langkah berikutnya yang butuh login di browser: gh auth login, claude (login), codex login, npx ctx7 setup --claude, /mcp untuk MCP OAuth."
