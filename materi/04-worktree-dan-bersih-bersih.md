# Materi 04: Worktree, kerja paralel, dan bersih-bersih

> Muncul di: **modul 13**, saat kamu mulai ingin menjalankan lebih dari satu sesi agent di project yang sama (misalnya satu agent bikin fitur, satu lagi benerin bug). Diingatkan lagi di modul 14 (rutinitas bulanan).
> Agent: jelaskan masalahnya dulu (dua agent di satu folder saling timpa), baru solusinya. Praktikkan satu worktree di proyek pertama, lalu bersihkan.

**Setelah ini kamu bisa:**

- menjelaskan kenapa dua agent di satu folder bisa saling timpa
- bikin satu worktree, memakainya, lalu menghapusnya
- tahu kapan waktunya bersih-bersih branch dan worktree

## Masalahnya

Satu folder project hanya bisa berada di **satu branch** dalam satu waktu. Kalau dua sesi agent bekerja di folder yang sama, mereka mengedit file yang sama, saling menimpa, dan commit-nya tercampur.

## Apa itu worktree

**Worktree** adalah folder kedua (ketiga, dst) dari repo yang sama, masing-masing berada di branch-nya sendiri. Riwayat git-nya satu, foldernya terpisah.

Analogi desainer: satu file Figma, tapi tiap orang kerja di page duplikat masing-masing. Setelah selesai, hasilnya digabung ke page final.

```
~/Projects/klien-app            ← branch main (folder utama)
~/Projects/klien-app-login      ← worktree, branch fitur-login (agent A)
~/Projects/klien-app-laporan    ← worktree, branch fitur-laporan (agent B)
```

## Kapan pakai, kapan tidak

| Pakai worktree | Tidak perlu |
|---|---|
| dua agent atau lebih jalan bersamaan di project yang sama | satu sesi saja, kerja berurutan |
| mau nyoba dua pendekatan desain lalu pilih satu | perubahan kecil satu file |
| agent jalan lama di background, kamu tetap mau kerja di `main` | project latihan |

Kalau ragu: satu sesi, satu branch, cukup. Worktree baru berguna saat kamu mulai paralel.

## Cara pakai

Paling gampang, biarkan tools yang membuatnya:

- **Claude Code:** `claude --worktree fitur-login` membuat worktree + branch baru dan langsung membuka sesi di sana.
- **Claude Desktop (tab Code):** tiap sesi bisa dibuat di worktree sendiri secara otomatis.
- **Manual dengan git:**
  ```bash
  git worktree add ../klien-app-login -b fitur-login
  cd ../klien-app-login
  ```

Catatan: worktree baru tidak membawa `node_modules` dan `.env`. Agent perlu menjalankan `npm install` dan menyalin `.env` (bukan meng-commit-nya) di worktree itu.

## Bersih-bersih: kapan dan kenapa

Kenapa perlu: setiap worktree memakan ruang disk (apalagi dengan `node_modules`, bisa ratusan MB), branch lama bikin bingung mana yang masih dipakai, dan agent bisa salah membaca folder yang sudah usang.

Kapan:
- **Setelah PR di-merge:** hapus worktree dan branch-nya hari itu juga.
- **Setelah eksperimen ditolak:** hapus tanpa merge.
- **Sebulan sekali:** cek sisa-sisa yang lupa dihapus.

Perintah (agent yang jalankan, kamu cukup bilang "bersihin worktree dan branch yang sudah di-merge"):

```bash
git worktree list                         # lihat semua worktree
git worktree remove ../klien-app-login    # hapus satu worktree (folder + catatannya)
git worktree prune                        # bersihkan catatan worktree yang foldernya sudah hilang
git switch main && git pull               # pastikan main terbaru
git branch --merged main                  # daftar branch yang sudah masuk main
git branch -d fitur-login                 # hapus branch lokal yang sudah di-merge
git fetch --prune                         # hapus referensi branch remote yang sudah dihapus di GitHub
```

`git branch -d` (huruf kecil) menolak menghapus branch yang belum di-merge, jadi aman. `-D` (huruf besar) memaksa hapus, pakai hanya untuk eksperimen yang memang dibuang.

Supaya branch di GitHub terhapus otomatis setelah PR di-merge: buka repo di GitHub, Settings, General, centang **Automatically delete head branches**. Atau agent jalankan:

```bash
gh repo edit --delete-branch-on-merge
```

## Bersih-bersih lain yang berguna

| Apa | Kenapa | Perintah |
|---|---|---|
| `node_modules` project lama | bisa ratusan MB per project | hapus foldernya, `npm install` lagi kalau perlu |
| cache Homebrew (macOS) | installer lama menumpuk | `brew cleanup` |
| image Docker tak terpakai | bisa puluhan GB | `docker system prune` (tanya dulu, ini menghapus container yang berhenti) |
| sesi agent lama | sidebar penuh | arsipkan sesi yang selesai di Claude Desktop |

## Salah kaprah yang sering muncul

- "Worktree sama dengan clone kedua." Worktree memakai riwayat git yang sama, jadi lebih hemat tempat dan branch-nya langsung terlihat dari folder utama.
- "Hapus folder worktree lewat Finder sudah cukup." Pakai `git worktree remove` supaya git ikut lupa. Kalau terlanjur, `git worktree prune`.
- "Kerja paralel selalu lebih cepat." Dua tugas yang menyentuh file yang sama lebih aman dikerjakan berurutan. Paralel hanya untuk tugas yang benar-benar terpisah.

## Cek pemahaman

Agent tanyakan satu per satu.

1. "Agent A sedang bikin fitur login, dan kamu mau agent B benerin bug di halaman laporan pada saat yang sama. Apa yang kamu siapkan dulu, dan apa yang kamu lakukan setelah PR bug fix di-merge?"

Jawaban yang diharapkan: buat worktree terpisah (branch sendiri) untuk agent B. Setelah PR di-merge, hapus worktree dan branch-nya (`git worktree remove`, `git branch -d`).

2. "Sebutkan satu situasi di mana worktree justru tidak perlu."

Jawaban yang diharapkan: cuma satu agent yang bekerja, atau dua tugas menyentuh file yang sama sehingga lebih aman berurutan.

Kalau jawabannya meleset, jelaskan ulang bagian itu dengan analogi lain, lalu tanya lagi dengan skenario yang sedikit berbeda.

## Kartu contekan

- worktree: folder kerja kedua dari repo yang sama, dengan branch sendiri.
- Satu agent, satu worktree.
- PR sudah di-merge: hapus worktree dan branch-nya.
- Sebulan sekali: bersih-bersih branch, worktree, dan cache.
