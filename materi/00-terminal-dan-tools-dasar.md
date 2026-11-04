# Materi 00: Terminal dan kenapa butuh tools dasar

> Muncul di: **modul 02 / 03**, sebelum script install dijalankan.
> Agent: jelaskan "Gambaran besar" dan tabel "Kenapa butuh ini" dengan bahasa sederhana. Lalu, saat script berjalan dan mencetak `==> nama langkah`, sebutkan dalam satu kalimat tool itu untuk apa. Tutup dengan pertanyaan cek pemahaman.

**Setelah ini kamu bisa:**

- bilang apa yang sedang terjadi saat agent menjalankan perintah install
- menjelaskan dengan bahasamu sendiri kenapa butuh Homebrew/winget, Git, dan Node
- tahu harus ngapain kalau muncul `command not found`

## Gambaran besar

Selama ini kamu memakai komputer lewat klik: buka aplikasi, klik menu, drag file. **Terminal** adalah cara kedua: mengetik perintah. Untuk ngoding, hampir semua tools hanya punya versi terminal, dan AI agent juga bekerja lewat terminal.

Kabar baiknya: kamu tidak perlu hafal perintahnya. Agent yang mengetik. Kamu cukup tahu apa yang sedang terjadi, supaya bisa mengawasi dan tidak kaget.

Analogi desainer: aplikasi seperti Figma punya panel dan tombol. Terminal itu seperti panel "command" (`Cmd+/` di Figma), cuma isinya untuk seluruh komputer.

## Istilah yang akan sering muncul

