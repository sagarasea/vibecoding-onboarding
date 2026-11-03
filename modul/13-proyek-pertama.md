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

## Definisi selesai

- [ ] Repo ada di GitHub (private).
- [ ] Ada link publik (`*.vercel.app` atau domain sendiri) yang bisa dibuka dari HP.
- [ ] `CLAUDE.md` dan `DESIGN.md` project terisi.
- [ ] Minimal satu orang selain kamu sudah mencoba.

## Lanjut

Modul [14 Belajar lanjut](14-belajar-lanjut.md).
