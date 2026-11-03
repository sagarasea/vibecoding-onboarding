# Materi 03: Deploy, hosting, domain

> Muncul di: **modul 09**, sebelum import project ke Vercel.
> Agent: jelaskan alur "dari laptop ke internet" di bawah, lalu tunjukkan langsung di dashboard Vercel mana production dan mana preview.

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

## Cek pemahaman

Agent tanyakan satu: "Klien minta lihat fitur baru dulu sebelum tayang ke semua pengguna. Kamu kirim link yang mana, dan dari mana link itu muncul?"

Jawaban yang diharapkan: link **preview** dari PR/branch fitur itu, yang dibuat otomatis oleh Vercel saat branch di-push. Bukan link production.