| Istilah | Artinya |
|---|---|
| **terminal** | aplikasi tempat mengetik perintah. macOS: Terminal. Windows: PowerShell. Di VS Code ada terminal bawaan (`` Ctrl+` ``). |
| **perintah (command)** | satu baris instruksi, contoh `git --version`. Tekan Enter untuk menjalankan. |
| **folder kerja** | folder tempat perintah dijalankan. `pwd` (macOS) atau `Get-Location` (Windows) untuk melihatnya, `cd nama-folder` untuk pindah. |
| **package manager** | "App Store versi terminal": install, update, dan hapus tools dengan satu perintah. macOS: **Homebrew** (`brew`). Windows: **winget**. JavaScript: **npm**. Python: **uv**. |
| **PATH** | daftar folder tempat komputer mencari perintah. Setelah install tool baru, terminal yang sudah terbuka belum tahu PATH yang baru. Makanya sering muncul `command not found` sampai terminal ditutup dan dibuka lagi. Itu normal. |
| **`sudo` / Administrator** | menjalankan perintah dengan izin penuh. Komputer minta password. Kamu yang mengetik password, tidak terlihat saat diketik, itu normal. |
| **localhost** | alamat aplikasi yang jalan di laptopmu sendiri, contoh `http://localhost:3000`. Hanya bisa dibuka dari laptopmu (lihat materi 03). |
| **CLI** | Command Line Interface: versi terminal dari sebuah tool, contoh `gh` (GitHub CLI), `vercel`, `claude`. |

## Kenapa butuh ini

| Tool | Kenapa butuh | Tanpa ini |
|---|---|---|
| **Homebrew / winget** | satu cara seragam untuk install semua tools lain, dan update semuanya sekaligus | install manual satu per satu dari website, susah di-update |
| **Git** | version history untuk kode, bisa balik kalau AI merusak sesuatu (materi 01) | satu kesalahan agent bisa menghapus kerjaan seharian |
| **GitHub CLI (`gh`)** | agent bisa bikin repo, branch, PR, dan login ke GitHub tanpa kamu klik-klik di website | semua urusan GitHub harus manual di browser |
| **Node.js** | mesin untuk menjalankan JavaScript di luar browser. Hampir semua web app modern (Next.js, Astro), MCP, dan CLI (Vercel, antislop, Playwright) butuh ini | sebagian besar tools di onboarding ini tidak bisa jalan |
| **npm** | ikut terpasang bersama Node. Package manager JavaScript: `npm install` mengunduh library yang dibutuhkan project | project tidak bisa di-install |
| **npx** | ikut terpasang bersama Node. Menjalankan tool tanpa install permanen, contoh `npx antislop-ai`. Banyak MCP dijalankan lewat `npx` | perintah `npx ...` di modul gagal |
| **Python + uv** | bahasa untuk script otomatis, olah data, AI, dan video (clipper, transkrip). `uv` menginstall Python dan library-nya dengan rapi per project | script Python dan beberapa skill (agent-reach, watch) tidak jalan |
| **jq** | membaca dan mengolah data JSON di terminal. Dipakai di hook dan script | beberapa hook dan contoh perintah gagal |
| **VS Code** | editor tempat melihat file, perubahan (diff), dan ngobrol dengan agent dalam satu jendela | kamu tidak bisa melihat apa yang diubah agent dengan nyaman |
| **Claude Code / Codex / opencode** | agent yang menulis kode, menjalankan perintah, dan mengecek hasilnya (modul 04) | ya, itu inti vibe coding |
| **Google Chrome** | browser yang dikendalikan agent lewat Playwright dan Chrome DevTools untuk mengetes aplikasi | agent tidak bisa mengecek tampilan dan error di browser |
| **Playwright + Chrome DevTools MCP** | "mata" agent: membuka aplikasi, klik, screenshot, membaca error console | agent menebak-nebak apakah halamannya benar |

Tools per minat (ffmpeg, Docker, Vercel CLI, Ollama, dll) dijelaskan di [referensi/katalog-tools.md](../referensi/katalog-tools.md) kolom "Untuk apa".

## Lima perintah yang berguna untuk diketahui

Bukan untuk dihafal, cukup dikenali saat agent menjalankannya:

```bash
pwd                 # aku sedang di folder mana?        (Windows: Get-Location)
ls                  # isi folder ini apa saja?           (Windows: ls atau dir)
cd nama-folder      # pindah ke folder
code .              # buka folder ini di VS Code
nama-tool --version # tool ini sudah terpasang belum, versi berapa?
```

## Kalau ada yang aneh

- `command not found` / `is not recognized`: tutup terminal, buka lagi. Masih? Bilang ke agent, biasanya masalah PATH.
- Terminal "diam" dan kursor berkedip: mungkin sedang menunggu password atau konfirmasi `y/n`. Baca baris terakhirnya.
- Teks merah banyak: belum tentu gagal. Salin ke agent, minta dijelaskan dalam bahasa sederhana.
- Mau menghentikan perintah yang jalan lama: `Ctrl+C`.

## Coba sendiri

Buka terminal di VS Code (`` Ctrl+` ``). Sebelum menekan Enter, tebak dulu apa yang akan muncul, lalu ketik `pwd` dan `node --version`. Tebakanmu benar?

## Salah kaprah yang sering muncul

- "Teks merah berarti install gagal." Banyak tool mencetak peringatan berwarna merah padahal install berhasil. Lihat baris terakhir dan hasil `--version`.
- "Aku harus hafal perintahnya." Cukup bisa mengenali. Agent yang mengetik, kamu yang mengawasi.
- "Password-ku tidak keketik." Terminal memang tidak menampilkan apa pun saat password diketik. Ketik saja lalu Enter.

## Cek pemahaman

Agent tanyakan satu per satu.

1. "Kamu baru install Node, lalu mengetik `node --version` di terminal yang sama dan muncul `command not found`. Apa yang terjadi, dan apa yang kamu lakukan?"

Jawaban yang diharapkan: terminal itu belum membaca PATH yang baru. Tutup terminal, buka lagi, lalu coba lagi.

2. "Kenapa Homebrew (atau winget) dipasang paling awal, sebelum tools lain?"

Jawaban yang diharapkan: karena Homebrew/winget yang dipakai untuk menginstall tools berikutnya, dan nanti untuk meng-update semuanya sekaligus.

Kalau jawabannya meleset, jelaskan ulang bagian itu dengan analogi lain, lalu tanya lagi dengan skenario yang sedikit berbeda.

## Kartu contekan

- Terminal: tempat mengetik perintah. Agent mengetik, kamu mengawasi.
- Package manager (brew, winget, npm, uv): App Store versi terminal.
- `command not found` setelah install: tutup terminal, buka lagi.
- `Ctrl+C`: hentikan perintah yang sedang jalan.
