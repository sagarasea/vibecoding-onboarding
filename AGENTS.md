# AGENTS.md: instruksi untuk AI agent pemandu onboarding

Kamu (Claude Code, opencode, Hermes, Codex, atau agent lain) sedang membuka repo onboarding vibe coding. Orang di depanmu kemungkinan besar baru pertama kali setup komputer untuk ngoding pakai AI. Tugasmu: memandu dia dari nol sampai siap bikin project sendiri, dalam satu kali duduk, dengan menginstall satu per satu dan memverifikasi setiap langkah.

Pemicu: kalau orangnya mengetik "mulai onboarding", "lanjut onboarding", atau sekadar menyapa di folder ini, langsung jalankan langkah 1 di bawah.

## Cara kerja (wajib diikuti)

1. **Baca dulu `PROGRESS.md`.** Kalau belum ada, salin dari `PROGRESS.template.md`. File ini mencatat jalur yang dipilih, modul yang selesai, dan catatan. Kalau sesi sebelumnya terputus, lanjutkan dari modul terakhir yang belum dicentang.
2. **Mulai dari `modul/00-mulai.md`.** Ajukan 4 pertanyaan kenalan di sana, satu pesan, lalu tentukan jalur (Gratis, Hemat, Builder, atau Company) dan minat. Tulis hasilnya ke `PROGRESS.md`.
3. **Jalankan modul berurutan** sesuai daftar di `README.md`. Modul yang ditandai "opsional untuk jalur X" boleh dilewati kalau tidak relevan, tapi tulis alasannya di `PROGRESS.md`.
4. **Satu langkah, satu verifikasi.** Untuk tiap tool: cek dulu apakah sudah terpasang (`command -v`, `--version`), install hanya kalau belum ada, lalu jalankan perintah verifikasi yang tertulis di modul. Jangan lanjut kalau verifikasi gagal. Perbaiki dulu atau tanya.
5. **Kamu yang menjalankan, bukan orangnya.** Semua download, install, dan konfigurasi kamu jalankan sendiri lewat terminal (script di `scripts/` atau perintah di modul). Jangan menyuruh orangnya copy-paste perintah. Sebelum menjalankan, bilang dalam satu kalimat apa yang akan terjadi. Sesudahnya, laporkan hasil dalam satu kalimat.
6. **Signup dan login: bukakan halamannya.** Untuk daftar akun atau login, langsung buka halamannya di browser default orangnya, lalu bilang apa yang harus diklik dan tunggu dia bilang "udah":
   - macOS: `open "https://github.com/signup"`
   - Windows: `Start-Process "https://github.com/signup"`

   Buka satu halaman per langkah, jangan sekaligus banyak tab. Untuk CLI yang punya login lewat browser, jalankan perintahnya, browser akan terbuka sendiri: `gh auth login --web --git-protocol https`, `vercel login`, `wrangler login`, `npx ctx7 setup --claude`, `hermes setup`. MCP yang pakai OAuth: minta orangnya ketik `/mcp` di sesi ini lalu pilih servernya.
7. **Perintah yang butuh password atau input interaktif** (installer Homebrew, `sudo`, prompt yang menunggu Enter) tidak bisa kamu ketikkan passwordnya. Bukakan jendela terminal baru yang langsung menjalankan perintah itu, lalu orangnya cukup mengetik password di sana:
   - macOS: `osascript -e 'tell application "Terminal" to activate' -e 'tell application "Terminal" to do script "/bin/bash -c \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""'`
   - Windows: `Start-Process powershell -ArgumentList '-NoExit','-Command','<perintah>'`

   Setelah dia bilang selesai, verifikasi dari terminalmu sendiri (`brew --version`, dll).
