# 00b Jalur kilat: siap dalam sekitar 3 jam

**Tujuan:** semua tools, aturan agent, pengaman, dan plugin dasar terpasang dengan satu perintah, login selesai, lalu langsung bikin proyek pertama sampai online. Materi tetap diajarkan, tapi di sela waktu menunggu install, bukan dilewati.

**Untuk siapa:** orang yang mau cepat jalan dan tidak keberatan membaca modul lain belakangan. Agent tawarkan pilihan ini di akhir modul 00: "Mau jalur lengkap (modul satu per satu) atau jalur kilat (satu perintah install, langsung proyek)?"

## Jadwal

| Waktu (kira-kira) | Apa | Yang dikerjakan orangnya |
|---|---|---|
| 0:00-0:10 | Modul 00: kenalan, jalur biaya, minat, cek spesifikasi | menjawab 4 pertanyaan |
| 0:10-0:50 | `setup-kilat` jalan di background (20-60 menit, tergantung internet) | sambil menunggu: daftar akun (modul 01) dan materi 00, 01, 02 |
| 0:50-1:10 | Login satu per satu (daftar di akhir output script) | klik Authorize di browser |
| 1:10-1:20 | `cek-setup` dan tes: Claude Code, Codex, opencode masing-masing menjawab satu pertanyaan | membaca hasil |
| 1:20-3:20 | Modul 13: brief, cek GitHub, referensi desain, bangun, deploy ke Vercel | memberi arahan dan mengecek hasil |
| belakangan | Modul 08, 09b, 10, 11, 12 sesuai kebutuhan, modul 14 dengan kuis akhir | |

## Langkah 1: tentukan flag dari minat

| Minat di `PROGRESS.md` | Flag macOS | Flag Windows |
|---|---|---|
| SaaS dan web app | `--web` | `-Web` |
| Video dan konten | `--video` | `-Video` |
| AI agent dan automation | `--agent` | `-Agent` |
| Desain dan landing page | `--desain` | `-Desain` |
| Laptop kuat (modul 00 langkah 4) | `--craft` | `-Craft` |
| Belum yakin, disk lega | `--semua` | `-Semua` |

Tanyakan juga nama dan email untuk identitas git (email yang sama dengan akun GitHub).

## Langkah 2: agent jalankan di background

macOS:
```bash
GIT_NAME="Nama" GIT_EMAIL="email@contoh.com" bash scripts/setup-kilat.sh --web
```

Windows (PowerShell):
```powershell
$env:GIT_NAME="Nama"; $env:GIT_EMAIL="email@contoh.com"
powershell -ExecutionPolicy Bypass -File scripts\setup-kilat.ps1 -Web
```

Script ini menjalankan tujuh tahap: install tools, identitas git, aturan global agent (`~/.claude/CLAUDE.md` dan `~/.codex/AGENTS.md`), pengaman db-safety, plugin dasar (antislop, frontend-design, plus hyperframes dan watch untuk video), cek setup, lalu daftar login.

Agent: jalankan di background, dan setiap muncul baris `==>`, bacakan satu kalimat "untuk apa" ke orangnya. Hal yang perlu diketahui:
- **Mac baru tanpa Homebrew:** script membuka jendela Terminal baru untuk install Homebrew lalu berhenti. Orangnya mengetik password Mac di jendela itu. Setelah muncul SELESAI, jalankan ulang perintah yang sama.
- **Diminta password di tengah jalan** (beberapa aplikasi seperti Docker): bukakan jendela terminal sesuai aturan 7 di `AGENTS.md`.
- **`~/.claude/CLAUDE.md` sudah ada:** script tidak menimpanya. Template disimpan sebagai `CLAUDE.md.onboarding`, lalu agent menggabungkan keduanya bersama orangnya.

## Langkah 3: isi waktu tunggu dengan belajar

Install yang lama justru waktu yang pas untuk materi:
1. Orangnya daftar akun yang belum ada (modul 01). Agent membukakan halamannya satu per satu.
2. Agent jelaskan [materi 00](../materi/00-terminal-dan-tools-dasar.md) sambil menunjuk output script yang sedang jalan.
3. Lanjut [materi 01](../materi/01-git-github-dasar.md) dan [materi 02](../materi/02-api-key-dan-env.md). Praktiknya menyusul di proyek pertama.

Cek pemahaman tetap dijalankan. Catat hasilnya di `PROGRESS.md`.

## Langkah 4: login dan cek

Ikuti daftar di akhir output script, satu per satu (aturan 6 di `AGENTS.md`). Lalu:

```bash
bash scripts/cek-setup.sh
```

Semua tools dasar harus `[OK]`. Yang masih `[BELUM]` diselesaikan dulu sebelum lanjut, pakai bagian "Kalau gagal" di modul 02 atau 03.

## Langkah 5: langsung ke proyek pertama

Buka [modul 13](13-proyek-pertama.md). Materi 05, 06, 07, dan 03 muncul di sana sesuai fasenya. Untuk `DESIGN.md`, ambil 2-3 referensi dari [modul 08](08-referensi-desain.md) saat langkahnya tiba. Untuk deploy, cukup Vercel + Supabase gratis dari [modul 09 bagian A](09-deploy.md#a-jalur-gratis-github-ke-vercel).

## Yang sengaja ditunda

Latihan branch dan PR di repo latihan (modul 05) dipraktikkan langsung di proyek pertama. Cloudflare, router API, agent 24 jam, dan automation (modul 09b, 10, 11) dikerjakan saat dibutuhkan. Catat di `PROGRESS.md` bagian "Nanti dieksplor" supaya tidak lupa.

## Verifikasi

- [ ] `cek-setup` menampilkan semua tools dasar `[OK]`, hook db-safety aktif, dan `~/.claude/CLAUDE.md` ada.
- [ ] Claude Code, Codex (kalau punya ChatGPT Plus), dan opencode masing-masing menjawab "ringkas AGENTS.md dalam 3 poin".
- [ ] `claude plugin list` menampilkan antislop dan frontend-design.
- [ ] Materi 00, 01, 02 tercentang di `PROGRESS.md`.

## Lanjut

Modul [13 Proyek pertama](13-proyek-pertama.md).
