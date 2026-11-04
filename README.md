# Onboarding Vibe Coding

Modul setup dari nol untuk mulai bikin produk pakai AI agent: SaaS, aplikasi internal untuk klien, AI agent, automation, dan video. Dirancang untuk dikerjakan **sekali duduk** (sekitar 4-6 jam termasuk proyek pertama), dan untuk **dipandu langsung oleh AI agent** yang membaca modul ini sambil menginstall satu per satu.

Untuk macOS dan Windows. Tidak perlu pengalaman coding.

## Cara pakai (5 menit pertama dikerjakan manual)

Hanya ini yang kamu kerjakan sendiri. Sesudahnya agent yang memandu.

**1. Install satu agent dulu.** Pilih sesuai langganan yang kamu punya. Dua agent lainnya dipasang di modul 04.

**Claude Code** (butuh langganan Claude Pro atau lebih tinggi)

macOS, buka aplikasi Terminal:
```bash
curl -fsSL https://claude.ai/install.sh | bash
```

Windows, buka PowerShell:
```powershell
irm https://claude.ai/install.ps1 | iex
```

**Codex** (butuh langganan ChatGPT Plus atau lebih tinggi)

macOS: install [Homebrew](https://brew.sh) dulu (perintahnya ada di halaman itu), lalu:
```bash
brew install --cask codex
```

Windows:
```powershell
winget install OpenAI.Codex
```

Setelah itu jalankan `codex login` dan pilih **Sign in with ChatGPT**.

**opencode** (gratis, pakai model gratis)

macOS:
```bash
curl -fsSL https://opencode.ai/install | bash
```

Windows (butuh Node.js, install dulu dengan `winget install OpenJS.NodeJS.LTS`, lalu buka PowerShell baru):
```powershell
npm install -g opencode-ai
```

Ketiga agent ini membaca `AGENTS.md`, jadi panduan di repo ini jalan di mana pun.

**2. Ambil repo ini**

- Kalau sudah diundang sebagai collaborator: buka halaman repo di GitHub, klik **Code**, **Download ZIP**, ekstrak ke folder `Projects` di home kamu.
- Kalau dikirim file ZIP oleh mentor: ekstrak ke tempat yang sama.

**3. Jalankan agent di folder ini**

```bash
cd ~/Projects/vibecoding-onboarding-main   # sesuaikan dengan nama folder hasil ekstrak
claude
```

Atau pakai Claude Desktop: tab **Code**, pilih folder ini. Untuk Codex: `codex`. Untuk opencode: `opencode`.

**4. Ketik:**

```
mulai onboarding
```

Agent akan membaca `AGENTS.md`, bertanya 4 hal tentang kamu, memilihkan jalur, lalu menawarkan dua tempo: **lengkap** (modul satu per satu, 4-6 jam) atau **kilat** (satu perintah install semua, langsung proyek pertama, sekitar 3 jam). Progres tersimpan di `PROGRESS.md`, jadi kalau terputus cukup jalankan `claude` lagi dan ketik "lanjut onboarding".

## Urutan modul

| # | Modul | Isi | Waktu |
|---|---|---|---|
| 00 | [Mulai di sini](modul/00-mulai.md) | kenalan, cek spesifikasi laptop, pilih jalur biaya dan minat | 10 menit |
| 00b | [Jalur kilat](modul/00b-jalur-kilat.md) | opsional: satu perintah install dan konfigurasi, materi sambil menunggu, langsung ke modul 13 | sekitar 3 jam total |
| 01 | [Akun](modul/01-akun.md) | GitHub, Claude, ChatGPT (Codex), Vercel, Supabase, Cloudflare, DOKU/Midtrans/GoBiz, Resend, dll | 20 menit |
| 02 | [Install macOS](modul/02-install-macos.md) | materi terminal, Homebrew, git, gh, Node, uv, VS Code, Claude Code, Codex, opencode, Playwright MCP | 30 menit |
| 03 | [Install Windows](modul/03-install-windows.md) | materi terminal, winget, Git for Windows, Node, uv, VS Code, Claude Code, Codex, opencode, Playwright MCP | 30 menit |
| 04 | [VS Code + Claude Code, Codex, opencode](modul/04-vscode-dan-agent.md) | ekstensi 3 agent, login langganan Claude, login ChatGPT untuk Codex, model gratis opencode, kapan pakai yang mana | 25 menit |
| 05 | [GitHub](modul/05-github.md) | materi git dasar, login gh, repo pertama, latihan branch dan PR | 20 menit |
| 06 | [File wajib](modul/06-file-wajib.md) | CLAUDE.md global (Karpathy), antislop, AGENTS.md, DESIGN.md, pengaman db-safety | 15 menit |
| 07 | [Skills, plugin, MCP](modul/07-skills-plugins-mcp.md) | global vs per repo, Playwright, Context7, MCP per minat, materi API key dan .env | 20 menit |
| 08 | [Referensi desain](modul/08-referensi-desain.md) | jiro, designspells, refero, supahero, mobbin, 60fps, 21st.dev | 20 menit |
| 09 | [Deploy](modul/09-deploy.md) | materi deploy, Vercel + Supabase gratis, domain Hostinger, VPS Sumopod | 20-90 menit |
| 09b | [Cloudflare](modul/09b-cloudflare.md) | DNS domain ke Cloudflare, Email Routing, R2 backup database VPS, R2 media sementara untuk Repliz | 45-60 menit |
| 10 | [API AI, router, agent 24/7](modul/10-ai-api-routing.md) | Claude vs ChatGPT (Codex) vs token, TokenomixAI, Worg, 9router, opencode, Hermes, Telegram grup dengan topik | 30-60 menit |
| 11 | [Automation](modul/11-automation.md) | Repliz, Buffer, Fonnte (WhatsApp), n8n | 20 menit |
| 12 | [Jalur minat](modul/12-jalur-minat.md) | tools per minat: SaaS (Resend, DOKU, QRIS), agent, video, desain, ArtCraft, SEO | 15-30 menit |
| 13 | [Proyek pertama](modul/13-proyek-pertama.md) | brief dari ChatGPT/Gemini, cek repo GitHub, npm run dev, motion graphic 2 jalur, sampai online | 2-4 jam |
| 14 | [Belajar lanjut](modul/14-belajar-lanjut.md) | kursus Anthropic, rencana 7 hari | |

Modul 02 atau 03, pilih salah satu sesuai OS. Modul 09-11 sebagian opsional tergantung jalur.

## Empat jalur

| Jalur | Biaya | Ringkas |
|---|---|---|
| Gratis | Rp0 | opencode + model gratis, Vercel + Supabase free |
| Hemat | sekitar Rp330rb/bulan | Claude Pro + layanan gratis + domain |
| Builder | mulai sekitar Rp500rb/bulan | + VPS Sumopod, Hermes 24 jam, 9router, TokenomixAI |
| Company | sesuai kebutuhan | + Claude Team, Worg untuk inference lokal dengan ZDR |

Rincian di [referensi/biaya.md](referensi/biaya.md).

## Isi repo

```
AGENTS.md              instruksi untuk AI agent pemandu (dibaca semua agent)
CLAUDE.md              satu baris: @AGENTS.md
PROGRESS.template.md   disalin jadi PROGRESS.md oleh agent
modul/                 langkah-langkah 00-14
materi/                konsep yang muncul sesuai fase: terminal & tools dasar, git & GitHub, API key & .env, deploy,
                       worktree & bersih-bersih, dari ide ke prompt, cari repo open source, npm run dev/build & localhost,
                       penempatan folder (laptop, GitHub, workdesk Hermes multi brand di VPS),
                       plus kamus istilah dan kuis akhir
templates/             file untuk project baru dan ~/.claude/
  CLAUDE.global.md       aturan kerja agent global (Karpathy + aturan mentor)
  AGENTS.project.md      template konteks project
  DESIGN.md              template desain berbasis referensi
  gitignore              .gitignore aman (tidak commit .env)
  claude-settings.json   izin dasar Claude Code per project
  mcp.json               contoh .mcp.json (Supabase read-only)
  hooks/                 db-safety.sh + pola, pre-commit gitleaks
scripts/
  install-macos.sh       installer sekali jalan (--web --video --agent --desain --craft --semua)
  install-windows.ps1    installer sekali jalan (-Web -Video -Agent -Desain -Craft -Semua)
  setup-kilat.sh / .ps1  jalur kilat: install + identitas git + aturan global + pengaman + plugin + cek, sekali jalan
  pasang-pengaman.sh     hook db-safety (global) dan scan rahasia gitleaks (--repo)
  figcraft-mcp.sh        MCP FigCraft yang menempel ke aplikasi FigCraft (macOS)
  cek-setup.sh / .ps1    cek apa yang sudah dan belum terpasang
referensi/
  katalog-tools.md       semua tools, ekstensi, MCP, plugin, skill: fungsi, kapan, cara install
  biaya.md               harga per jalur
  daftar-link.md         semua link
  skill-global-mentor.md skill dan plugin yang dipakai mentor
```

## Cek cepat kapan saja

```bash
bash scripts/cek-setup.sh
```

Windows:
```powershell
powershell -ExecutionPolicy Bypass -File scripts\cek-setup.ps1
```

## Catatan untuk mentor

- Repo ini private. Undang peserta sebagai collaborator (read) atau kirim ZIP dari GitHub.
- Harga dan link dicek 2026-11-04. Perbarui `referensi/biaya.md` dan modul 10 kalau ada perubahan paket.
- Kalau peserta menemukan langkah yang gagal, minta dia kirim isi `PROGRESS.md` dan pesan error lengkap.
