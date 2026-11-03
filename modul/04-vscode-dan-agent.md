# 04 VS Code + tiga agent: Claude Code, Codex, opencode

**Tujuan:** VS Code terpasang dengan ekstensi Claude Code, Codex, dan opencode. Claude Code sudah login pakai langganan Claude, Codex login pakai akun ChatGPT (kalau punya), dan opencode siap dengan model gratis. Kamu tahu kapan pakai yang mana dan 10 perintah yang paling sering dipakai.

**Waktu:** 25 menit.

## Kenapa tiga agent

| Agent | Bayar pakai | Kuat di | Kapan dipakai |
|---|---|---|---|
| **Claude Code** | langganan Claude Pro/Max | coding harian, plugin, skill, MCP paling lengkap | default untuk semua kerjaan |
| **Codex** (OpenAI) | langganan ChatGPT (Plus USD 20 ke atas; paket Free terbatas) | second opinion, review kode, tugas panjang di background | saat kuota Claude habis, atau minta review dari "otak" lain |
| **opencode** | model gratis, atau token murah lewat 9router / TokenomixAI | jalur Gratis, tugas ringan dan berulang | jalur Gratis, atau tugas yang tidak perlu model mahal |

Ketiganya membaca `AGENTS.md`, jadi aturan project kamu berlaku di mana pun. Itu sebabnya `AGENTS.md` jadi file utama (modul 06).

## Langkah 1: VS Code dan ekstensi (agent yang install)

Kalau script install di modul 02/03 sudah jalan, VS Code dan ekstensinya sudah terpasang. Agent cek dulu:

```bash
code --list-extensions | grep -iE 'anthropic.claude-code|openai.chatgpt|sst-dev.opencode'
```

Kalau ada yang belum, agent install:

```bash
code --install-extension anthropic.claude-code
code --install-extension openai.chatgpt
code --install-extension sst-dev.opencode
```

| Ekstensi | ID | Publisher |
|---|---|---|
| Claude Code | `anthropic.claude-code` | Anthropic |
| Codex | `openai.chatgpt` | OpenAI (verified) |
| opencode | `sst-dev.opencode` | SST |

macOS: kalau `code` belum dikenali, agent buka VS Code (`open -a "Visual Studio Code"`), lalu minta orangnya tekan `Cmd+Shift+P`, ketik `Shell Command: Install 'code' command in PATH`, Enter.

## Langkah 2: CLI Codex dan opencode

Agent cek dan install yang belum ada (Claude Code sudah dari modul 02/03):

| | macOS | Windows |
|---|---|---|
| Codex | `brew install --cask codex` | `winget install OpenAI.Codex` |
| opencode | `curl -fsSL https://opencode.ai/install \| bash` | `npm install -g opencode-ai` |

Alternatif semua OS: `npm install -g @openai/codex opencode-ai`.

## Langkah 3: login Claude pakai langganan

1. Agent buka VS Code di folder onboarding: `code .`
2. Orangnya klik ikon **Claude** (pojok kanan atas editor atau sidebar).
3. Klik **Sign in**, pilih **Claude.ai account (Pro/Max)**. Jangan pilih Anthropic Console, kecuali memang mau bayar per token lewat API.
4. Browser terbuka ke claude.ai, klik **Authorize**, kembali ke VS Code.
5. Tes di panel Claude: ketik `halo, kamu baca AGENTS.md di folder ini?`. Agent harus menyebut isi instruksi onboarding.

Di terminal: jalankan `claude`. Kalau belum login, ketik `/login` dan pilih akun Claude. Cek status dengan `/status`, harus tertulis login lewat Claude subscription (Pro/Max), bukan API key.

## Langkah 4: login Codex pakai akun ChatGPT (kalau punya)

Agent jalankan:

```bash
codex login
```

Browser terbuka. Orangnya pilih **Sign in with ChatGPT**, login, klik izinkan. Di VS Code, ekstensi Codex (ikon OpenAI di sidebar) akan memakai login yang sama, atau klik **Sign in with ChatGPT** di panelnya.

Tes: di panel Codex ketik `ringkas AGENTS.md dalam 3 poin`.

Belum punya ChatGPT berbayar: lewati dulu, catat di `PROGRESS.md`. Paket Free punya akses Codex yang terbatas.

## Langkah 5: opencode dengan model gratis

