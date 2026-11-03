# Installer sekali jalan untuk Windows 10/11. Aman dijalankan ulang: yang sudah ada dilewati.
# Jalankan di PowerShell biasa (bukan Administrator):
#   powershell -ExecutionPolicy Bypass -File scripts\install-windows.ps1
#   tambahkan -Web, -Video, -Agent, atau -Semua untuk tools sesuai jalur.
param([switch]$Web, [switch]$Video, [switch]$Agent, [switch]$Semua)
if ($Semua) { $Web = $true; $Video = $true; $Agent = $true }

function Ada($cmd) { [bool](Get-Command $cmd -ErrorAction SilentlyContinue) }
function Langkah($t) { Write-Host "`n==> $t" -ForegroundColor Cyan }
function Winget($id, $cmd) {
  if ($cmd -and (Ada $cmd)) { Write-Host "$cmd sudah ada"; return }
  winget install --id $id -e --source winget --accept-package-agreements --accept-source-agreements
}

if (-not (Ada winget)) {
  Write-Host "winget belum ada. Buka Microsoft Store, install/update 'App Installer', lalu jalankan ulang script ini." -ForegroundColor Yellow
  exit 1
}

Langkah "Tools dasar"
Winget "Git.Git" "git"
Winget "GitHub.cli" "gh"
Winget "OpenJS.NodeJS.LTS" "node"
Winget "astral-sh.uv" "uv"
Winget "Microsoft.VisualStudioCode" "code"

Langkah "Claude Code (native installer, update otomatis)"
if (Ada claude) { Write-Host "sudah ada" } else { irm https://claude.ai/install.ps1 | iex }

Langkah "Claude Desktop"
Winget "Anthropic.Claude" $null

# Muat ulang PATH supaya npm dan tools baru terbaca di sesi ini
$env:Path = [Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [Environment]::GetEnvironmentVariable("Path", "User")

if ($Web) {
  Langkah "Jalur web: Vercel CLI (Supabase CLI dipakai lewat npx supabase)"
  if (-not (Ada vercel)) { npm install -g vercel }
}

if ($Video) {
  Langkah "Jalur video: ffmpeg, yt-dlp, deno"
  Winget "Gyan.FFmpeg" "ffmpeg"
  Winget "yt-dlp.yt-dlp" "yt-dlp"
  Winget "DenoLand.Deno" "deno"
}

if ($Agent) {
  Langkah "Jalur agent: opencode, Hermes Agent, 9router"
  if (-not (Ada opencode)) { npm install -g opencode-ai }
  if (-not (Ada hermes)) { iex (irm https://hermes-agent.nousresearch.com/install.ps1) }
  if (-not (Ada 9router)) { npm install -g 9router }
}

Langkah "Selesai. Tutup dan buka PowerShell baru, lalu cek:"
Write-Host "  powershell -ExecutionPolicy Bypass -File scripts\cek-setup.ps1"
