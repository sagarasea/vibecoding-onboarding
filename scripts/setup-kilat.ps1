# Jalur kilat Windows: install tools dan konfigurasi agent dalam satu perintah.
# Aman dijalankan ulang: yang sudah ada dilewati, file yang sudah ada tidak ditimpa.
# Pakai (agent yang menjalankan, flag sesuai minat di PROGRESS.md):
#   $env:GIT_NAME="Nama Kamu"; $env:GIT_EMAIL="email@kamu.com"
#   powershell -ExecutionPolicy Bypass -File scripts\setup-kilat.ps1 -Web -Video
# Flag sama dengan install-windows.ps1: -Web -Video -Agent -Desain -Craft -Semua
param([switch]$Web, [switch]$Video, [switch]$Agent, [switch]$Desain, [switch]$Craft, [switch]$Semua)
$ErrorActionPreference = "Continue"
Set-Location (Join-Path $PSScriptRoot "..")
if ($Semua) { $Video = $true }

function Ada($cmd) { [bool](Get-Command $cmd -ErrorAction SilentlyContinue) }
function Langkah($n, $t, [string[]]$untuk = @()) { Write-Host "`n==> [kilat $n] $t" -ForegroundColor Cyan; foreach ($u in $untuk) { Write-Host "    - $u" } }
function Segarkan-Path { $env:Path = [Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [Environment]::GetEnvironmentVariable("Path", "User") }

Langkah "1/7" "Install tools (scripts\install-windows.ps1)"
$teruskan = @{}
foreach ($k in "Web","Video","Agent","Desain","Craft","Semua") { if ((Get-Variable $k).Value) { $teruskan[$k] = $true } }
& (Join-Path $PSScriptRoot "install-windows.ps1") @teruskan
Segarkan-Path

Langkah "2/7" "Identitas git" @('nama dan email yang tercatat di setiap commit')
if ((git config --global user.name) -and (git config --global user.email)) {
  Write-Host "sudah ada: $(git config --global user.name) <$(git config --global user.email)>"
} elseif ($env:GIT_NAME -and $env:GIT_EMAIL) {
  git config --global user.name "$env:GIT_NAME"
  git config --global user.email "$env:GIT_EMAIL"
  git config --global init.defaultBranch main
  Write-Host "dipasang: $env:GIT_NAME <$env:GIT_EMAIL>"
} else {
  Write-Host "BELUM: isi `$env:GIT_NAME dan `$env:GIT_EMAIL lalu jalankan ulang, atau isi manual (modul 05)."
}

Langkah "3/7" "Aturan kerja global agent" @('~\.claude\CLAUDE.md untuk Claude Code, ~\.codex\AGENTS.md untuk Codex (Karpathy + aturan mentor)', 'skill belajar-lanjut: cek level dan fokus belajar berikutnya')
function Pasang-Aturan($tujuan) {
  $sumber = "templates\CLAUDE.global.md"
  New-Item -ItemType Directory -Force -Path (Split-Path $tujuan) | Out-Null
  if (-not (Test-Path $tujuan)) {
    Copy-Item $sumber $tujuan; Write-Host "dipasang: $tujuan"
  } elseif ((Get-FileHash $sumber).Hash -eq (Get-FileHash $tujuan).Hash) {
    Write-Host "sudah sama: $tujuan"
  } else {
    Copy-Item $sumber "$tujuan.onboarding"
    Write-Host "PERLU DIGABUNG: $tujuan sudah ada dan isinya beda. Template disimpan di $tujuan.onboarding, agent gabungkan bareng kamu."
  }
}
Pasang-Aturan (Join-Path $HOME ".claude\CLAUDE.md")
Pasang-Aturan (Join-Path $HOME ".codex\AGENTS.md")
$gitBash = "C:\Program Files\Git\bin\bash.exe"
if (Test-Path $gitBash) { & $gitBash scripts/pasang-skill.sh }   # skill belajar-lanjut: "harus belajar apa lagi?" dari folder mana pun

Langkah "4/7" "Pengaman" @('hook db-safety: perintah database yang menghapus data diblokir sebelum jalan (lewat Git Bash)')
if (Test-Path $gitBash) { & $gitBash scripts/pasang-pengaman.sh } else { Write-Host "Git Bash belum ada. Buka PowerShell baru lalu jalankan ulang script ini." }

Langkah "5/7" "Plugin dasar Claude Code" @('antislop: filter hasil generik', 'frontend-design: UI yang tidak template', '(video) hyperframes dan watch')
if (Ada claude) {
  $terpasang = (claude plugin list 2>$null) -join "`n"
  function Plugin($id, $market) {
    if ($terpasang -match [regex]::Escape($id)) { Write-Host "$id sudah ada"; return }
    if ($market) { claude plugin marketplace add $market *> $null }
    claude plugin install $id
    if ($LASTEXITCODE -ne 0) { Write-Host "$id gagal, pasang manual lewat /plugin (modul 07)" }
  }
  Plugin "antislop@anti-slop" "miqdadbadjuber/anti-slop"
  Plugin "frontend-design@claude-plugins-official" "anthropics/claude-plugins-official"   # di mesin baru marketplace resmi belum terdaftar sebelum sesi pertama
  if ($Video) {
    Plugin "hyperframes@hyperframes" "heygen-com/hyperframes"
    Plugin "watch@claude-video" "bradautomates/claude-video"
  }
} else { Write-Host "claude belum terbaca. Buka PowerShell baru lalu jalankan ulang script ini." }

Langkah "6/7" "Cek setup"
& (Join-Path $PSScriptRoot "cek-setup.ps1")

Langkah "7/7" "Tinggal login (butuh browser, satu per satu, agent yang membukakan)"
Write-Host @"
    1. claude            lalu /login, pilih akun Claude.ai (langganan Pro/Max)
    2. gh auth login --hostname github.com --git-protocol https --web
    3. codex login       (kalau punya ChatGPT Plus)
    4. opencode          lalu /models, pilih model -free
    5. npx ctx7 setup --claude          (Context7, dokumentasi library terbaru)
    6. npx antislop-ai   (antislop untuk Codex dan opencode, pilih global + mode during)
    7. -Web:   vercel login, wrangler login
    8. -Agent: hermes setup (modul 10)
Setelah semua login: scripts\cek-setup.ps1, lalu lanjut modul 13.
"@
