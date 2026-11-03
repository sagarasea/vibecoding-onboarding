# Installer sekali jalan untuk Windows 10/11. Aman dijalankan ulang: yang sudah ada dilewati.
# Daftar lengkap dan fungsi tiap tool: referensi\katalog-tools.md
# Jalankan di PowerShell biasa (bukan Administrator):
#   powershell -ExecutionPolicy Bypass -File scripts\install-windows.ps1
#   tambahkan -Web, -Video, -Agent, -Desain, -Craft (laptop kuat), atau -Semua (semua kecuali -Craft).
param([switch]$Web, [switch]$Video, [switch]$Agent, [switch]$Desain, [switch]$Craft, [switch]$Semua)
if ($Semua) { $Web = $true; $Video = $true; $Agent = $true; $Desain = $true }

function Ada($cmd) { [bool](Get-Command $cmd -ErrorAction SilentlyContinue) }
function Langkah($t) { Write-Host "`n==> $t" -ForegroundColor Cyan }
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

Langkah "Tools dasar: git, gh, node, uv, jq"
Winget "Git.Git" "git"
Winget "GitHub.cli" "gh"
Winget "OpenJS.NodeJS.LTS" "node"
Winget "astral-sh.uv" "uv"
Winget "jqlang.jq" "jq"

Langkah "Aplikasi: VS Code, Claude Desktop, Google Chrome"
Winget "Microsoft.VisualStudioCode" "code"
Winget "Anthropic.Claude" $null
Winget "Google.Chrome" $null

Langkah "Claude Code (native installer, update otomatis)"
if (Ada claude) { Write-Host "sudah ada" } else { irm https://claude.ai/install.ps1 | iex }
Segarkan-Path

Langkah "Codex (OpenAI) dan opencode"
Winget "OpenAI.Codex" "codex"
if (-not (Ada opencode)) { npm install -g opencode-ai }
Segarkan-Path

Langkah "Ekstensi VS Code"
if (Ada code) {
  foreach ($ext in @("anthropic.claude-code","openai.chatgpt","sst-dev.opencode","dbaeumer.vscode-eslint","esbenp.prettier-vscode","bradlc.vscode-tailwindcss","ms-python.python","ms-playwright.playwright","eamodio.gitlens")) {
    code --install-extension $ext --force *> $null
    if ($LASTEXITCODE -eq 0) { Write-Host "$ext ok" } else { Write-Host "$ext gagal (install manual dari VS Code)" }
  }
} else { Write-Host "code belum terbaca. Buka PowerShell baru lalu jalankan ulang script ini." }

Langkah "MCP dasar: Playwright, Chrome DevTools"
if (Ada claude) {
  Mcp-Add "playwright" @("--", "npx", "@playwright/mcp@latest")
  Mcp-Add "chrome-devtools" @("--", "npx", "chrome-devtools-mcp@latest")
  Write-Host "Context7 butuh login di browser: jalankan manual 'npx ctx7 setup --claude' (modul 07)."
} else { Write-Host "claude belum terbaca. Buka PowerShell baru lalu jalankan ulang script ini." }

if ($Web) {
  Langkah "Jalur web: Vercel, Wrangler, Docker Desktop, browser Playwright (Supabase CLI lewat npx supabase)"
  if (-not (Ada vercel)) { npm install -g vercel }
  if (-not (Ada wrangler)) { npm install -g wrangler }
  Winget "Docker.DockerDesktop" "docker"
  npx -y playwright install chromium
  if (Ada claude) { Mcp-Add "vercel" @("--transport", "http", "https://mcp.vercel.com") }
}

if ($Video) {
  Langkah "Jalur video: ffmpeg, yt-dlp, deno, ImageMagick"
  Winget "Gyan.FFmpeg" "ffmpeg"
  Winget "yt-dlp.yt-dlp" "yt-dlp"
  Winget "DenoLand.Deno" "deno"
  Winget "ImageMagick.ImageMagick" "magick"
  Write-Host "Transkrip audio di Windows: pakai API (Whisper/Gemini) dulu, lihat modul 12."
}

if ($Agent) {
  Langkah "Jalur agent: Hermes Agent, 9router, Ollama, Gemini CLI"
  if (-not (Ada hermes)) { iex (irm https://hermes-agent.nousresearch.com/install.ps1) }
  if (-not (Ada 9router)) { npm install -g 9router }
  if (-not (Ada gemini)) { npm install -g @google/gemini-cli }
  Winget "Ollama.Ollama" "ollama"
}

if ($Desain) {
  Langkah "Jalur desain: Figma Desktop, MCP Jiro"
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