Agent jalankan `opencode` di folder onboarding, lalu ketik `/models` dan pilih model yang namanya berakhiran `-free` (contoh: DeepSeek Flash Free, MiMo Flash Free). Untuk menyambung provider lain (TokenomixAI, OpenRouter, 9router):

```bash
opencode auth login
```

Di VS Code, ekstensi opencode menjalankan opencode di panel samping editor.

Tes: `ringkas AGENTS.md dalam 3 poin`.

## Langkah 6: CLAUDE.md global

Agent pasang aturan kerja global (Karpathy + aturan mentor):

```bash
mkdir -p ~/.claude
cp templates/CLAUDE.global.md ~/.claude/CLAUDE.md
```

Kalau `~/.claude/CLAUDE.md` sudah ada, tampilkan isinya dulu dan gabungkan, jangan timpa. Untuk Codex, salin isi yang sama ke `~/.codex/AGENTS.md` supaya Codex ikut aturan yang sama:

```bash
mkdir -p ~/.codex && cp templates/CLAUDE.global.md ~/.codex/AGENTS.md
```

## Langkah 7: Claude Desktop (opsional tapi disarankan)

Sudah terpasang oleh script. Buka, login dengan akun Claude yang sama, lalu buka tab **Code** dan pilih folder project. Enak untuk menjalankan beberapa sesi paralel dan melihat preview di browser bawaan.

## Perintah dan tombol yang paling sering dipakai (Claude Code)

| Perintah | Fungsi |
|---|---|
| `Shift+Tab` | Ganti mode: normal → auto-accept edit → plan mode. Pakai **plan mode** untuk minta rencana dulu sebelum coding. |
| `/init` | Bikin `CLAUDE.md` project otomatis dari isi folder. |
| `/model` | Ganti model (Haiku, Sonnet, Opus). |
| `/clear` | Mulai percakapan baru di folder yang sama. Pakai saat ganti topik supaya konteks bersih. |
| `/compact` | Ringkas percakapan panjang supaya hemat konteks. |
| `/plugin` | Cari, install, dan kelola plugin. |
| `/mcp` | Lihat dan login ke server MCP. |
| `/agents` | Kelola subagent. |
| `/status` | Cek akun yang dipakai login dan pengaturan aktif. |
| `/usage` | Cek pemakaian kuota. |
| `Esc` | Hentikan agent yang sedang jalan. `Esc Esc` untuk mundur ke pesan sebelumnya. |
| `@nama-file` | Sebut file tertentu supaya dibaca agent. |
| `!perintah` | Jalankan perintah shell langsung tanpa lewat agent. |

Codex dan opencode punya perintah mirip: `/model` untuk ganti model, `/init` untuk bikin `AGENTS.md`.

## Kebiasaan yang bikin hasil bagus

- **Mulai dari plan mode** untuk apa pun yang lebih dari satu file.
- **Satu sesi, satu topik.** Ganti topik, `/clear`.
- **Kasih cara mengecek.** "Bikin form login, lalu jalankan dev server dan cek pakai Playwright." Agent yang bisa mengecek kerjaannya sendiri hasilnya jauh lebih baik.
- **Kasih contoh visual.** Screenshot bisa di-drag langsung ke chat.
- **Commit sebelum perubahan besar** supaya bisa balik.
- **Minta review silang.** Setelah Claude selesai satu fitur, minta Codex: "review perubahan di branch ini, cari bug". Dua model berbeda menangkap kesalahan yang berbeda.

## Verifikasi

```bash
claude --version
codex --version
opencode --version
code --list-extensions | grep -iE 'anthropic.claude-code|openai.chatgpt|sst-dev.opencode'
head -5 ~/.claude/CLAUDE.md
```

- [ ] Panel Claude di VS Code menjawab dan `/status` menunjukkan login langganan Claude.
- [ ] (Kalau punya ChatGPT) Panel Codex menjawab.
- [ ] opencode menjawab dengan model `-free`.

## Kalau gagal

- Claude minta API key: berarti terpilih login Console. Ketik `/logout`, lalu `/login`, pilih akun Claude.ai.
- Ekstensi tidak muncul: update VS Code ke versi terbaru, restart.
- `codex login` tidak membuka browser: salin URL yang dicetak di terminal ke browser.
- Kuota Claude cepat habis di Pro: pakai Sonnet sebagai default, `/clear` lebih sering, pindahkan tugas ringan ke opencode atau Codex, atau naik ke Max.

## Lanjut

Modul [05 GitHub](05-github.md).
