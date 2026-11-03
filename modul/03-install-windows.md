# 03 Install dasar di Windows

**Tujuan:** semua tools dasar terpasang dan terverifikasi.

**Waktu:** 20-40 menit. Syarat: Windows 10 versi 1809 ke atas atau Windows 11, RAM minimal 4 GB, ruang kosong 10 GB.

Claude Code sekarang jalan langsung di Windows, **tidak perlu WSL**. Git for Windows tetap disarankan karena Claude Code memakai Git Bash untuk menjalankan perintah. WSL baru perlu kalau nanti butuh toolchain Linux.

## Buka PowerShell

Tekan tombol Windows, ketik `PowerShell`, buka **Windows PowerShell** (bukan "Run as Administrator", kecuali diminta). Semua perintah di modul ini diketik di sana.

## Cara cepat (satu perintah)

Agent jalankan dari folder onboarding:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\install-windows.ps1
```

Tambahkan `-Web`, `-Video`, `-Agent`, `-Desain`, atau `-Semua` sesuai jalur minat. Yang sudah terpasang dilewati.

Yang dipasang script dasar: git, gh, Node, uv, jq, Codex, opencode, VS Code + 9 ekstensi (Claude Code, Codex, opencode, ESLint, Prettier, Tailwind, Python, Playwright, GitLens), Claude Code, Claude Desktop, Google Chrome, dan MCP **Playwright** + **Chrome DevTools** supaya agent bisa membuka browser dan mengecek hasil kerjanya sendiri. Isi tiap flag dan fungsi tiap tool ada di [referensi/katalog-tools.md](../referensi/katalog-tools.md).

## Cara manual (satu per satu)

Semua lewat `winget` (bawaan Windows 11, di Windows 10 install **App Installer** dari Microsoft Store).

| # | Tool | Install | Verifikasi |
|---|---|---|---|
| 1 | Git for Windows | `winget install --id Git.Git -e --source winget` | `git --version` |
| 2 | GitHub CLI | `winget install --id GitHub.cli` | `gh --version` |
| 3 | Node.js LTS | `winget install OpenJS.NodeJS.LTS` | `node --version` |
| 4 | uv (Python) | `winget install --id=astral-sh.uv -e` | `uv --version` |
| 5 | VS Code | `winget install Microsoft.VisualStudioCode` | `code --version` |
| 6 | Claude Code | `irm https://claude.ai/install.ps1 \| iex` | `claude --version`, `claude doctor` |
| 7 | Codex CLI | `winget install OpenAI.Codex` | `codex --version` |
| 8 | opencode | `npm install -g opencode-ai` | `opencode --version` |
| 9 | Claude Desktop | `winget install Anthropic.Claude` | buka dari Start menu |

Setelah tiap install, **tutup PowerShell dan buka lagi** supaya perintah baru dikenali.

Kalau pakai Command Prompt (CMD), bukan PowerShell, perintah Claude Code-nya:
```
curl -fsSL https://claude.ai/install.cmd -o install.cmd && install.cmd && del install.cmd
```

## Tools tambahan sesuai minat

| Minat | Install |
|---|---|
| Dasar (tambahan) | `winget install jqlang.jq`, `winget install Google.Chrome` |
| Web/SaaS | `npm install -g vercel wrangler`, `winget install Docker.DockerDesktop` (installer akan mengaktifkan WSL 2, butuh restart), `npx playwright install chromium`. Supabase CLI cukup lewat `npx supabase ...` |
| Video | `winget install Gyan.FFmpeg`, `winget install yt-dlp.yt-dlp`, `winget install DenoLand.Deno`, `winget install ImageMagick.ImageMagick`. Transkrip pakai API dulu |
| Agent | `npm install -g 9router @google/gemini-cli`, `winget install Ollama.Ollama`, opencode dan Hermes di modul 10 |
| Desain | `winget install Figma.Figma` |

## Verifikasi

```powershell
powershell -ExecutionPolicy Bypass -File scripts\cek-setup.ps1
```
Semua baris di "Tools dasar" berstatus `[OK]`.

## Kalau gagal

- `winget` tidak dikenali: install/update **App Installer** dari Microsoft Store.
- `running scripts is disabled on this system`: pakai awalan `powershell -ExecutionPolicy Bypass -File ...` seperti di atas, jangan ubah policy sistem secara permanen.
- Claude Code bilang Git Bash tidak ditemukan: pastikan Git for Windows terpasang, lalu buka PowerShell baru.
- SmartScreen memblokir installer: klik **More info** lalu **Run anyway**. Orangnya yang klik.
- Antivirus kantor memblokir: minta IT mengizinkan, jangan matikan antivirus.

## Lanjut

Modul [04 VS Code + Claude Code, Codex, opencode](04-claude-code.md).
