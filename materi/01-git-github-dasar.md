# Materi 01: Git dan GitHub dasar

> Muncul di: **modul 05**, sebelum login `gh` dan bikin repo pertama.
> Agent: jelaskan bagian "Gambaran besar" dengan analoginya, lalu tunjukkan tiap istilah sambil benar-benar menjalankannya di repo latihan. Tutup dengan satu pertanyaan cek pemahaman di akhir file.

## Gambaran besar

Bayangkan kamu desain di Figma tanpa version history dan tanpa cloud. Satu klik salah, kerjaan seharian hilang. **Git** itu version history untuk folder kode: setiap titik simpan tercatat dan bisa dibuka lagi. **GitHub** itu cloud tempat riwayat itu disimpan, dibagi ke orang lain, dan disambungkan ke hosting.

Kenapa ini lebih penting lagi kalau ngoding pakai AI: agent bisa mengubah 20 file dalam satu menit. Kalau hasilnya rusak, kamu cukup balik ke titik simpan terakhir.

## Istilah yang sering dipakai

| Istilah | Artinya | Analogi | Perintah | Kapan |
|---|---|---|---|---|
| **repo** (repository) | folder project yang riwayatnya dilacak git | file Figma dengan version history | `git init` (bikin baru), `gh repo create` (di GitHub) | sekali per project |
| **clone** | menyalin repo dari GitHub ke laptop | download file dari cloud, lengkap dengan history | `gh repo clone user/nama` | saat mulai kerja di repo yang sudah ada, atau pindah laptop |
| **status** | melihat file apa yang berubah | daftar layer yang belum disimpan | `git status` | sering, sebelum commit |
| **diff** | melihat isi perubahannya baris per baris | before/after | `git diff` | sebelum commit, untuk cek kerjaan agent |
| **commit** | titik simpan dengan pesan | "save version" dengan nama | `git add . && git commit -m "Tambah form login"` | setiap satu potongan kerja selesai dan jalan |
| **push** | kirim commit dari laptop ke GitHub | upload ke cloud | `git push` | setelah commit, minimal di akhir hari |
| **pull** | ambil perubahan terbaru dari GitHub | sync dari cloud | `git pull` | sebelum mulai kerja, terutama kalau kerja bareng orang atau di 2 laptop |
| **branch** | cabang kerja terpisah dari `main` | duplikat page untuk eksplorasi tanpa merusak yang asli | `git switch -c fitur-login` | setiap mulai fitur baru atau eksperimen |
| **main** | branch utama, versi yang "resmi" dan biasanya yang di-deploy | page final | | jangan kerja langsung di sini begitu project dipakai orang |
| **merge** | menggabungkan branch ke branch lain | menyalin hasil eksplorasi ke page final | lewat pull request, atau `git merge` | setelah fitur selesai dan dicek |
| **pull request (PR)** | permintaan merge di GitHub, tempat review dan diskusi | minta approval sebelum desain final | `gh pr create` | setiap branch mau masuk ke `main` |
| **conflict** | dua perubahan menyentuh baris yang sama, git bingung mana yang dipakai | dua orang edit layer yang sama | agent bisa membereskan: "resolve conflict ini" | saat merge atau pull |
| **.gitignore** | daftar file yang tidak boleh ikut dilacak | layer yang di-hide dari export | file di root project | dipasang sebelum commit pertama |
| **revert** | membatalkan satu commit dengan commit baru | undo yang tercatat | `git revert <id-commit>` | commit yang sudah di-push ternyata salah |

## Alur harian (yang paling sering kamu suruh ke agent)

```
git pull                      1. ambil versi terbaru
git switch -c fitur-x         2. bikin branch untuk satu fitur
  ... agent kerja ...
git status / git diff         3. cek apa yang berubah
git add . && git commit       4. simpan titik
git push -u origin fitur-x    5. kirim ke GitHub
gh pr create                  6. bikin PR, Vercel kasih link preview
  ... cek preview, review ...
gh pr merge                   7. gabung ke main, otomatis deploy production
```

Kamu tidak perlu mengetik ini. Cukup bilang ke agent: "bikin branch buat fitur X", "commit", "push dan bikin PR", "merge PR-nya". Yang penting kamu paham artinya, supaya tahu apa yang sedang terjadi.

## Kapan commit? Aturan praktis

- Setiap selesai satu hal kecil yang **jalan** (bukan setengah jadi): satu form, satu halaman, satu bug fix.
- **Sebelum** minta agent melakukan perubahan besar. Kalau hasilnya kacau: "balikin ke commit terakhir".
- Pesan commit menjelaskan **apa yang berubah**, bukan "update" atau "fix". Contoh: "Tambah validasi email di form daftar".

## Kenapa kerja di branch, bukan langsung di main

- `main` biasanya tersambung ke deploy production. Push ke `main` langsung tayang ke pengguna.
- Branch bikin kamu bebas eksperimen. Kalau gagal, branch-nya dibuang saja, `main` aman.
- Setiap PR dapat link preview dari Vercel, jadi klien bisa lihat dulu sebelum tayang.

Untuk latihan dan project yang belum dipakai siapa pun, commit langsung di `main` masih boleh.

## Cek pemahaman

Agent tanyakan satu: "Kamu habis minta agent ganti seluruh tampilan dashboard, ternyata hasilnya jelek dan kamu belum commit apa-apa sejak pagi. Apa yang hilang, dan apa yang seharusnya dilakukan tadi pagi?"

Jawaban yang diharapkan: semua perubahan sejak pagi tidak punya titik balik. Seharusnya commit dulu sebelum minta perubahan besar, atau kerjakan di branch terpisah.
