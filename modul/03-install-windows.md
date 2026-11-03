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

Tambahkan `-Web`, `-Video`, `-Agent`, atau `-Semua` sesuai jalur minat. Yang sudah terpasang dilewati.

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
| 7 | Claude Desktop | `winget install Anthropic.Claude` | buka dari Start menu |

Setelah tiap install, **tutup PowerShell dan buka lagi** supaya perintah baru dikenali.

Kalau pakai Command Prompt (CMD), bukan PowerShell, perintah Claude Code-nya:
```
curl -fsSL https://claude.ai/install.cmd -o install.cmd && install.cmd && del install.cmd
```

## Tools tambahan sesuai minat

| Minat | Install |
|---|---|
| Web/SaaS | `npm install -g vercel`. Supabase CLI cukup lewat `npx supabase ...` |
| Video | `winget install Gyan.FFmpeg`, `winget install yt-dlp.yt-dlp`, `winget install DenoLand.Deno` |
| Agent | lihat modul 10 |

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

Modul [04 Claude Code dan VS Code](04-claude-code.md).
