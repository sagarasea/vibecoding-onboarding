# Materi 03: Deploy, hosting, domain

> Muncul di: **modul 09**, sebelum import project ke Vercel.
> Agent: jelaskan alur "dari laptop ke internet" di bawah, lalu tunjukkan langsung di dashboard Vercel mana production dan mana preview.

**Setelah ini kamu bisa:**

- menjelaskan beda localhost, preview, dan production
- tahu kenapa environment variable perlu diisi juga di Vercel
- tahu cara balik ke versi sebelumnya kalau deploy merusak

## Gambaran besar

Selama ini aplikasimu jalan di `localhost`: alamat yang hanya bisa dibuka dari laptopmu sendiri. **Deploy** artinya menaruh aplikasi di komputer lain yang menyala 24 jam dan bisa diakses siapa pun lewat internet.

```
laptop ──commit──> git ──push──> GitHub ──otomatis──> Vercel (build) ──> https://nama.vercel.app
```

Analogi desainer: `localhost` itu file di laptopmu, deploy itu "publish" ke link yang bisa dibuka klien.

## Istilah

| Istilah | Artinya |
|---|---|
| **localhost** | alamat aplikasi di laptopmu sendiri, contoh `http://localhost:3000`. Tidak bisa dibuka orang lain. |
| **dev server** | aplikasi yang jalan di laptop untuk pengembangan (`npm run dev`), otomatis reload saat file berubah. |
| **build** | proses mengubah kode jadi versi siap tayang yang cepat (`npm run build`). Kalau build gagal, deploy gagal. |
| **hosting** | komputer di internet yang menjalankan aplikasimu (Vercel, Cloudflare, VPS). |
| **deploy** | proses build + menaruh hasilnya di hosting. |
| **production** | versi yang dibuka pengguna asli. Di Vercel: hasil dari branch `main`. |
| **preview** | versi uji dari branch atau PR, punya link sendiri. Untuk dicek dulu sebelum masuk production. |
| **environment variable** | nilai `.env` versi hosting, diisi di dashboard (materi 02). |
| **domain** | nama alamat (`namakamu.com`), dibeli per tahun. |
| **DNS** | buku telepon internet: menghubungkan nama domain ke alamat server. Diatur di Cloudflare atau penyedia domain. |
| **rollback** | kembali ke deploy sebelumnya kalau yang baru rusak. Di Vercel: Deployments, pilih yang lama, **Promote to Production**. |
| **VPS** | komputer sewaan yang kamu atur sendiri penuh. Lebih fleksibel, lebih banyak tanggung jawab. |

## Kenapa deploy-nya otomatis dari GitHub

Karena Vercel tersambung ke repo:

- push ke branch apa pun → Vercel bikin **preview** dengan link unik,
- merge ke `main` → Vercel deploy ke **production**.

Jadi kamu tidak pernah "upload file". Alurnya selalu: commit, push, (PR, cek preview), merge. Ini juga kenapa materi 01 penting.

## Kalau deploy gagal

1. Buka Vercel, Deployments, klik yang merah, baca **Build Logs**.
2. Salin bagian error ke agent: "deploy gagal dengan error ini, perbaiki". Atau sambungkan MCP Vercel supaya agent membaca log sendiri.
3. Penyebab paling sering: environment variable belum diisi di Vercel, atau `npm run build` memang gagal di laptop juga. Biasakan minta agent menjalankan `npm run build` sebelum push.

## Coba sendiri

Buka dashboard Vercel project latihan. Tunjukkan ke agent mana deployment Production dan mana Preview, lalu buka keduanya di HP.

## Salah kaprah yang sering muncul

- "Klien bisa membuka localhost-ku." localhost hanya ada di laptopmu. Klien butuh link preview atau production (atau cloudflared untuk sementara, materi 07).
- "`.env` di laptop ikut terkirim ke Vercel." Tidak, karena `.env` tidak di-commit. Isi environment variable di dashboard Vercel.
- "Beli domain berarti sudah punya hosting." Domain cuma alamat. Hosting tempat aplikasinya jalan. DNS yang menyambungkan keduanya.

## Cek pemahaman

Agent tanyakan satu per satu.

1. "Klien minta lihat fitur baru dulu sebelum tayang ke semua pengguna. Kamu kirim link yang mana, dan dari mana link itu muncul?"

Jawaban yang diharapkan: link **preview** dari PR/branch fitur itu, yang dibuat otomatis oleh Vercel saat branch di-push. Bukan link production.

2. "Deploy terbaru bikin halaman utama error, dan klien sedang memakainya. Apa langkah tercepat?"

Jawaban yang diharapkan: rollback: di Vercel, Deployments, pilih deploy sebelumnya yang sehat, Promote to Production. Setelah aman, baru perbaiki di branch.

Kalau jawabannya meleset, jelaskan ulang bagian itu dengan analogi lain, lalu tanya lagi dengan skenario yang sedikit berbeda.

## Kartu contekan

- localhost: hanya di laptopmu.
- preview: link per branch untuk dicek dulu.
- production: yang dipakai orang.
- env var diisi di dashboard hosting, bukan ikut di-commit.
- Rusak setelah deploy: rollback dulu, perbaiki kemudian.
