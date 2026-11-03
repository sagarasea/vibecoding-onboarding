# 09 Deploy: dari laptop ke internet

**Tujuan:** aplikasi kamu punya link publik, dan kamu tahu kapan cukup pakai layanan gratis dan kapan perlu VPS.

**Waktu:** 20 menit (jalur gratis), 1-2 jam (VPS).

## Pilih jalur

| | Jalur gratis | Jalur berbayar (VPS) |
|---|---|---|
| Cocok untuk | web app, landing page, dashboard, prototype untuk klien | agent 24 jam (Hermes), bot, backend yang jalan terus, render video, banyak project dalam satu server |
| Hosting | Vercel (Next.js), Cloudflare Pages/Workers | VPS di Sumopod (Jakarta/Singapura) |
| Database | Supabase Free | Supabase, atau database di VPS |
| Domain | `nama.vercel.app` gratis, atau domain sendiri | domain sendiri (Hostinger) |
| DNS | Vercel atau Cloudflare | Cloudflare |
| Biaya | Rp0 | VPS mulai puluhan ribu per bulan + domain sekitar Rp110-250rb per tahun |

Batasan penting jalur gratis:
- **Vercel Hobby hanya untuk pemakaian pribadi/non-komersial.** Untuk aplikasi yang dipakai klien secara komersial, pakai Vercel Pro (USD 20/bulan) atau Cloudflare (Workers gratis 100rb request per hari).
- **Supabase Free di-pause kalau tidak dipakai seminggu.** Cocok untuk belajar dan prototype. Untuk produksi, Pro USD 25/bulan.

## A. Jalur gratis: GitHub → Vercel

1. Pastikan project sudah di GitHub (modul 05).
2. Buka https://vercel.com/new, pilih repo, klik **Import**. Vercel mendeteksi Next.js/Astro otomatis.
3. Isi **Environment Variables** (nilai dari `.env` kamu, misalnya `NEXT_PUBLIC_SUPABASE_URL`). Orangnya yang tempel nilai di dashboard, bukan di chat.
4. Klik **Deploy**. Selesai dalam 1-2 menit, dapat link `nama.vercel.app`.
5. Mulai sekarang setiap `git push` ke `main` otomatis deploy. Setiap pull request dapat link preview sendiri.

Lewat terminal (alternatif): `vercel login`, lalu `vercel` di folder project, lalu `vercel --prod`.

### Supabase (database + login)

1. Buat project di https://supabase.com/dashboard, region **Southeast Asia (Singapore)**.
2. Ambil URL project dan anon key dari Project Settings, API. Masukkan ke `.env.local` dan ke environment variable Vercel.
3. Sambungkan MCP Supabase (modul 07) supaya agent bisa bikin tabel dan cek data. Mulai dengan `read_only=true`.

## B. Domain sendiri

1. Beli domain di https://www.hostinger.com/id/domain-murah (`.com` sekitar Rp110rb tahun pertama saat promo, `.id` sekitar Rp210rb). Cek harga perpanjangan sebelum beli.
2. Disarankan: pindahkan DNS ke Cloudflare (gratis). Tambah situs di https://dash.cloudflare.com, lalu ganti nameserver di Hostinger ke dua nameserver dari Cloudflare.
3. Di Vercel: Project, Settings, Domains, tambahkan domain. Ikuti record DNS yang diminta (biasanya `A` atau `CNAME`), masukkan di Cloudflare.

## C. Jalur berbayar: VPS

Pakai VPS kalau butuh sesuatu yang jalan terus: Hermes Agent, bot Telegram/WhatsApp, cron job, render video, atau banyak aplikasi dalam satu server.

1. Sewa VPS di https://sumopod.com. Untuk mulai: 2 vCPU, 2-4 GB RAM, Ubuntu atau Debian.
2. Login pertama (orangnya yang memasukkan password dari email Sumopod):
   ```bash
   ssh root@IP_VPS
   ```
3. Minta agent memandu hardening dasar: user non-root, login pakai SSH key, firewall (`ufw`) hanya buka port 22, 80, 443.
4. Install Node, git, dan PM2 (menjaga aplikasi tetap hidup):
   ```bash
   curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && apt install -y nodejs git nginx
   npm install -g pm2
   ```
5. Deploy aplikasi: `git clone` repo, `npm install`, `npm run build`, `pm2 start npm --name nama-app -- start`, `pm2 save`, `pm2 startup`.
6. Pasang nginx sebagai reverse proxy, dan Cloudflare di depannya untuk SSL.

### Aturan dari pengalaman mentor (wajib)

- **Setiap hostname baru wajib punya vhost nginx sendiri, dipasang sebelum record DNS dibuat.** Tanpa vhost, request jatuh ke vhost default dan bisa menampilkan aplikasi lain, termasuk panel admin. Ini pernah terjadi.
- **Pasang catch-all** yang menolak host tak dikenal, supaya subdomain asal-asalan tidak menampilkan apa pun.
- **Halaman login, admin, dan internal** dilindungi Cloudflare Access (login One-time PIN ke email kamu), per hostname.
- **Urutannya:** vhost → `nginx -t` → reload → record DNS → cek dari luar bahwa host itu benar dan host acak tidak menampilkan apa pun.
- **Jangan simpan rahasia di repo.** `.env` di VPS dibuat manual, permission `600`.

## Verifikasi

- Link `*.vercel.app` (atau domain kamu) terbuka dari HP pakai data seluler, bukan Wi-Fi rumah.
- `git push` kecil (ubah satu teks) muncul di link dalam 2 menit.
- (VPS) `pm2 status` menunjukkan aplikasi `online`, dan host acak di domainmu tidak menampilkan aplikasi.

## Lanjut

Modul [10 API AI, router, agent 24/7](10-ai-api-routing.md).