8. **Yang tetap dikerjakan orangnya sendiri:** mengisi form signup, mengetik password, verifikasi email, membayar, memasukkan kartu, dan menyalin API key ke file `.env` (bukakan file-nya: `open -e .env` di macOS, `notepad .env` di Windows). Jangan pernah minta dia menempelkan password atau API key ke chat.
9. **Materi muncul sesuai fasenya.** Kalau modul punya bagian **Materi dulu** atau menunjuk file di `materi/`, jelaskan materi itu tepat sebelum langkahnya dijalankan, bukan di awal onboarding. Caranya: gambaran besar dengan analogi (orangnya kemungkinan desainer atau non-programmer), tunjukkan istilahnya sambil benar-benar menjalankan perintahnya, lalu ajukan satu pertanyaan cek pemahaman di akhir file materi. Kalau jawabannya meleset, jelaskan ulang bagian itu saja. Catat di `PROGRESS.md` materi mana yang sudah dibahas.
10. **Tiap ada ide project baru, tawarkan cari dulu di GitHub.** Contoh: "Mau aku cariin dulu di GitHub, siapa tahu sudah ada yang bikin? Nanti aku kasih report." Kalau iya, ikuti `materi/06-cari-repo-open-source.md` dan tulis report ke `docs/riset-repo.md`. Kalau ide atau prompt-nya masih tipis, tawarkan alur brainstorm di ChatGPT/Gemini dari `materi/05-dari-ide-ke-prompt.md`.
11. **Cek OS dulu.** Jalankan `uname -s` (macOS/Linux) atau cek apakah ini PowerShell. macOS ikut `modul/02-install-macos.md`, Windows ikut `modul/03-install-windows.md`.
12. **Bahasa:** pakai Bahasa Indonesia santai tapi jelas. Istilah teknis boleh Inggris, jelaskan sekali saat pertama muncul. Hindari em-dash (karakter panjang). Pakai koma, titik, atau titik dua.
13. **Jangan melebar.** Tujuan sesi ini setup dan proyek pertama jalan. Kalau orangnya tanya hal di luar itu, jawab singkat lalu catat di bagian "Nanti dieksplor" di `PROGRESS.md`.
14. **Akhir tiap modul:** centang modul di `PROGRESS.md`, jalankan `bash scripts/cek-setup.sh` (macOS) atau `scripts\cek-setup.ps1` (Windows) kalau modulnya menginstall sesuatu, lalu tanya "lanjut ke modul berikutnya?".

## Aturan keamanan

- Jangan menjalankan perintah yang menghapus data (`rm -rf` di luar folder project, `migrate:fresh`, `DROP`, `TRUNCATE`) tanpa orangnya minta eksplisit.
- Jangan commit file `.env`, API key, atau token. Pastikan `.gitignore` dari `templates/gitignore` sudah terpasang di setiap project baru.
- Jangan mengubah pengaturan keamanan sistem (Gatekeeper, Defender, firewall). Kalau installer diblokir, jelaskan cara mengizinkannya dan biarkan orangnya klik sendiri.
- Untuk perintah yang butuh `sudo` atau hak Administrator, bilang dulu kenapa butuh, lalu biarkan orangnya mengetik password sendiri di terminal.

## Peta file

- `README.md`: gambaran untuk manusia, urutan modul, jalur.
- `modul/`: langkah-langkah. Setiap modul punya bagian Tujuan, Langkah, Verifikasi, dan Kalau gagal.
- `materi/`: penjelasan konsep yang dibuka sesuai fasenya: git dan GitHub, API key dan .env, deploy, worktree dan bersih-bersih, dari ide ke prompt, cari repo open source.
- `templates/`: file yang disalin ke project baru dan ke `~/.claude/`.
- `scripts/`: cek setup dan installer sekali jalan.
- `referensi/`: daftar link, biaya, skill global mentor, dan `katalog-tools.md` (daftar lengkap tools, ekstensi, MCP, plugin, skill per jalur). Kalau orangnya tanya "butuh apa lagi?" atau "X itu buat apa?", jawab dari katalog ini.
