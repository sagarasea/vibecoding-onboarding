# 00 Mulai di sini

**Tujuan:** agent kenal kamu, kamu tahu mau lewat jalur mana, dan `PROGRESS.md` terisi.

**Waktu:** 10 menit.

## Langkah 1: kenalan (agent tanya, kamu jawab)

Agent, ajukan empat pertanyaan ini dalam satu pesan:

1. Sudah punya apa saja? Claude Pro/Max, Claude Code, VS Code, akun GitHub? Pernah ngoding atau ikut kelas vibe coding sebelumnya?
2. Mau fokus ngapain, dan ada bottleneck di kerjaan yang mau dioptimalkan pakai AI?
3. Project pertama mau bikin apa? (contoh: aplikasi internal buat operasional tim klien, clipper konten podcast, SaaS, AI agent kayak Hermes)
4. Dalam sehari paling banyak ngapain, pakai tools atau aplikasi apa?

Jawaban ditulis ke bagian Profil di `PROGRESS.md`.

## Langkah 2: pilih jalur biaya

Semua jalur bisa naik kelas belakangan. Mulai dari yang paling murah yang masih masuk akal untuk project kamu.

| Jalur | Untuk siapa | Biaya per bulan (perkiraan) | Isi |
|---|---|---|---|
| **Gratis** | Coba-coba dulu, belum yakin | Rp0 | opencode + model gratis (lewat 9router atau model free bawaan opencode), Gemini API gratis dari Google AI Studio, deploy ke Vercel Hobby + Supabase Free, domain `*.vercel.app` |
| **Hemat** | Serius belajar, project kecil | sekitar Rp330rb (Claude Pro USD 20) + domain sekitar Rp150-250rb per tahun | Claude Pro (sudah termasuk Claude Code), Vercel + Supabase free, domain di Hostinger |
| **Builder** | Mau bikin produk/SaaS dan agent yang jalan 24 jam | Claude Max (USD 100 atau 200) atau token dari TokenomixAI, VPS Sumopod, domain | Semua di atas + VPS sendiri untuk Hermes Agent + 9router, automation |
| **Company** | Perusahaan, data sensitif, butuh mesin lokal dan Zero Data Retention | Sesuai penawaran | Worg (getworg.com): mesin lokal dan ZDR. Lihat `modul/10-ai-api-routing.md` |

Harga di atas perkiraan dan bisa berubah. Detail dan link ada di [`referensi/biaya.md`](../referensi/biaya.md).

## Langkah 3: pilih minat

Pilih satu atau lebih. Ini menentukan skill, plugin, dan tools opsional yang diinstall di modul 07 dan 12.

- **SaaS dan web app:** dashboard, aplikasi internal, login, database, pembayaran.
- **AI agent dan automation:** Hermes, bot Telegram/WhatsApp, posting otomatis, workflow n8n.
- **Video dan konten:** clipper podcast, reels, motion graphic (HyperFrames, Remotion, ffmpeg, yt-dlp).
- **Desain dan landing page:** situs portofolio, landing page, design system, Figma ke kode.

## Langkah 4: cek spesifikasi mesin (agent jalankan sendiri)

macOS:
```bash
sysctl -n machdep.cpu.brand_string; echo "RAM: $(( $(sysctl -n hw.memsize) / 1073741824 )) GB"; df -h / | tail -1
```

Windows (PowerShell):
```powershell
Get-CimInstance Win32_Processor | Select Name; "RAM: {0} GB" -f [math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory/1GB); Get-CimInstance Win32_VideoController | Select Name; Get-PSDrive C
```

Catat di `PROGRESS.md`. Kalau Apple Silicon dengan RAM 16 GB ke atas, atau PC dengan GPU terpisah dan RAM 16 GB ke atas, tawarkan **jalur laptop kuat** (ArtCraft suite: FigCraft, EffectCraft, FilmCraft, dll, modul 12 bagian E) dan model lokal Ollama. Kalau ruang disk kosong di bawah 20 GB, bilang dulu sebelum install jalur video atau Docker.

## Verifikasi

- `PROGRESS.md` ada dan bagian Profil terisi (jalur dan minat tidak kosong).

## Lanjut

Modul [01 Akun](01-akun.md).
