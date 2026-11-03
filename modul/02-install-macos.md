# 02 Install dasar di macOS

**Tujuan:** semua tools dasar terpasang dan terverifikasi.

**Waktu:** 20-40 menit (tergantung internet). Syarat: macOS 13 atau lebih baru, RAM minimal 4 GB, ruang kosong 10 GB.

## Cara cepat (satu perintah)

Agent jalankan dari folder onboarding:

```bash
bash scripts/install-macos.sh
```

Tambahkan flag sesuai jalur minat dari `PROGRESS.md`: `--web`, `--video`, `--agent`, atau `--semua`. Script melewati yang sudah terpasang, jadi aman diulang.

Kalau mau paham tiap langkah, atau script gagal di tengah, ikuti cara manual di bawah.

## Cara manual (satu per satu)

| # | Tool | Untuk apa | Install | Verifikasi |
|---|---|---|---|---|
| 1 | Xcode Command Line Tools | compiler dasar, git bawaan | `xcode-select --install` (klik Install di popup) | `xcode-select -p` |
| 2 | Homebrew | "App Store" untuk tools terminal | `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"` | `brew --version` |
| 3 | Git | lacak perubahan kode | `brew install git` | `git --version` |
| 4 | GitHub CLI | GitHub dari terminal | `brew install gh` | `gh --version` |
| 5 | Node.js | menjalankan JavaScript, npm, npx | `brew install node` | `node --version` (minimal v22) |
| 6 | uv | Python dan paket Python | `brew install uv` | `uv --version` |
| 7 | VS Code | editor kode | `brew install --cask visual-studio-code` | buka dari Launchpad |
| 8 | Claude Code | agent coding | `curl -fsSL https://claude.ai/install.sh \| bash` | `claude --version`, `claude doctor` |
| 9 | Claude Desktop | aplikasi Claude dengan tab Code | `brew install --cask claude` | buka dari Launchpad |

Catatan langkah 2: Homebrew minta password Mac. Orangnya yang mengetik password langsung di terminal (tidak terlihat saat diketik, itu normal). Setelah selesai, jalankan dua baris "Next steps" yang dicetak Homebrew supaya `brew` dikenali, biasanya:

```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

Catatan langkah 6: Python bawaan macOS jangan diutak-atik. Pakai `uv` untuk project Python: `uv init`, `uv add nama-paket`, `uv run script.py`.

## Tools tambahan sesuai minat

| Minat | Install |
|---|---|
| Web/SaaS | `npm install -g vercel` dan `brew install supabase/tap/supabase` |
| Video | `brew install ffmpeg yt-dlp deno` (deno dibutuhkan yt-dlp untuk YouTube) |
| Agent | lihat modul 10 |
| Runtime cepat (opsional) | `curl -fsSL https://bun.com/install \| bash` |

## Verifikasi

```bash
bash scripts/cek-setup.sh
```
Semua baris di "Tools dasar" berstatus `[OK]`.

## Kalau gagal

- `command not found` setelah install: tutup terminal, buka baru. Kalau masih, jalankan `eval "$(/opt/homebrew/bin/brew shellenv)"`.
- Popup "can't be opened because it is from an unidentified developer": buka System Settings, Privacy & Security, klik **Open Anyway**. Orangnya yang klik.
- Homebrew lambat atau gagal download: cek koneksi, ulangi perintah yang gagal saja.
- Mac Intel (bukan Apple Silicon): path Homebrew `/usr/local/bin/brew`, bukan `/opt/homebrew`.

## Lanjut

Modul [04 Claude Code dan VS Code](04-claude-code.md).
