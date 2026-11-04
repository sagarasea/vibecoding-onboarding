# Materi konsep

Penjelasan konsep yang muncul tepat saat dibutuhkan, bukan di awal. Agent membuka materi ini di titik yang ditandai **Materi dulu** di tiap modul, menjelaskannya dengan analogi, mempraktikkannya, lalu menutup dengan pertanyaan cek pemahaman.

| Materi | Muncul di | Isi |
|---|---|---|
| [00 Terminal dan tools dasar](00-terminal-dan-tools-dasar.md) | modul 02 / 03, sebelum install | terminal, package manager, PATH, sudo, localhost, kenapa butuh Node, npm, npx, uv, git, dll |
| [01 Git dan GitHub dasar](01-git-github-dasar.md) | modul 05 | repo, clone, commit, push, pull, branch, merge, PR, conflict, revert, .gitignore, kapan commit |
| [02 API key dan .env](02-api-key-dan-env.md) | modul 07 (diulang di 09, 10, 11) | apa itu API dan API key, .env dan .env.example, aturan, kalau bocor |
| [03 Deploy](03-deploy.md) | modul 09 | localhost, build, hosting, production vs preview, env var, domain, DNS, rollback |
| [04 Worktree dan bersih-bersih](04-worktree-dan-bersih-bersih.md) | modul 13 (diulang di 14) | kerja paralel, worktree, kapan dan cara bersih-bersih branch, worktree, cache |
| [05 Dari ide ke prompt](05-dari-ide-ke-prompt.md) | modul 13, sebelum plan mode | brainstorm di ChatGPT/Gemini sampai jadi brief lengkap, lalu dibawa ke agent coding |
| [06 Cari repo open source](06-cari-repo-open-source.md) | modul 13, sebelum bangun dari nol | cari di GitHub dulu, cara menilai repo dan lisensi, format report |
| [07 Menjalankan project di laptop](07-menjalankan-project-lokal.md) | modul 13 (diulang di 09) | npm install, npm run dev, build, start, localhost, siapa yang menjalankan, lihat di HP, cloudflared |
| [08 Penempatan folder yang rapi](08-penempatan-folder.md) | modul 05 (bagian A), modul 10 (bagian B, Builder) | `~/Projects` per brand atau klien, nama folder = nama repo, organization GitHub, workdesk Hermes di VPS dengan satu profile per brand |

Pendukung:

| File | Untuk |
|---|---|
| [Kamus istilah](kamus.md) | semua istilah dalam satu halaman, satu baris per istilah, dengan link ke materinya |
| [Kuis akhir](kuis-akhir.md) | sepuluh pertanyaan skenario campuran, di akhir onboarding (modul 14) dan diulang di hari ke-7 |

Mau baca duluan juga boleh. Semua materi bisa dibaca tanpa agent.

## Isi setiap materi

Setiap file punya urutan yang sama, supaya orangnya tahu apa yang akan datang:

1. **Setelah ini kamu bisa**: dua atau tiga hal yang bisa dicek, bukan "paham tentang X".
2. **Gambaran besar**: masalahnya dulu, lalu analogi dari dunia desain atau sehari-hari.
3. **Istilah**: hanya yang dipakai di fase itu.
4. **Coba sendiri** atau **Praktik**: satu hal yang orangnya kerjakan, dengan hasil yang kelihatan.
5. **Salah kaprah yang sering muncul**: anggapan keliru yang paling sering, dan pelurusannya.
6. **Cek pemahaman**: dua pertanyaan skenario, satu per satu.
7. **Kartu contekan**: ringkasan untuk dibuka lagi nanti.

## Cara agent mengajar

1. **Masalah dulu, definisi belakangan.** Mulai dari "kenapa ini perlu" dengan contoh yang dekat dengan kerjaan orangnya (lihat Profil di `PROGRESS.md`).
2. **Paling banyak tiga istilah baru sekali jalan.** Sisanya dikenalkan saat benar-benar dipakai.
3. **Tebak dulu, baru jalankan.** Sebelum menjalankan perintah yang sedang dibahas, minta orangnya menebak hasilnya. Tebakan yang salah tidak apa-apa, justru dari situ orang paling banyak belajar.
4. **Tunjukkan di layar.** Jalankan perintahnya, lalu tunjuk baris output yang penting. Jangan menjelaskan output yang tidak ada.
5. **Cek pakai skenario, bukan hafalan.** Tanya satu per satu dan tunggu jawabannya. Kalau meleset, ganti analogi, jangan mengulang kalimat yang sama.
6. **Minta dijelaskan balik.** Untuk konsep inti (commit vs push, `.env`, preview vs production), minta orangnya menjelaskan dengan bahasanya sendiri dalam satu kalimat.
7. **Perhatikan tanda capek.** Kalau jawabannya makin pendek atau dia bilang bingung, tawarkan istirahat lima menit atau langsung praktik dulu, penjelasannya menyusul.
8. **Catat.** Di `PROGRESS.md`, tulis materi yang sudah dibahas dan hasilnya: paham, atau perlu diulang (dan bagian mana).
9. **Jangan menyelipkan tawaran produk** di tengah materi. Aturannya di `AGENTS.md` bagian produk dan layanan.
