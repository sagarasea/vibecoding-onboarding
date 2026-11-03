# 11 Automation: posting, balas komentar, dan workflow

**Tujuan:** kamu tahu tool pihak ketiga yang dipakai mentor untuk automation, dan bisa menyambungkannya ke agent.

**Waktu:** 20 menit. Opsional untuk yang belum butuh.

## Tool yang dipakai

| Tool | Untuk | Platform | Biaya | Akses agent |
|---|---|---|---|---|
| [Repliz](https://repliz.com) | jadwal posting, auto-reply komentar dan DM, hapus spam | Facebook, Instagram, Threads, TikTok, YouTube, LinkedIn, X, WhatsApp, Telegram, Pinterest, Shopee | Free 1 akun. Standard Rp18rb, Premium Rp29rb (ada jadwal posting), Gold Rp49rb (API penuh) per bulan, bayar sekali tanpa perpanjangan otomatis | Public API, webhook, node n8n, MCP `https://mcp.repliz.com/mcp` |
| [Buffer](https://buffer.com) | jadwal posting | mentor pakai khusus X/Twitter | Free 3 channel, 10 post terjadwal per channel. Essentials USD 5 per channel/bulan | API (1 key di paket free) |
| [n8n](https://n8n.io) | workflow otomatis (kalau ada X, lakukan Y), self-host | ratusan integrasi | gratis kalau self-host di VPS. Sumopod punya paket n8n siap pakai | API dan webhook |
| Make / Zapier | sama seperti n8n, versi cloud | | Make free 1.000 kredit/bulan, Zapier free 100 task/bulan | |

Kenapa Repliz: buatan Indonesia, bayar rupiah, murah, dan satu dashboard untuk hampir semua platform yang dipakai brand lokal. Buffer dipakai untuk X karena integrasinya lebih stabil.

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
