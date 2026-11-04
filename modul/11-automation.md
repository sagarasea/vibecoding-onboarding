# 11 Automation: posting, balas komentar, dan workflow

**Tujuan:** kamu tahu tool pihak ketiga yang dipakai mentor untuk automation, dan bisa menyambungkannya ke agent.

**Waktu:** 20 menit. Opsional untuk yang belum butuh.

## Tool yang dipakai

| Tool | Untuk | Platform | Biaya | Akses agent |
|---|---|---|---|---|
| [Repliz](https://repliz.com) | jadwal posting, auto-reply komentar dan DM, hapus spam | Facebook, Instagram, Threads, TikTok, YouTube, LinkedIn, X, WhatsApp, Telegram, Pinterest, Shopee | Free 1 akun. Standard Rp18rb, Premium Rp29rb (ada jadwal posting), Gold Rp49rb (API penuh) per bulan, bayar sekali tanpa perpanjangan otomatis | Public API, webhook, node n8n, MCP `https://mcp.repliz.com/mcp` |
| [Buffer](https://buffer.com) | jadwal posting | mentor pakai khusus X/Twitter | Free 3 channel, 10 post terjadwal per channel. Essentials USD 5 per channel/bulan | API (1 key di paket free) |
| [n8n](https://n8n.io) | workflow otomatis (kalau ada X, lakukan Y), self-host | ratusan integrasi | gratis kalau self-host di VPS. Sumopod punya paket n8n siap pakai | API dan webhook |
| [Fonnte](https://fonnte.com) | kirim pesan WhatsApp otomatis: notifikasi, pengingat, chatbot, broadcast | WhatsApp | Free 1.000 pesan/bulan (teks), paket berbayar per bulan | API dan webhook, docs: https://docs.fonnte.com |
| Make / Zapier | sama seperti n8n, versi cloud | | Make free 1.000 kredit/bulan, Zapier free 100 task/bulan | |

Kenapa WhatsApp: klien dan pelanggan di Indonesia lebih banyak membaca WhatsApp daripada email atau Telegram. Fonnte memakai **API WhatsApp tidak resmi** (menyambungkan nomor lewat scan QR seperti WhatsApp Web). Murah dan cepat, tapi nomor bisa diblokir WhatsApp kalau dipakai spam. Pakai nomor khusus (bukan nomor pribadi), kirim hanya ke orang yang setuju menerima, dan untuk skala besar pertimbangkan WhatsApp Business Platform resmi dari Meta.

Kenapa Repliz: buatan Indonesia, bayar rupiah, murah, dan satu dashboard untuk hampir semua platform yang dipakai brand lokal. Buffer dipakai untuk X karena integrasinya lebih stabil.

### Produk berbayar dari mentor (opsional)

Mentor punya **script AI agent auto reply** yang balasannya sudah terasa seperti manusia, dijual **Rp3.000.000** (private, hubungi mentor). Cocok kalau butuh auto reply yang siap pakai tanpa membangun dan menyetel sendiri. Tanpa produk ini, kamu tetap bisa membangun auto reply sendiri dengan Repliz, Fonnte, atau Hermes di modul ini dan modul 10.

Untuk bahan posting, mentor juga menjual **repo carousel generator** seharga **Rp2.500.000** (private). Hasil carousel-nya bisa langsung dijadwalkan lewat Repliz.

## Pola yang dipakai mentor

```
Agent (Hermes / Claude Code) bikin draft konten
   → kamu review di Telegram atau di file
   → agent kirim ke Repliz / Buffer lewat API untuk dijadwalkan
   → Repliz membalas komentar dengan aturan auto-reply
```

Agent tidak memposting langsung tanpa review. Draft dulu, kamu setujui, baru dijadwalkan.

## Langkah: sambungkan Repliz ke agent

Key Repliz bisa dipakai untuk memposting atas nama brand. Perlakukan sesuai [materi 02](../materi/02-api-key-dan-env.md).

1. Daftar di https://repliz.com, sambungkan akun sosmed.
2. Ambil **Access Key** dan **Secret Key** di dashboard (paket yang punya akses API). Orangnya yang menyalin ke `.env`:
   ```
   REPLIZ_ACCESS_KEY=...
   REPLIZ_SECRET_KEY=...
   ```
3. Baca dokumentasi di https://docs.repliz.com untuk cara autentikasi MCP atau API, lalu minta agent membuat script kecil "jadwalkan post ini ke akun X jam Y" yang membaca key dari `.env`.
4. Tes dengan satu post ke akun pribadi, jadwalkan 1 jam ke depan, cek muncul di dashboard Repliz.
5. Gambar dan video untuk posting: agent upload dulu ke bucket R2 `media-sementara` yang menghapus isinya otomatis, lalu kirim URL publiknya ke Repliz (modul 09b bagian E).

## Langkah: kirim WhatsApp lewat Fonnte (opsional)

1. Agent buka `open "https://fonnte.com"`, orangnya daftar, tambahkan device, scan QR dengan WhatsApp di HP (pakai nomor khusus).
2. Salin token device ke `.env` sebagai `FONNTE_TOKEN`.
3. Minta agent: "bikin script kirim WhatsApp ke nomorku sendiri lewat Fonnte, baca token dari .env". Tes ke nomor sendiri dulu.

## Langkah: n8n di VPS (opsional)

Cara termudah: paket n8n di Sumopod. Kalau mau di VPS sendiri dengan Docker:

```bash
docker volume create n8n_data
docker run -d --name n8n -p 5678:5678 -v n8n_data:/home/node/.n8n -e TZ=Asia/Jakarta n8nio/n8n
```

Pasang di belakang nginx + Cloudflare Access (modul 09). Jangan buka port 5678 langsung ke internet.

## Verifikasi

- Satu post terjadwal muncul di dashboard Repliz atau Buffer.
- Key tersimpan di `.env`, dan `git status` tidak menampilkan `.env`.

## Lanjut

Modul [12 Jalur minat](12-jalur-minat.md).
