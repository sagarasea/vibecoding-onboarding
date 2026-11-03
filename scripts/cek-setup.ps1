# Cek tools vibe coding di Windows. Tidak menginstall apa pun.
# Pakai (PowerShell): powershell -ExecutionPolicy Bypass -File scripts\cek-setup.ps1

$ok = 0; $miss = 0
function Cek($nama, $cmd, $verArgs) {
  $c = Get-Command $cmd -ErrorAction SilentlyContinue
  if ($c) {
    $v = (& $cmd $verArgs 2>$null | Select-Object -First 1)
    Write-Host ("  [OK]    {0,-12} {1}" -f $nama, $v)
    $script:ok++
  } else {
    Write-Host ("  [BELUM] {0,-12}" -f $nama)
    $script:miss++
  }
}

Write-Host "Tools dasar"
Cek "winget"      winget  "--version"
Cek "Git"         git     "--version"
Cek "GitHub CLI"  gh      "--version"
Cek "Node.js"     node    "--version"
Cek "npm"         npm     "--version"
Cek "Python"      python  "--version"
Cek "uv"          uv      "--version"
Cek "jq"          jq      "--version"
Cek "VS Code"     code    "--version"
Cek "Claude Code" claude  "--version"

Write-Host ""
Write-Host "Tools opsional (sesuai jalur minat)"
Cek "Bun"         bun      "--version"
Cek "ffmpeg"      ffmpeg   "-version"
Cek "yt-dlp"      yt-dlp   "--version"
Cek "Vercel CLI"  vercel   "--version"
Cek "Supabase"    supabase "--version"
Cek "Wrangler"    wrangler "--version"
Cek "Docker"      docker   "--version"
Cek "ImageMagick" magick   "-version"
Cek "Ollama"      ollama   "--version"
Cek "Gemini CLI"  gemini   "--version"
Cek "Hermes"      hermes   "--version"
Cek "opencode"    opencode "--version"

Write-Host ""
Write-Host "MCP (Claude Code)"
if (Get-Command claude -ErrorAction SilentlyContinue) {
  foreach ($m in @("playwright","chrome-devtools","context7")) {
    claude mcp get $m *> $null
    if ($LASTEXITCODE -eq 0) { Write-Host "  [OK]    MCP $m" } else { Write-Host "  [BELUM] MCP $m (modul 07)" }
  }
}

Write-Host ""
Write-Host "Akun dan identitas"
if (Get-Command gh -ErrorAction SilentlyContinue) {
  gh auth status *> $null
  if ($LASTEXITCODE -eq 0) { Write-Host "  [OK]    GitHub login: $(gh api user --jq .login)" }
  else { Write-Host "  [BELUM] GitHub login (jalankan: gh auth login)" }
}
$n = git config --global user.name 2>$null; $e = git config --global user.email 2>$null
if ($n -and $e) { Write-Host "  [OK]    git identity: $n <$e>" } else { Write-Host "  [BELUM] git identity (git config --global user.name / user.email)" }
if (Test-Path "$HOME\.claude\CLAUDE.md") { Write-Host "  [OK]    ~/.claude/CLAUDE.md ada" } else { Write-Host "  [BELUM] ~/.claude/CLAUDE.md (lihat modul 06)" }

Write-Host ""
Write-Host "Ringkasan: $ok terpasang, $miss belum."
