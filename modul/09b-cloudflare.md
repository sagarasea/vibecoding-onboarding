# 09b Cloudflare: domain, DNS, email, dan R2

**Tujuan:** domain kamu dikelola di Cloudflare, punya alamat email `hello@domainkamu.com` yang masuk ke Gmail, backup database VPS tersimpan otomatis di R2, dan ada tempat menaruh gambar/video sementara yang terhapus sendiri, untuk dipakai agent saat upload ke Repliz.

**Waktu:** 45-60 menit. Bagian D dan E untuk jalur Builder (yang punya VPS atau automation).

**Butuh:** akun Cloudflare (modul 01), domain (beli di Hostinger, modul 09), Wrangler (`npm i -g wrangler`, sudah terpasang kalau script jalan dengan `--web`).

## Kenapa semua lewat Cloudflare

| Fitur | Untuk apa | Biaya |
|---|---|---|
| **DNS** | satu tempat mengatur ke mana domain dan subdomain mengarah (Vercel, VPS, email) | gratis |
| **Proxy + SSL** | HTTPS otomatis, menyembunyikan IP VPS, menahan serangan | gratis |
| **Email Routing** | email ke `apa@domainkamu.com` diteruskan ke Gmail. Kelihatan profesional tanpa bayar hosting email | gratis |
| **Access** | halaman admin/internal dikunci login email (One-time PIN) | gratis sampai 50 user |
| **R2** | penyimpanan file (seperti Google Drive untuk aplikasi): backup database, media. Tidak ada biaya download (egress) | gratis 10 GB, lalu murah per GB |

Domain tetap dibeli dan diperpanjang di Hostinger. Yang dipindah ke Cloudflare hanya pengelolaan DNS-nya.

## A. Pindahkan DNS domain ke Cloudflare

1. Agent buka dashboard: `open "https://dash.cloudflare.com"` (Windows: `Start-Process`). Orangnya klik **Add a domain**, ketik domain, pilih paket **Free**.
2. Cloudflare memindai record DNS yang ada. Cek daftarnya, biarkan yang sudah ada.
3. Cloudflare menampilkan **dua nameserver** (contoh `xxx.ns.cloudflare.com`). Agent catat keduanya di chat.
4. Agent buka panel Hostinger: `open "https://hpanel.hostinger.com"`. Orangnya buka **Domain**, pilih domainnya, **DNS / Nameservers**, **Change nameservers**, isi dua nameserver Cloudflare, simpan.
5. Tunggu aktif (biasanya kurang dari 1 jam, maksimal 24 jam). Agent cek:
   ```bash
   dig NS domainkamu.com +short          # macOS/Linux
   nslookup -type=NS domainkamu.com      # Windows
   ```
   Berhasil kalau yang muncul nameserver Cloudflare.
6. Login Wrangler supaya agent bisa mengatur Cloudflare dari terminal: `wrangler login` (browser terbuka, orangnya klik Allow). Agent juga bisa memasang plugin Cloudflare (modul 07) untuk skill DNS dan Workers.

### Arahkan domain ke aplikasi

| Tujuan | Record | Isi |
|---|---|---|
| Vercel | sesuai yang diminta Vercel di Project, Settings, Domains (biasanya `A` ke IP Vercel atau `CNAME` ke `cname.vercel-dns.com`) | proxy **abu-abu (DNS only)** untuk Vercel |
| VPS | `A` dengan nama `@` atau `app`, isi IP VPS | proxy **oranye (Proxied)** |

Aturan dari pengalaman mentor: **untuk VPS, pasang vhost nginx dulu, baru bikin record DNS** (modul 09 bagian C). Hostname tanpa vhost bisa menampilkan aplikasi lain.

## B. Email Routing: `hello@domainkamu.com` masuk ke Gmail

1. Di Cloudflare: pilih domain, **Email**, **Email Routing**, **Get started**. Cloudflare menambahkan record MX dan SPF otomatis, klik **Add records and enable**.
2. **Destination addresses**: tambahkan Gmail kamu. Cloudflare mengirim email verifikasi, orangnya klik link di Gmail.
3. **Routing rules**, **Create address**: contoh `hello` diteruskan ke Gmail tadi. Tambahkan juga `admin`, `billing`, dll kalau perlu, atau aktifkan **Catch-all** supaya semua alamat masuk.
4. Tes: kirim email dari akun lain ke `hello@domainkamu.com`, harus masuk Gmail.

Untuk perusahaan dengan banyak karyawan yang butuh kotak masuk sendiri-sendiri (bukan sekadar diteruskan ke Gmail), lihat jasa setup email perusahaan dari mentor di modul 10 bagian F.

Catatan: Email Routing hanya **menerima**. Untuk **mengirim** email dari aplikasi (verifikasi akun, reset password, notifikasi), pakai Resend (modul 12 bagian A) dengan domain yang sama. Resend akan meminta beberapa record DNS, tambahkan di Cloudflare.

## C. R2: bikin bucket

Agent jalankan (setelah `wrangler login`):

```bash
wrangler r2 bucket create backup-db          # untuk backup database (privat)
wrangler r2 bucket create media-sementara    # untuk media upload Repliz (publik, auto-hapus)
wrangler r2 bucket list
```

Untuk akses dari VPS atau script, bikin **API token R2**: orangnya buka dashboard, **R2**, **Manage API tokens**, **Create API token**, izin **Object Read & Write**, batasi ke dua bucket di atas. Simpan tiga nilai ke `.env` (agent bukakan file-nya, orangnya yang menempel):

