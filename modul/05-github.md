# 05 GitHub: simpan kerjaan dan sambungkan ke deploy

**Tujuan:** project kamu tersimpan di GitHub, kamu bisa push dari terminal, dan agent bisa bikin repo, branch, dan pull request lewat `gh`.

**Waktu:** 15 menit.

Kenapa wajib: GitHub itu tempat backup, riwayat perubahan (bisa balik ke versi kemarin kalau AI merusak sesuatu), dan pintu masuk deploy. Vercel, Cloudflare, dan VPS semuanya narik kode dari GitHub.

## Langkah

1. **Login GitHub CLI** (orangnya yang klik di browser):
   ```bash
   gh auth login
   ```
   Pilih: `GitHub.com` → `HTTPS` → `Yes` (authenticate Git) → `Login with a web browser`. Salin kode 8 digit, tempel di browser, klik Authorize.

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

## Kosakata yang perlu dipahami (cukup ini dulu)

| Istilah | Artinya |
|---|---|
| repo | folder project yang dilacak git |
| commit | titik simpan (save point) dengan pesan |
| push | kirim commit ke GitHub |
| pull | ambil perubahan terbaru dari GitHub |
| branch | cabang kerja terpisah, buat nyoba fitur tanpa merusak `main` |
| pull request (PR) | permintaan menggabungkan branch ke `main`, tempat review |

Kamu tidak perlu hafal perintahnya. Cukup bilang ke agent: "commit perubahan ini", "bikin branch buat fitur login", "push dan bikin PR". Agent yang mengetik perintahnya.

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
