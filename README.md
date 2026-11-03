# Onboarding Vibe Coding

Modul setup dari nol untuk mulai bikin produk pakai AI agent: SaaS, aplikasi internal untuk klien, AI agent, automation, dan video. Dirancang untuk dikerjakan **sekali duduk** (sekitar 4-6 jam termasuk proyek pertama), dan untuk **dipandu langsung oleh AI agent** yang membaca modul ini sambil menginstall satu per satu.

Untuk macOS dan Windows. Tidak perlu pengalaman coding.

## Cara pakai (5 menit pertama dikerjakan manual)

Hanya ini yang kamu kerjakan sendiri. Sesudahnya agent yang memandu.

**1. Install Claude Code** (butuh langganan Claude Pro atau lebih tinggi)

macOS, buka aplikasi Terminal:
```bash
curl -fsSL https://claude.ai/install.sh | bash
```

Windows, buka PowerShell:
```powershell
irm https://claude.ai/install.ps1 | iex
```

Sudah langganan ChatGPT Plus tapi belum Claude? Pakai [Codex](https://developers.openai.com/codex): macOS `brew install --cask codex`, Windows `winget install OpenAI.Codex`, lalu `codex login`.

Belum mau bayar sama sekali? Pakai jalur Gratis: install [opencode](https://opencode.ai) (`npm install -g opencode-ai`, butuh Node.js) dan pakai model gratisnya.

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

Agent akan membaca `AGENTS.md`, bertanya 4 hal tentang kamu, memilihkan jalur, lalu memandu modul satu per satu. Progres tersimpan di `PROGRESS.md`, jadi kalau terputus cukup jalankan `claude` lagi dan ketik "lanjut onboarding".

## Urutan modul

| # | Modul | Isi | Waktu |
|---|---|---|---|
| 00 | [Mulai di sini](modul/00-mulai.md) | kenalan, pilih jalur biaya dan minat | 10 menit |
| 01 | [Akun](modul/01-akun.md) | GitHub, Claude, Vercel, Supabase, Cloudflare, dll | 15 menit |
| 02 | [Install macOS](modul/02-install-macos.md) | Homebrew, git, gh, Node, uv, VS Code, Claude Code | 30 menit |
| 03 | [Install Windows](modul/03-install-windows.md) | winget, Git for Windows, Node, uv, VS Code, Claude Code | 30 menit |
| 04 | [VS Code + Claude Code, Codex, opencode](modul/04-claude-code.md) | ekstensi, login langganan Claude dan ChatGPT, perintah penting | 25 menit |
| 05 | [GitHub](modul/05-github.md) | login gh, repo pertama, kosakata git | 15 menit |
| 06 | [File wajib](modul/06-file-wajib.md) | CLAUDE.md global (Karpathy), antislop, AGENTS.md, DESIGN.md | 15 menit |
| 07 | [Skills, plugin, MCP](modul/07-skills-plugins-mcp.md) | global vs per repo, MCP dasar | 20 menit |
| 08 | [Referensi desain](modul/08-referensi-desain.md) | jiro, designspells, refero, supahero, mobbin, 60fps, 21st.dev | 20 menit |
| 09 | [Deploy](modul/09-deploy.md) | Vercel + Supabase gratis, domain Hostinger, VPS Sumopod | 20-90 menit |
| 10 | [API AI, router, agent 24/7](modul/10-ai-api-routing.md) | langganan vs token, TokenomixAI, Worg, 9router, opencode, Hermes | 30-60 menit |
| 11 | [Automation](modul/11-automation.md) | Repliz, Buffer, n8n | 20 menit |
| 12 | [Jalur minat](modul/12-jalur-minat.md) | tools per minat: SaaS, agent, video, desain, SEO | 15-30 menit |
| 13 | [Proyek pertama](modul/13-proyek-pertama.md) | dari ide sampai online | 2-4 jam |
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
materi/                konsep yang muncul sesuai fase: git & GitHub, API key & .env, deploy, worktree & bersih-bersih,
                       dari ide ke prompt (brainstorm di ChatGPT/Gemini), cari repo open source dulu
templates/             file untuk project baru dan ~/.claude/
  CLAUDE.global.md       aturan kerja agent global (Karpathy + aturan mentor)
  AGENTS.project.md      template konteks project
  DESIGN.md              template desain berbasis referensi
  gitignore              .gitignore aman (tidak commit .env)
  claude-settings.json   izin dasar Claude Code per project
  mcp.json               contoh .mcp.json (Supabase read-only)
scripts/
  install-macos.sh       installer sekali jalan (--web --video --agent --desain --craft --semua)
  install-windows.ps1    installer sekali jalan (-Web -Video -Agent -Desain -Craft -Semua)
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