```
R2_ACCOUNT_ID=
R2_ACCESS_KEY_ID=
R2_SECRET_ACCESS_KEY=
```

Ingat [materi 02](../materi/02-api-key-dan-env.md): token ini bisa membaca dan menghapus isi bucket.

## D. Backup database VPS ke R2 (otomatis tiap malam)

Kenapa: VPS bisa rusak, salah hapus, atau kena masalah provider. Backup di tempat terpisah (R2) artinya data tetap selamat walau VPS-nya hilang.

Di VPS, agent pasang **rclone** (alat sinkron file ke penyimpanan cloud):

```bash
apt install -y rclone
rclone config create r2 s3 provider=Cloudflare \
  access_key_id="$R2_ACCESS_KEY_ID" secret_access_key="$R2_SECRET_ACCESS_KEY" \
  endpoint="https://$R2_ACCOUNT_ID.r2.cloudflarestorage.com" acl=private
```

Script backup `/root/scripts/backup-db.sh` (agent sesuaikan dengan database yang dipakai):

```bash
#!/usr/bin/env bash
set -e
TGL=$(date +%F)
mkdir -p /root/backup
# MySQL/MariaDB:
mysqldump --single-transaction nama_db | gzip > /root/backup/nama_db-$TGL.sql.gz
# PostgreSQL:  pg_dump nama_db | gzip > /root/backup/nama_db-$TGL.sql.gz
# SQLite:      sqlite3 /path/data.sqlite ".backup /root/backup/data-$TGL.sqlite"
rclone copy /root/backup r2:backup-db/$(hostname)/
find /root/backup -type f -mtime +7 -delete     # salinan lokal cukup 7 hari
```

Jadwalkan jam 03.00 WIB tiap hari:

```bash
chmod +x /root/scripts/backup-db.sh
(crontab -l 2>/dev/null; echo "0 3 * * * /root/scripts/backup-db.sh >> /var/log/backup-db.log 2>&1") | crontab -
```

Batasi umur backup di R2 supaya tidak menumpuk (contoh 30 hari):

```bash
wrangler r2 bucket lifecycle add backup-db hapus-30-hari --expire-days 30
```

**Backup yang belum pernah di-restore belum terbukti.** Sebulan sekali minta agent: "download backup terbaru dari R2, restore ke database baru bernama `tes_restore` di laptop atau VPS, cek jumlah baris tabel utama". Restore ke database baru, jangan ke database produksi.

## E. Media sementara untuk upload ke Repliz (auto-hapus)

Kenapa: saat agent menjadwalkan posting lewat API Repliz, gambar atau video perlu punya **URL publik** yang bisa diambil Repliz. Daripada menumpuk di VPS atau Drive, taruh di bucket R2 yang menghapus isinya sendiri setelah beberapa hari.

1. Aktifkan URL publik dan aturan hapus otomatis:
   ```bash
   wrangler r2 bucket dev-url enable media-sementara
   wrangler r2 bucket lifecycle add media-sementara hapus-7-hari --expire-days 7
   wrangler r2 bucket dev-url get media-sementara      # catat URL publiknya (https://pub-xxxx.r2.dev)
   ```
   URL `r2.dev` cocok untuk ini karena isinya sementara. Untuk media permanen, sambungkan domain sendiri (`wrangler r2 bucket domain add`).
2. Simpan URL publik ke `.env` sebagai `R2_MEDIA_PUBLIC_URL`.
3. Alur agent saat menjadwalkan posting:
   ```bash
   wrangler r2 object put media-sementara/2026-11-04/post-1.mp4 --file ./render/post-1.mp4 --remote
   # URL untuk Repliz: $R2_MEDIA_PUBLIC_URL/2026-11-04/post-1.mp4
   ```
   lalu panggil API Repliz dengan URL itu (modul 11).
4. Jadwalkan posting paling lambat 5 hari ke depan supaya file belum terhapus saat Repliz mengambilnya. Kalau perlu lebih lama, naikkan `--expire-days`.

Nama file jangan mengandung data pribadi, karena URL `r2.dev` bisa dibuka siapa pun yang tahu alamatnya.

## Verifikasi

- [ ] `dig NS domainkamu.com +short` menampilkan nameserver Cloudflare.
- [ ] Email ke `hello@domainkamu.com` masuk Gmail.
- [ ] `wrangler r2 bucket list` menampilkan `backup-db` dan `media-sementara`.
- [ ] (VPS) `rclone ls r2:backup-db` menampilkan file backup setelah script dijalankan sekali manual.
- [ ] File tes di `media-sementara` bisa dibuka lewat URL `r2.dev` dari HP.
- [ ] `.env` berisi kredensial R2 dan tidak muncul di `git status`.

## Kalau gagal

- Domain tidak aktif setelah 24 jam: cek nameserver di Hostinger sudah persis sama (tanpa titik di akhir, tanpa salah ketik).
- Situs error "too many redirects" setelah pindah ke Cloudflare: di Cloudflare, **SSL/TLS**, ubah mode ke **Full (strict)**.
- Email tidak masuk: cek folder Spam, dan pastikan alamat tujuan sudah diverifikasi (status Verified).
- `rclone` error `403`: token R2 tidak punya izin ke bucket itu, bikin ulang dengan izin Object Read & Write.

## Lanjut

Modul [10 API AI, router, agent 24/7](10-ai-api-routing.md).
