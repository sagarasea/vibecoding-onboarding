# 05 GitHub: simpan kerjaan dan sambungkan ke deploy

**Tujuan:** project kamu tersimpan di GitHub, kamu bisa push dari terminal, dan agent bisa bikin repo, branch, dan pull request lewat `gh`.

**Waktu:** 15 menit.

Kenapa wajib: GitHub itu tempat backup, riwayat perubahan (bisa balik ke versi kemarin kalau AI merusak sesuatu), dan pintu masuk deploy. Vercel, Cloudflare, dan VPS semuanya narik kode dari GitHub.

## Materi dulu

Sebelum langkah pertama, agent jelaskan [materi 01: Git dan GitHub dasar](../materi/01-git-github-dasar.md): repo, commit, push, pull, branch, merge, PR, dan kapan commit. Praktiknya di langkah 3.

## Langkah

1. **Login GitHub CLI.** Agent jalankan:
   ```bash
   gh auth login --hostname github.com --git-protocol https --web
   ```
   Terminal menampilkan kode 8 digit dan browser terbuka ke halaman GitHub. Agent sebutkan kodenya di chat, orangnya tempel di browser lalu klik **Authorize**. Kalau perintahnya menunggu tombol Enter dan agent tidak bisa melanjutkan, agent bukakan jendela terminal baru yang menjalankan perintah ini (lihat aturan 7 di `AGENTS.md`).

2. **Set identitas git** (pakai email yang sama dengan akun GitHub):
   ```bash
   git config --global user.name "username-github"
   git config --global user.email "email@kamu.com"
   git config --global init.defaultBranch main
   ```

3. **Latihan: bikin repo pertama.** Agent jalankan ini di folder latihan:
   ```bash
   mkdir -p ~/Projects/halo-dunia && cd ~/Projects/halo-dunia
   git init
   echo "# Halo dunia" > README.md
   git add README.md
   git commit -m "Commit pertama"
   gh repo create halo-dunia --private --source=. --push
   ```

## Latihan branch dan PR (setelah repo pertama jadi)

Agent jalankan sambil menjelaskan tiap langkah dengan istilah dari materi 01:

```bash
git switch -c coba-branch
echo "Baris dari branch" >> README.md
git add README.md && git commit -m "Coba commit di branch"
git push -u origin coba-branch
gh pr create --fill
gh pr merge --merge --delete-branch
git switch main && git pull
```

Hasilnya: kamu sudah mengalami satu siklus penuh branch, commit, push, PR, merge, dan bersih-bersih branch.

## Kebiasaan yang dipakai mentor

- Satu project, satu repo, default **private**.
- Commit kecil dan sering. Sebelum minta AI mengubah banyak hal, commit dulu supaya gampang balik.
- Jangan pernah commit `.env`. Salin `templates/gitignore` ke project baru sebagai `.gitignore` sebelum commit pertama.
- Kerja di branch, bukan langsung di `main`, begitu project sudah dipakai orang lain.

## Verifikasi

```bash
gh auth status
gh repo view halo-dunia --web
```
Halaman repo `halo-dunia` terbuka di browser dan berisi README.

## Kalau gagal

- `gh: command not found`: balik ke modul 02/03, install GitHub CLI.
- `Permission denied` saat push: jalankan `gh auth setup-git`, lalu push ulang.
- Email beda dengan akun GitHub: commit tetap masuk tapi tidak tercatat atas nama kamu. Samakan email di langkah 2.

## Lanjut

Modul [06 File wajib](06-file-wajib.md).
