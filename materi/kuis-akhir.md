# Kuis akhir: sepuluh skenario

> Muncul di: **modul 14**, sebelum rencana 7 hari. Diulang di hari ke-7.
> Agent: tanyakan satu per satu, tunggu jawabannya, jangan tunjukkan kunci jawaban duluan. Jawaban dengan kata-kata sendiri yang intinya benar dihitung benar. Kalau salah, jelaskan singkat dengan analogi lain lalu tandai materinya untuk diulang. Di akhir, sebutkan skor dan materi yang perlu diulang, lalu catat di `PROGRESS.md` bagian Kuis akhir.

Pertanyaannya sengaja dicampur dan berbeda dari yang ada di tiap materi. Tujuannya mengecek apakah konsepnya bisa dipakai di situasi baru, bukan hafal jawaban.

## Pertanyaan

1. Kamu install Docker, lalu `docker --version` di terminal yang sama menjawab `command not found`. Apa yang kamu coba pertama kali?
2. Agent baru saja mengubah 12 file. Sebelum bilang "commit", perintah apa yang kamu minta agent jalankan supaya kamu tahu apa saja yang berubah?
3. Temanmu minta link untuk mencoba aplikasimu. Kamu kirim `http://localhost:3000`. Kenapa dia tidak bisa membukanya, dan apa yang seharusnya kamu kirim?
4. Kamu menemukan file `.env` muncul di daftar `git status`. Apa artinya, dan apa yang harus dibereskan sebelum commit?
5. Agent A sedang mengerjakan halaman checkout. Kamu ingin agent B menulis ulang halaman profil pada saat yang sama. Apa yang kamu siapkan?
6. Aplikasi jalan normal di laptop, tapi di Vercel muncul error "API key missing". Apa kemungkinan penyebabnya?
7. Idemu: "aplikasi absen untuk tim klien". Sebelum masuk plan mode, dua hal apa yang sebaiknya dikerjakan dulu?
8. Repo open source yang cocok memakai lisensi AGPL, dan aplikasimu akan dijual ke klien. Apa yang perlu kamu lakukan sebelum memakainya?
9. Kamu baru menambah library dengan `npm install nama-library`, lalu dev server error `Cannot find module`. Apa yang kamu coba?
10. Kamu tidak sengaja push commit berisi token Telegram bot ke GitHub (repo private). Urutkan tiga langkah pertamamu.

## Kunci jawaban (untuk agent)

| No | Inti jawaban | Materi |
|---|---|---|
| 1 | tutup terminal, buka lagi (PATH belum terbaca). Untuk Docker, pastikan juga aplikasi Docker Desktop sudah dibuka sekali. | 00 |
| 2 | `git status` dan `git diff` (atau minta agent merangkum diff-nya). | 01 |
| 3 | localhost hanya ada di laptopmu. Kirim link preview atau production dari Vercel, atau link sementara dari cloudflared. | 03, 07 |
| 4 | `.env` belum masuk `.gitignore`, jadi bisa ikut ter-commit. Tambahkan `.env` ke `.gitignore` (pakai `templates/gitignore`), pastikan hilang dari `git status`, baru commit. | 02 |
| 5 | worktree terpisah dengan branch sendiri untuk agent B. Setelah PR-nya di-merge, hapus worktree dan branch-nya. | 04 |
| 6 | environment variable belum diisi di dashboard Vercel, karena `.env` tidak ikut ter-commit. Isi di Vercel, lalu redeploy. | 03, 02 |
| 7 | brainstorm ide jadi brief di ChatGPT/Gemini (simpan ke `docs/brief.md`), lalu cari dulu repo serupa di GitHub. | 05, 06 |
| 8 | baca syarat AGPL: kalau aplikasinya dipakai orang lewat jaringan, kode sumbernya wajib dibuka. Kalau tidak bisa memenuhi itu, cari repo lain (MIT/Apache) atau jadikan referensi saja. | 06 |
| 9 | matikan dev server lalu jalankan lagi. Kalau masih error, `npm install` sekali lagi dan cek nama library-nya. | 07 |
| 10 | (1) revoke token di BotFather (`/revoke`) dan ambil token baru, (2) ganti nilai di `.env` laptop dan di server, (3) pasang scan rahasia (`bash scripts/pasang-pengaman.sh --repo`) supaya tidak terulang. Repo private tidak membuat token aman, dan menghapus commit saja tidak cukup. | 02 |

Skor 8 ke atas: lanjut. Skor 5-7: ulangi materi yang salah bersama agent minggu ini. Di bawah 5: ulangi materinya sekarang, satu per satu, lalu coba kuis lagi di hari ke-7.
