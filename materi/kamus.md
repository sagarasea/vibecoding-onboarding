# Kamus istilah

Satu baris per istilah, urut abjad. Angka di kolom terakhir menunjuk file materi yang membahasnya lebih lengkap.

| Istilah | Artinya | Materi |
|---|---|---|
| **agent** | AI yang bisa membaca file, menjalankan perintah, dan mengecek hasilnya sendiri (Claude Code, Codex, opencode, Hermes) | modul 04 |
| **AGENTS.md** | file konteks project yang dibaca semua agent: apa project ini, stack, aturan | modul 06 |
| **API** | pintu supaya satu aplikasi bisa meminta sesuatu ke aplikasi lain | 02 |
| **API key** | kunci untuk memakai API, sekaligus penanda siapa yang ditagih | 02 |
| **branch** | cabang riwayat untuk mengerjakan satu fitur tanpa mengganggu `main` | 01 |
| **build** | mengubah kode jadi versi siap tayang (`npm run build`). Lebih ketat dari dev server | 07, 03 |
| **CLI** | versi terminal dari sebuah tool, contoh `gh`, `vercel`, `claude` | 00 |
| **clone** | menyalin repo dari GitHub ke laptop, lengkap dengan riwayatnya | 01 |
| **commit** | titik simpan di laptop, dengan pesan apa yang berubah | 01 |
| **conflict** | dua perubahan menyentuh baris yang sama, git perlu diberi tahu mana yang dipakai | 01 |
| **deploy** | memasang aplikasi ke hosting supaya bisa dibuka orang lain | 03 |
| **dev server** | aplikasi yang jalan di laptop selama kamu bekerja (`npm run dev`), memuat ulang sendiri saat kode berubah | 07 |
| **diff** | perbandingan sebelum dan sesudah, baris per baris | 01 |
| **DNS** | petunjuk arah dari nama domain ke server yang dituju | 03, modul 09b |
| **domain** | alamat situs, contoh `namakamu.com`. Bukan hosting | 03 |
| **`.env`** | file berisi rahasia (API key, password database). Tidak pernah di-commit | 02 |
| **`.env.example`** | daftar nama variabel tanpa nilai. Di-commit, supaya orang tahu key apa yang dibutuhkan | 02 |
| **environment variable** | nilai yang dibaca aplikasi dari luar kode, di laptop dari `.env`, di hosting dari dashboard | 02, 03 |
| **fork** | salinan repo orang lain di akun GitHub-mu sendiri | 06 |
| **`.gitignore`** | daftar file yang tidak boleh ikut dilacak git | 01 |
| **hook** | perintah yang otomatis jalan sebelum atau sesudah agent melakukan sesuatu, contoh pengaman db-safety | modul 06 |
| **hosting** | tempat aplikasi jalan di internet (Vercel, VPS) | 03 |
| **lisensi** | aturan boleh tidaknya kode orang dipakai (MIT, Apache, GPL, AGPL). Tanpa lisensi berarti tidak boleh | 06 |
| **localhost** | alamat aplikasi yang jalan di laptopmu sendiri. Tidak bisa dibuka dari perangkat lain | 00, 07 |
| **main** | branch utama, biasanya yang tersambung ke production | 01 |
| **MCP** | kabel penghubung agent ke aplikasi atau data luar (browser, Figma, Supabase) | modul 07 |
| **merge** | menggabungkan satu branch ke branch lain | 01 |
| **npm / npx** | package manager JavaScript. `npm install` mengunduh library, `npx` menjalankan tool tanpa install permanen | 00 |
| **organization (GitHub)** | "kantor" di GitHub untuk satu brand atau klien, tempat repo dan anggota timnya dikumpulkan | 08 |
| **package manager** | App Store versi terminal: Homebrew, winget, npm, uv | 00 |
| **PATH** | daftar folder tempat terminal mencari perintah. Terminal baru diperlukan setelah install | 00 |
| **plan mode** | mode agent yang menyusun rencana dulu sebelum mengubah file | modul 04 |
| **plugin** | paket berisi skill, perintah, hook, atau MCP sekaligus | modul 07 |
| **port** | nomor "pintu" aplikasi di laptop, contoh `3000` di `localhost:3000` | 07 |
| **preview** | link deploy per branch atau PR, untuk dicek sebelum tayang | 03 |
| **production** | versi yang dipakai pengguna sungguhan | 03 |
| **profile (Hermes)** | satu Hermes terpisah dengan memori, aturan, `.env`, bot Telegram, dan cron sendiri. Satu per brand | 08 |
| **pull** | mengambil perubahan terbaru dari GitHub ke laptop | 01 |
| **pull request (PR)** | permintaan menggabungkan branch ke `main`, tempat review | 01 |
| **push** | mengirim commit dari laptop ke GitHub | 01 |
| **repo** | folder project yang riwayatnya dilacak git | 01 |
| **revert** | membatalkan satu commit dengan commit baru | 01 |
| **revoke / rotate** | mematikan key lama dan membuat yang baru, langkah pertama kalau key bocor | 02 |
| **rollback** | kembali ke deploy sebelumnya kalau yang baru rusak | 03 |
| **skill** | folder berisi instruksi untuk satu jenis tugas, dimuat agent saat tugasnya cocok | modul 07 |
| **sudo / Administrator** | menjalankan perintah dengan izin penuh. Password diketik sendiri | 00 |
| **terminal** | aplikasi tempat mengetik perintah | 00 |
| **workdesk** | folder kerja agent di VPS, satu per brand: konteks, repo, aset, dan hasil kerja | 08 |
| **worktree** | folder kerja kedua dari repo yang sama dengan branch sendiri, untuk agent paralel | 04 |
