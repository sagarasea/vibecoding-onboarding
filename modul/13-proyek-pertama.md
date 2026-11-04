# 13 Proyek pertama: dari ide sampai online hari ini

**Tujuan:** satu aplikasi kecil yang benar-benar jalan, punya link publik, dan tersimpan di GitHub. Bukan aplikasi sempurna, tapi bukti alurnya sudah kamu kuasai.

**Waktu:** 2-4 jam.

## Pilih satu (atau pakai ide kamu sendiri)

| Ide | Cocok untuk minat | Stack yang disarankan |
|---|---|---|
| Aplikasi operasional internal untuk tim klien (checklist harian, request desain, tracker tugas) | SaaS dan web app | Next.js + Supabase (login + database) + Vercel |
| Clipper podcast: upload video panjang, keluar potongan pendek dengan caption | Video dan konten | Python + ffmpeg + yt-dlp + Whisper, lalu HyperFrames untuk caption |
| Bot asisten di Telegram yang menjawab pertanyaan tim dari dokumen internal | AI agent | Hermes Agent + 9router, jalan di laptop dulu, pindah ke VPS nanti |
| Landing page atau portofolio dengan desain yang tidak terlihat buatan AI | Desain | Next.js atau Astro + skill `frontend-design` + antislop + referensi desain |
| Motion graphic: reel promo, kinetic type, explainer, video brand | Video dan konten | HyperFrames (HTML jadi video) + ffmpeg, lihat bagian [Motion graphic](#motion-graphic-dua-jalur) di bawah |

Saran untuk desainer yang pegang klien: mulai dari **aplikasi operasional internal**. Masalahnya sudah kamu tahu, penggunanya sudah ada, dan kamu bisa kasih ke klien minggu ini.

## Sebelum ngoding: matangkan ide, lalu cek GitHub

1. **Bingung mulai dari mana atau prompt-nya masih satu kalimat?** Brainstorm dulu di ChatGPT atau Gemini sampai jadi brief lengkap, panjang lebar. Agent kasih "prompt untuk bikin prompt" dari [materi 05: Dari ide ke prompt](../materi/05-dari-ide-ke-prompt.md). Hasilnya disimpan sebagai `docs/brief.md`.
2. **Cek apakah sudah ada yang bikin.** Agent tawarkan: "Mau aku cariin dulu di GitHub?" Kalau iya, agent cari repo open source yang mirip, nilai lisensi, aktivitas, dan stack-nya, lalu tulis report ke `docs/riset-repo.md` ([materi 06: Cari repo open source](../materi/06-cari-repo-open-source.md)). Putuskan: pakai langsung, fork, jadikan referensi, atau bangun sendiri.

## Alur kerja (sama untuk semua ide)

1. **Bikin folder dan repo.**
   ```bash
   mkdir -p ~/Projects/nama-project && cd ~/Projects/nama-project
   git init && cp ~/path/ke/onboarding/templates/gitignore .gitignore
   bash ~/path/ke/onboarding/scripts/pasang-pengaman.sh --repo   # tolak commit berisi API key
   ```
2. **Salin file wajib project** dari `templates/`: `AGENTS.project.md` jadi `AGENTS.md`, `DESIGN.md`, lalu bikin `CLAUDE.md` berisi satu baris `@AGENTS.md`. Isi bagian yang kosong bersama agent (detail di modul 06).
3. **Cari referensi desain dulu** (modul 08) sebelum minta agent nulis UI. Tempel 2-3 link referensi ke `DESIGN.md`.
4. **Masuk plan mode.** Di Claude Code tekan `Shift+Tab` sampai muncul "plan mode" (Codex dan opencode punya mode serupa). Kalau sudah punya `docs/brief.md`, cukup minta agent membacanya bersama `AGENTS.md` dan `DESIGN.md`. Kalau belum, ceritakan:
   - siapa penggunanya,
   - 3 hal yang harus bisa mereka lakukan di versi pertama,
   - apa yang sengaja belum dibuat.

   Minta agent bikin rencana. Baca rencananya, koreksi, baru setujui.
5. **Bangun per potongan kecil.** Satu fitur, cek di browser, commit. Ulangi. Pertama kali project dijalankan, agent jelaskan [materi 07: Menjalankan project di laptop](../materi/07-menjalankan-project-lokal.md) (`npm install`, `npm run dev`, `npm run build`, localhost) dan tawarkan pilihan: agent yang menjalankan dan mengecek, kamu yang menjalankan di terminal VS Code, atau preview di Claude Desktop.
6. **Deploy** (modul 09): push ke GitHub, sambungkan ke Vercel, tambahkan environment variable di dashboard Vercel.
7. **Kirim link ke satu orang pengguna nyata.** Catat feedback di `PROGRESS.md`.

## Saat mulai kerja paralel

Begitu kamu ingin dua sesi agent jalan bersamaan di project ini (misalnya satu bikin fitur, satu benerin bug), agent jelaskan dulu [materi 04: Worktree dan bersih-bersih](../materi/04-worktree-dan-bersih-bersih.md), lalu praktikkan satu worktree dan bersihkan setelah PR-nya di-merge.

## Contoh prompt pembuka (aplikasi operasional)

```
Aku desainer in-house untuk klien [jenis bisnis]. Tim mereka [jumlah] orang dan sekarang
mencatat [proses] di [WhatsApp / spreadsheet]. Aku mau bikin aplikasi web internal untuk:
1. [aksi 1]
2. [aksi 2]
3. [aksi 3]
Belum perlu: notifikasi, pembayaran, aplikasi mobile.
Stack: Next.js + Supabase + Vercel. Desain ikuti DESIGN.md.
Bikin rencana dulu, jangan langsung coding. Tanya kalau ada yang belum jelas.
```

## Motion graphic: dua jalur

Untuk reel, promo, kinetic type, explainer, caption, atau clipper. Agent bikin video dengan **HyperFrames**: animasi ditulis sebagai HTML/CSS/JS, lalu di-render jadi MP4. Kelebihannya, agent bisa menulis, mengecek frame per frame, dan merevisi sendiri seperti mengerjakan halaman web.

### Yang dibutuhkan

| Jenis | Apa | Untuk apa | Install |
|---|---|---|---|
| Tools | Node 22+, ffmpeg, yt-dlp + deno, ImageMagick, whisper.cpp | render, potong/gabung video, download referensi, olah gambar, transkrip | `bash scripts/install-macos.sh --video` (Windows: `-Video`) |
| Framework | HyperFrames | HTML jadi video, sekitar 450 blok siap pakai (transisi, judul, caption, chart) | `claude plugin marketplace add heygen-com/hyperframes` lalu `claude plugin install hyperframes@hyperframes`. Untuk opencode/Codex: `npx hyperframes skills update` |
| Skill | watch | agent "menonton" video referensi: frame bertimestamp + transkrip | `/plugin marketplace add bradautomates/claude-video` lalu `/plugin install watch@claude-video` |
| Skill | antislop-ui, emil-design-eng, review-animations | motion yang rapi, tidak norak | modul 06 dan 12 |
| Alternatif | Remotion (video pakai React) | kalau sudah familiar React. Gratis untuk individu dan usaha sampai 3 karyawan | `npx create-video@latest` |
| Aplikasi (laptop kuat) | EffectCraft, FilmCraft (ArtCraft) | motion dan edit video native GPU, punya CLI untuk agent | `bash scripts/install-macos.sh --craft` (modul 12 bagian E) |
| Media gratis | musik dan SFX: Pixabay Music. Footage dan foto: Pexels, Pixabay, NASA, Openverse. Font: Google Fonts | aset yang boleh dipakai | cek lisensi tiap aset, catat sumbernya di `docs/aset.md` |

Ruang disk: sisakan minimal 20 GB. Render dan footage cepat memakan tempat.

### Jalur 1: langsung di Claude Code (referensi, recreate, refine)

Paling cepat untuk satu video. Kuota Claude dipakai cukup banyak, jadi cocok untuk karya yang perlu kualitas tinggi.

1. **Cari referensi yang paling bagus, bukan yang pertama ketemu.** Tempat mencari:
   - reel dan TikTok brand atau motion designer yang kamu suka (simpan link-nya),
   - [Behance](https://www.behance.net) dan [Dribbble](https://dribbble.com), cari "motion graphics", "kinetic typography", "product reel",
   - YouTube untuk explainer dan launch film,
   - untuk micro-interaction UI: [designspells.com](https://designspells.com) dan [60fps.design](https://60fps.design).

   Pilih 1 referensi utama + 1-2 pendukung, sama seperti aturan `DESIGN.md`. Tulis kenapa memilihnya: ritme, tipografi, transisi, palet, atau pacing.
2. **Bikin folder project dan simpan referensinya:**
   ```bash
   mkdir -p ~/Projects/reel-brand/referensi && cd ~/Projects/reel-brand && git init
   yt-dlp -o "referensi/%(title)s.%(ext)s" "LINK_REFERENSI"
   ```
   Pakai referensi hanya untuk dipelajari gayanya. Jangan memakai ulang footage, musik, atau logo milik orang lain di karya final.
3. **Suruh agent membedah referensinya** (skill `watch`):
   ```
   Tonton referensi/nama-file.mp4. Bedah per adegan: durasi, apa yang bergerak, jenis
   transisi, easing, tipografi, palet, dan ketukan musik. Tulis hasilnya ke docs/bedah-referensi.md.
   ```
4. **Recreate dulu, baru refine.** Di folder repo, minta Claude Code:
   ```
   Pakai HyperFrames. Recreate gaya video di docs/bedah-referensi.md untuk brand kami:
   [nama brand, pesan utama, durasi 15 detik, format 9:16]. Pakai warna dan font dari DESIGN.md.
   Jangan pakai aset dari video referensi. Render draft resolusi rendah dulu, ambil
   screenshot 6 frame penting, bandingkan dengan referensi, lalu tunjukkan ke aku.
   ```
5. **Refine dalam putaran pendek.** Kasih feedback spesifik seperti ke motion designer: "adegan 2 terlalu lambat, potong jadi 1,2 detik", "easing logo terlalu memantul, pakai ease-out", "teks baris kedua masuk setelah ketukan, bukan sebelum". Commit tiap versi yang kamu suka.
6. **Render final** resolusi penuh, cek di HP, simpan hasil render di luar git (`renders/` sudah di `.gitignore`).

HyperFrames Pro punya skill `/reverse-any-video` untuk membangun ulang video jadi project yang bisa diedit, dicek frame per frame. Opsional dan berbayar.

### Jalur 2: build engine dulu (lebih hemat untuk produksi rutin)

Kalau kebutuhannya berulang, misalnya 20 clip podcast per minggu, caption otomatis untuk semua video klien, atau template reel yang isinya berganti-ganti, jangan minta agent membuat tiap video dari nol. Minta agent **membangun mesinnya sekali**. Setelah itu tiap video dibuat dengan satu perintah, hampir tanpa memakai kuota AI.

Contoh: **clipper podcast**

```
input: video podcast panjang (file atau link)
  1. yt-dlp            download (kalau link)
  2. ffmpeg            ambil audio
  3. whisper.cpp       transkrip + timestamp per kata (lokal, gratis)
  4. model murah       pilih 5 momen terbaik dari transkrip (lewat 9router / opencode, modul 10)
  5. ffmpeg            potong tiap momen, crop 9:16 ke arah pembicara
  6. HyperFrames       template caption + judul + logo brand, isi dari data JSON
  7. render            5 clip MP4 siap posting
  8. (opsional)        upload ke R2 media-sementara, jadwalkan ke Repliz (modul 09b dan 11)
output: folder renders/tanggal/ berisi clip + file caption
```

Cara membangunnya bareng agent:
1. Brainstorm dulu di ChatGPT/Gemini sampai jadi brief (materi 05): sumber video, gaya caption, durasi clip, berapa clip per video, siapa yang review.
2. Cek GitHub, mungkin sudah ada clipper open source yang bisa jadi dasar (materi 06). Contoh hasil cek 2026-11-04: ada beberapa repo podcast clipper ber-lisensi MIT dan AGPL.
3. Minta agent membangun per tahap, tiap tahap bisa dijalankan dan dites sendiri:
   ```
   Bangun engine clipper di repo ini sesuai docs/brief.md. Satu perintah:
   uv run clipper.py --input <file-atau-link> --jumlah 5
   Tahap: download, transkrip (whisper.cpp), pilih momen (panggil model lewat ROUTER_BASE_URL
   di .env), potong + crop (ffmpeg), caption (template HyperFrames dari data JSON), render.
   Simpan preset gaya di presets/*.json supaya bisa ganti gaya tanpa ubah kode.
   Tes tiap tahap dengan video pendek 2 menit sebelum lanjut ke tahap berikutnya.
   ```
4. Setelah jalan, **preset** jadi tempat kreativitasmu: satu file JSON per gaya brand (font, warna, posisi caption, animasi). Video baru cukup ganti input dan preset.
5. Kalau mau otomatis penuh: jadwalkan lewat Hermes atau cron di VPS (modul 10), laporan masuk ke topik Logs di Telegram.

Mentor memakai pola ini untuk clipper dan editor video berbasis preset. Prinsipnya: **AI mahal dipakai untuk membangun dan memperbaiki mesin, bukan untuk mengerjakan tiap video.**

### Mana yang dipilih

| Situasi | Jalur |
|---|---|
| satu video penting (launch, promo, portofolio) | 1 |
| belajar gaya motion baru dari referensi | 1 |
| video berulang dengan format sama (clip, caption, template mingguan) | 2 |
| klien minta banyak variasi dari satu template | 2 |
| belum yakin | mulai jalur 1, kalau sudah 3 kali bikin format yang sama, jadikan engine (jalur 2) |

## Definisi selesai

- [ ] Repo ada di GitHub (private).
- [ ] Ada link publik (`*.vercel.app` atau domain sendiri) yang bisa dibuka dari HP.
- [ ] `CLAUDE.md` dan `DESIGN.md` project terisi.
- [ ] Minimal satu orang selain kamu sudah mencoba.

Catatan untuk jalur video: skill `motion-studio` dari mentor (private, harga khusus student, [katalog 7a](../referensi/katalog-tools.md#7a-produk-berbayar-dari-mentor)) bisa mempercepat jalur 1 dan 2. Tanpa skill itu, semua langkah di modul ini tetap jalan.

## Lanjut

Modul [14 Belajar lanjut](14-belajar-lanjut.md).
