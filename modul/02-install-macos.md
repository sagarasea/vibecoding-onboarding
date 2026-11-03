# 02 Install dasar di macOS

**Tujuan:** semua tools dasar terpasang dan terverifikasi.

**Waktu:** 20-40 menit (tergantung internet). Syarat: macOS 13 atau lebih baru, RAM minimal 4 GB, ruang kosong 10 GB.

## Materi dulu

Sebelum menjalankan install, agent jelaskan [materi 00: Terminal dan kenapa butuh tools dasar](../materi/00-terminal-dan-tools-dasar.md). Saat script jalan, setiap langkah mencetak "untuk apa" tiap tool. Agent bacakan dalam satu kalimat per langkah.

## Cara cepat (satu perintah)

Agent jalankan dari folder onboarding:

```bash
bash scripts/install-macos.sh
```

Tambahkan flag sesuai jalur minat dari `PROGRESS.md`: `--web`, `--video`, `--agent`, `--desain`, atau `--semua`. Script melewati yang sudah terpasang, jadi aman diulang.

Yang dipasang script dasar: Homebrew, git, gh, Node, uv, jq, Codex, opencode, VS Code + 9 ekstensi (Claude Code, Codex, opencode, ESLint, Prettier, Tailwind, Python, Playwright, GitLens), Claude Code, Claude Desktop, Google Chrome, dan MCP **Playwright** + **Chrome DevTools** supaya agent bisa membuka browser dan mengecek hasil kerjanya sendiri. Isi tiap flag dan fungsi tiap tool ada di [referensi/katalog-tools.md](../referensi/katalog-tools.md).

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
| 6a | jq | baca JSON di terminal, dipakai hook dan script | `brew install jq` | `jq --version` |
| 6b | gitleaks | menolak commit yang berisi API key | `brew install gitleaks` | `gitleaks version` |
| 7 | VS Code | editor kode | `brew install --cask visual-studio-code` | buka dari Launchpad |
| 8 | Claude Code | agent coding | `curl -fsSL https://claude.ai/install.sh \| bash` | `claude --version`, `claude doctor` |
| 9 | Codex CLI | agent coding OpenAI | `brew install --cask codex` | `codex --version` |
| 10 | opencode | agent coding model gratis | `curl -fsSL https://opencode.ai/install \| bash` | `opencode --version` |
| 11 | Claude Desktop | aplikasi Claude dengan tab Code | `brew install --cask claude` | buka dari Launchpad |
| 12 | Google Chrome | browser yang dikendalikan agent untuk tes | `brew install --cask google-chrome` | buka dari Launchpad |

Catatan langkah 2: Homebrew minta password Mac. Orangnya yang mengetik password langsung di terminal (tidak terlihat saat diketik, itu normal). Setelah selesai, jalankan dua baris "Next steps" yang dicetak Homebrew supaya `brew` dikenali, biasanya:

```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

Catatan langkah 6: Python bawaan macOS jangan diutak-atik. Pakai `uv` untuk project Python: `uv init`, `uv add nama-paket`, `uv run script.py`.

## Tools tambahan sesuai minat

| Minat | Install |
|---|---|
| Web/SaaS | `npm install -g vercel wrangler`, `brew install supabase/tap/supabase cloudflared`, `brew install --cask docker-desktop`, `npx playwright install chromium` |
| Video | `brew install ffmpeg yt-dlp deno imagemagick whisper-cpp` (deno dibutuhkan yt-dlp untuk YouTube, whisper-cpp untuk transkrip lokal) |
| Agent | `npm install -g 9router @google/gemini-cli`, `brew install --cask ollama-app`, opencode dan Hermes di modul 10 |
| Desain | `brew install --cask figma` |
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

Modul [04 VS Code + Claude Code, Codex, opencode](04-claude-code.md).
