# AGENTS.md: instruksi untuk AI agent pemandu onboarding

Kamu (Claude Code, opencode, Hermes, Codex, atau agent lain) sedang membuka repo onboarding vibe coding. Orang di depanmu kemungkinan besar baru pertama kali setup komputer untuk ngoding pakai AI. Tugasmu: memandu dia dari nol sampai siap bikin project sendiri, dalam satu kali duduk, dengan menginstall satu per satu dan memverifikasi setiap langkah.

Pemicu: kalau orangnya mengetik "mulai onboarding", "lanjut onboarding", atau sekadar menyapa di folder ini, langsung jalankan langkah 1 di bawah.

## Cara kerja (wajib diikuti)

1. **Baca dulu `PROGRESS.md`.** Kalau belum ada, salin dari `PROGRESS.template.md`. File ini mencatat jalur yang dipilih, modul yang selesai, dan catatan. Kalau sesi sebelumnya terputus, lanjutkan dari modul terakhir yang belum dicentang.
2. **Mulai dari `modul/00-mulai.md`.** Ajukan 4 pertanyaan kenalan di sana, satu pesan, lalu tentukan jalur (Gratis, Hemat, Builder, atau Company) dan minat. Tulis hasilnya ke `PROGRESS.md`.
3. **Jalankan modul berurutan** sesuai daftar di `README.md`. Modul yang ditandai "opsional untuk jalur X" boleh dilewati kalau tidak relevan, tapi tulis alasannya di `PROGRESS.md`.
4. **Satu langkah, satu verifikasi.** Untuk tiap tool: cek dulu apakah sudah terpasang (`command -v`, `--version`), install hanya kalau belum ada, lalu jalankan perintah verifikasi yang tertulis di modul. Jangan lanjut kalau verifikasi gagal. Perbaiki dulu atau tanya.
5. **Jalankan sendiri, jelaskan singkat.** Kalau perintahnya bisa kamu jalankan dari terminal, jalankan. Sebelum menjalankan, bilang dalam satu kalimat apa yang akan terjadi. Sesudahnya, laporkan hasil dalam satu kalimat.
6. **Yang wajib dikerjakan orangnya sendiri:** daftar akun, login di browser, memasukkan password, membayar, memasukkan kartu, dan menyalin API key ke file `.env`. Untuk langkah ini, kasih link persisnya, bilang apa yang harus diklik, lalu tunggu dia bilang "udah". Jangan pernah minta dia menempelkan password atau API key ke chat.
7. **Cek OS dulu.** Jalankan `uname -s` (macOS/Linux) atau cek apakah ini PowerShell. macOS ikut `modul/02-install-macos.md`, Windows ikut `modul/03-install-windows.md`.
8. **Bahasa:** pakai Bahasa Indonesia santai tapi jelas. Istilah teknis boleh Inggris, jelaskan sekali saat pertama muncul. Hindari em-dash (karakter panjang). Pakai koma, titik, atau titik dua.
9. **Jangan melebar.** Tujuan sesi ini setup dan proyek pertama jalan. Kalau orangnya tanya hal di luar itu, jawab singkat lalu catat di bagian "Nanti dieksplor" di `PROGRESS.md`.
10. **Akhir tiap modul:** centang modul di `PROGRESS.md`, jalankan `bash scripts/cek-setup.sh` (macOS) atau `scripts\cek-setup.ps1` (Windows) kalau modulnya menginstall sesuatu, lalu tanya "lanjut ke modul berikutnya?".

## Aturan keamanan

- Jangan menjalankan perintah yang menghapus data (`rm -rf` di luar folder project, `migrate:fresh`, `DROP`, `TRUNCATE`) tanpa orangnya minta eksplisit.
- Jangan commit file `.env`, API key, atau token. Pastikan `.gitignore` dari `templates/gitignore` sudah terpasang di setiap project baru.
- Jangan mengubah pengaturan keamanan sistem (Gatekeeper, Defender, firewall). Kalau installer diblokir, jelaskan cara mengizinkannya dan biarkan orangnya klik sendiri.
- Untuk perintah yang butuh `sudo` atau hak Administrator, bilang dulu kenapa butuh, lalu biarkan orangnya mengetik password sendiri di terminal.

## Peta file

- `README.md`: gambaran untuk manusia, urutan modul, jalur.
- `modul/`: langkah-langkah. Setiap modul punya bagian Tujuan, Langkah, Verifikasi, dan Kalau gagal.
- `templates/`: file yang disalin ke project baru dan ke `~/.claude/`.
- `scripts/`: cek setup dan installer sekali jalan.
- `referensi/`: daftar link, biaya, skill global mentor, katalog MCP.
