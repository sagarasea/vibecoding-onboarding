# 04 Claude Code dan VS Code

**Tujuan:** kamu bisa membuka project di VS Code, menjalankan Claude Code di dalamnya, dan tahu 10 perintah yang paling sering dipakai.

**Waktu:** 20 menit.

## Tiga cara memakai Claude Code

Semua pakai akun dan kuota yang sama (Claude Pro/Max).

| Cara | Kapan dipakai |
|---|---|
| **Terminal** (`claude`) | Paling lengkap. Semua fitur, plugin, dan skill tersedia di sini. |
| **Ekstensi VS Code** | Enak untuk pemula: lihat file, diff, dan chat di satu jendela. |
| **Claude Desktop, tab Code** | Tanpa terminal. Bisa buka browser bawaan, preview, dan beberapa sesi paralel. |

Saran: install ketiganya, pakai yang paling nyaman. Instruksi di modul ini berlaku untuk semuanya.

## Langkah

1. **Login Claude Code.** Di terminal:
   ```bash
   claude
   ```
   Pilih login dengan akun Claude (Pro/Max). Browser akan terbuka, orangnya klik Authorize.
2. **Install ekstensi VS Code.** Buka VS Code, tekan `Cmd+Shift+X` (Mac) atau `Ctrl+Shift+X` (Windows), cari **Claude Code** (publisher: Anthropic), klik Install. Ikon Claude muncul di pojok kanan atas editor.
3. **Aktifkan perintah `code` di terminal** (macOS): di VS Code tekan `Cmd+Shift+P`, ketik `Shell Command: Install 'code' command in PATH`, Enter. Di Windows ini sudah otomatis.
4. **Pasang CLAUDE.md global** (aturan kerja agent yang berlaku di semua project):
   ```bash
   mkdir -p ~/.claude
   cp templates/CLAUDE.global.md ~/.claude/CLAUDE.md
   ```
   Kalau `~/.claude/CLAUDE.md` sudah ada, agent harus menampilkan isinya dulu dan menggabungkan, bukan menimpa.
5. **Install Claude Desktop** (opsional tapi disarankan): https://claude.ai/download

## Perintah dan tombol yang paling sering dipakai

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
| `/usage` atau `/cost` | Cek pemakaian kuota. |
| `Esc` | Hentikan agent yang sedang jalan. `Esc Esc` untuk mundur ke pesan sebelumnya. |
| `@nama-file` | Sebut file tertentu supaya dibaca agent. |
| `!perintah` | Jalankan perintah shell langsung tanpa lewat agent. |

## Kebiasaan yang bikin hasil bagus

- **Mulai dari plan mode** untuk apa pun yang lebih dari satu file.
- **Satu sesi, satu topik.** Ganti topik, `/clear`.
- **Kasih cara mengecek.** "Bikin form login, lalu jalankan dev server dan pastikan bisa login dengan akun test." Agent yang bisa mengecek kerjaannya sendiri hasilnya jauh lebih baik.
- **Kasih contoh visual.** Screenshot bisa di-drag langsung ke chat.
- **Commit sebelum perubahan besar** supaya bisa balik.

## Verifikasi

```bash
claude --version
code --version
cat ~/.claude/CLAUDE.md | head -5
```
Lalu buka folder onboarding ini di VS Code (`code .`), klik ikon Claude, ketik "halo, kamu baca CLAUDE.md di folder ini?". Agent harus menjawab dengan menyebut isi instruksi onboarding.

## Kalau gagal

- Login gagal atau minta API key: pastikan memilih login akun Claude, bukan Anthropic Console, kecuali kamu memang pakai API berbayar.
- Ekstensi tidak muncul: update VS Code ke versi terbaru, restart.
- Kuota cepat habis di Pro: pakai Sonnet sebagai default, `/clear` lebih sering, dan pertimbangkan Max atau jalur token di modul 10.

## Lanjut

Modul [05 GitHub](05-github.md).
