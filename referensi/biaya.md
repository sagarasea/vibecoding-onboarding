# Biaya per jalur

Dicek 2026-11-04. Harga dalam USD dikonversi kasar dengan kurs sekitar Rp16.500. Harga bisa berubah, cek link sebelum bayar.

## Jalur Gratis (Rp0)

| Kebutuhan | Pakai | Batasan |
|---|---|---|
| Agent coding | opencode + model gratis Zen, atau 9router dengan provider gratis | kuota dan model gratis berubah-ubah, sebagian model gratis memakai data untuk training |
| Model API | Google AI Studio (Gemini), OpenRouter `:free`, Groq | OpenRouter free 50 request/hari, Gemini free tier datanya dipakai Google |
| Hosting | Vercel Hobby, Cloudflare Pages/Workers | Vercel Hobby non-komersial |
| Database | Supabase Free | 2 project, 500 MB, pause setelah seminggu tidak aktif |
| Domain | `*.vercel.app`, `*.pages.dev` | |
| Automation | Repliz Free (1 akun), Buffer Free (3 channel) | |

Claude Code **tidak** tersedia di paket Claude Free.

## Jalur Hemat (sekitar Rp330rb/bulan)

| Kebutuhan | Pakai | Biaya |
|---|---|---|
| Agent coding | Claude Pro (termasuk Claude Code) | USD 20/bulan, atau USD 17/bulan kalau tahunan |
| Agent kedua (opsional) | ChatGPT Plus untuk Codex | USD 20/bulan |
| Domain | Hostinger `.com` / `.id` | sekitar Rp110rb (promo tahun pertama) / Rp210rb per tahun |
| Sisanya | sama dengan jalur Gratis | Rp0 |

## Jalur Builder (sekitar Rp500rb-3,5jt/bulan)

| Kebutuhan | Pakai | Biaya |
|---|---|---|
| Agent coding | Claude Pro, Max (USD 100), atau Ultra (USD 200) | sesuai intensitas |
| Token untuk agent dan aplikasi | TokenomixAI | paket prepaid mulai puluhan ribu rupiah, lihat tokenomixai.com |
| Gemini | Google AI Pro, mentor beli paket 18 bulan lewat AAL | resmi Rp309rb/bulan |
| VPS | Sumopod (2 vCPU / 2-4 GB) | perkiraan Rp40-100rb/bulan, cek sumopod.com |
| Hosting komersial | Vercel Pro atau Cloudflare | Vercel Pro USD 20/bulan, Cloudflare Workers Paid USD 5/bulan |
| Database produksi | Supabase Pro | USD 25/bulan |
| Automation | Repliz Premium/Gold | Rp29rb / Rp49rb per bulan |
| Referensi desain | Mobbin Pro, 21st.dev Builder | sekitar USD 10 dan USD 6 per bulan (tahunan) |

## Jalur Company

| Kebutuhan | Pakai |
|---|---|
| Tim developer | Claude Team (USD 25/seat/bulan Standard, USD 125 Premium) |
| Inference produk dengan data pelanggan | Worg (getworg.com): mesin lokal di Indonesia, prompt dan output tidak disimpan, ZDR dengan DPA tertulis, faktur PPN |
| On-premise penuh | Ollama di server kantor + 9router |

## Lisensi yang perlu diingat

- Remotion: gratis untuk individu dan perusahaan sampai 3 karyawan. Di atas itu butuh Company License.
- HyperFrames: Apache-2.0, bebas dipakai komersial.
- Vercel Hobby: non-komersial.
