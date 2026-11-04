# 10 API AI, router, dan agent 24 jam

**Tujuan:** kamu tahu cara dapat akses model AI paling hemat untuk kebutuhanmu, bisa merutekan banyak model lewat satu endpoint (9router), dan bisa menjalankan agent Hermes yang tetap hidup walau laptop mati.

**Waktu:** 30-60 menit. Bagian D dan E opsional untuk jalur Gratis/Hemat.

> Modul ini banyak memakai API key (TokenomixAI, 9router, token bot Telegram). Agent ingatkan lagi [materi 02: API key dan .env](../materi/02-api-key-dan-env.md) sebelum key pertama dibuat, terutama bagian "Kalau key terlanjur bocor".

## A. Langganan atau token: mana yang dibeli

| Pilihan | Bentuk | Cocok untuk | Catatan |
|---|---|---|---|
| **Claude Pro / Max / Ultra** | langganan bulanan (USD 20 / 100 / 200) | coding harian di Claude Code | Paling enak untuk coding. Ada batas pemakaian per 5 jam. |
| **ChatGPT Plus / Pro** | langganan bulanan (Plus USD 20) | Codex: second opinion, review kode, cadangan saat kuota Claude habis | Codex ikut di paket ChatGPT, tidak ada langganan terpisah. Paket Free terbatas. |
| **Google AI Pro (Gemini)** | langganan | Gemini app, Gemini CLI, kuota Gemini lebih besar | Harga resmi Rp309rb/bulan. Mentor biasa beli paket **18 bulan lewat AAL** (tanya mentor link-nya). Paket 18 bulan yang beredar umumnya promo operator luar negeri yang dijual ulang, jadi bisa dicabut sewaktu-waktu. Beli yang murah, jangan jadikan satu-satunya andalan. |
| **TokenomixAI** | token prepaid, bayar QRIS | agent dan aplikasi yang butuh API (Hermes, opencode, aplikasi kamu sendiri) | Satu API key untuk banyak model (GLM, DeepSeek, Kimi, dll), endpoint OpenAI-compatible `https://api.tokenomixai.com/v1`, tidak ada limit 5 jam, sisa token tidak hangus. Harga paket lihat di https://tokenomixai.com. |
| **Worg** | saldo prepaid (USD, top-up rupiah) | **skala perusahaan**: data sensitif, butuh inference di mesin lokal Indonesia dan Zero Data Retention | Lihat bagian F. |
| **Gratis** | kuota gratis | belajar, prototype | Google AI Studio (Gemini API gratis, data dipakai Google untuk perbaikan produk), OpenRouter model `:free` (50 request/hari), model gratis opencode Zen, Groq. |

Rekomendasi kombinasi:
- **Hemat:** Claude Pro untuk coding + Gemini gratis/AI Pro untuk riset dan konten.
- **Builder:** Claude Pro/Max untuk coding + TokenomixAI untuk agent dan aplikasi (lewat 9router) + VPS.
- **Company:** Claude Team untuk tim developer + Worg untuk inference produk yang menyentuh data pelanggan.

## B. opencode: agent coding dengan model gratis

[opencode](https://opencode.ai) mirip Claude Code tapi bisa dipakai dengan model apa saja, termasuk yang gratis. Sudah terpasang di modul 04 (`opencode --version`).

Jalankan `opencode` di folder project. Untuk lihat model gratis:

```bash
opencode models opencode | grep -- -free
```

Contoh model gratis (berubah-ubah, cek daftar terbaru di https://opencode.ai/docs/zen/): DeepSeek V4.1 Flash Free, MiMo V2.6 Flash Free, GLM Flash Free. Perhatikan kebijakan data: sebagian model gratis boleh dipakai untuk training. Jangan kirim data klien ke model gratis.

opencode membaca `AGENTS.md`, jadi aturan project kamu tetap berlaku.

## C. 9router: satu endpoint untuk banyak model

[9router](https://github.com/decolua/9router) adalah proxy dan dashboard lokal. Kamu mendaftarkan banyak provider (langganan, token murah, dan yang gratis), lalu aplikasi atau agent cukup memanggil satu alamat. Kalau satu provider habis kuota atau error, 9router pindah ke berikutnya (fallback).

Install dan jalankan:

```bash
npm install -g 9router
9router
```

Dashboard: http://localhost:20128. Endpoint untuk aplikasi: `http://localhost:20128/v1` (format OpenAI-compatible).

Langkah di dashboard:
1. Tambah provider: TokenomixAI (base URL `https://api.tokenomixai.com/v1` + API key kamu), OpenRouter, opencode free, Gemini, dll.
2. Buat **combo**: nama model virtual berisi urutan model fallback. Contoh yang dipakai mentor:
   - `code`: model kuat untuk coding.
   - `cheap`: model murah untuk tugas ringan.
   - `autoclip`: model vision untuk memilih frame video.
3. Aplikasi memanggil nama combo sebagai nama model.

Menyambungkan opencode ke 9router (`~/.config/opencode/opencode.json`):

```json
{
  "provider": {
    "9router": {
      "npm": "@ai-sdk/openai-compatible",
      "options": { "baseURL": "http://localhost:20128/v1", "apiKey": "{env:ROUTER_API_KEY}" },
      "models": { "code": {}, "cheap": {} }
    }
  },
  "model": "9router/code"
}
```

Aplikasi kamu sendiri cukup pakai tiga variabel di `.env`: `ROUTER_BASE_URL`, `ROUTER_API_KEY`, `ROUTER_MODEL`, lalu panggil dengan SDK OpenAI.

Dua peringatan:
- Anthropic **tidak mendukung** Claude Code dipakai dengan model non-Claude lewat gateway. Pakai 9router untuk opencode, Hermes, dan aplikasi kamu. Claude Code tetap pakai langganan Claude.
- 9router bisa mem-proxy login langganan (Claude, dll). Cek syarat layanan masing-masing provider sebelum melakukannya, akun bisa diblokir.

Di VPS, mentor menjalankan 9router dengan PM2 dan menaruhnya di belakang Cloudflare (dashboard dan `/api` dilindungi Cloudflare Access). Jangan buka port dashboard 9router ke internet tanpa proteksi.

## D. Hermes Agent: asisten yang bisa kamu chat dari Telegram

[Hermes Agent](https://github.com/NousResearch/hermes-agent) dari Nous Research adalah agent serbaguna: bisa menjalankan perintah, punya memori, skill, cron job, dan bisa diajak ngobrol lewat Telegram atau WhatsApp.

### Install di laptop dulu

```bash
curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash          # macOS / Linux
iex (irm https://hermes-agent.nousresearch.com/install.ps1)                  # Windows PowerShell
```

Lalu:

```bash
hermes setup        # wizard awal
hermes doctor       # cek kesehatan
hermes              # mulai ngobrol di terminal
```

### Sambungkan ke 9router

Jalankan `hermes model`, pilih **custom provider** (OpenAI-compatible), isi base URL `http://localhost:20128/v1` (atau alamat 9router di VPS kamu), API key dari dashboard 9router, dan nama combo sebagai model default. Hasilnya di `~/.hermes/config.yaml` kurang lebih:

```yaml
model:
  provider: custom
  base_url: http://localhost:20128/v1
  default: code
```

API key disimpan di `~/.hermes/.env`, bukan di `config.yaml`.

### Telegram

1. Di Telegram, chat **@BotFather**, kirim `/newbot`, simpan token bot.
2. Chat **@userinfobot** untuk tahu user ID kamu (angka).
3. Jalankan `hermes gateway setup`, masukkan token dan user ID. Atau tulis `TELEGRAM_BOT_TOKEN` dan `TELEGRAM_ALLOWED_USERS` di `~/.hermes/.env`.
4. Jalankan `hermes gateway`, lalu chat bot kamu.

`TELEGRAM_ALLOWED_USERS` wajib diisi. Tanpa itu, siapa pun yang menemukan bot kamu bisa menyuruh agent menjalankan perintah di komputermu.

### Grup "server" dengan topik per project (pola mentor)

Daripada semua obrolan dengan agent bercampur di satu chat, bikin satu grup Telegram sebagai "server", lalu pisahkan per topik: satu topik untuk operasional, satu untuk log otomatis, satu per project.

1. **Bikin bot** di **@BotFather**: `/newbot`, kasih nama dan username (harus berakhiran `bot`), simpan token ke `~/.hermes/.env` sebagai `TELEGRAM_BOT_TOKEN` (orangnya yang menempel, agent bukakan file-nya).
2. **Izinkan bot membaca pesan grup**: di @BotFather kirim `/setprivacy`, pilih bot-nya, pilih **Disable**. Tanpa ini bot hanya membaca pesan yang diawali `/` atau yang me-mention dia.
3. **Bikin grup**, contoh "Agent Server". Masukkan bot ke grup, lalu jadikan **admin** (Info grup, Administrators, Add Admin).
4. **Aktifkan Topics**: Info grup, Edit, nyalakan **Topics**. Grup otomatis berubah jadi supergroup.
5. **Bikin topik**, contoh:

   | Topik | Isinya |
   |---|---|
   | Ops | perintah umum ke agent, cek server |
   | Logs | laporan otomatis: hasil cron, backup, deploy |
   | nama-project-1 | semua kerjaan untuk project itu |
   | nama-project-2 | ... |

6. **Ambil ID grup dan ID tiap topik.** Cara paling gampang: di tiap topik, kirim satu pesan, tekan lama pesannya, **Copy Message Link**. Hasilnya seperti:
   ```
   https://t.me/c/1234567890/31/45
   ```
   - `1234567890` → ID grup. Untuk bot ditulis dengan awalan `-100`: **`-1001234567890`**
   - `31` → **ID topik** (message thread ID)
   - `45` → ID pesan (tidak dipakai)

   Cara lain, agent yang ambil (token dibaca dari `.env`, tidak ditampilkan di chat):
   ```bash
   source ~/.hermes/.env
   curl -s "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/getUpdates" | jq '.result[].message | {chat: .chat.id, judul: .chat.title, topik: .message_thread_id, teks: .text}'
   ```
   Kirim satu pesan di tiap topik dulu, lalu jalankan perintah ini.
7. **Catat semua ID** di `~/.hermes/.env` atau di `AGENTS.md` server kamu, contoh:
   ```
   TELEGRAM_HOME_CHANNEL=-1001234567890
   TELEGRAM_ALLOWED_USERS=123456789
   # Topik: Ops=2, Logs=3, project-1=4, project-2=5  (contoh, pakai ID milikmu sendiri)
   ```
8. **Arahkan agent per topik**: jalankan `hermes gateway setup` atau minta agent mengatur konfigurasi Telegram Hermes supaya hanya merespons di grup itu, laporan cron dikirim ke topik Logs, dan tiap topik project bekerja di folder project yang sesuai. Agent baca dokumentasi Hermes (https://hermes-agent.nousresearch.com/docs/) untuk nama pengaturan versi terbaru.

Tes: kirim "halo, kamu di topik apa?" di tiap topik. Bot harus membalas di topik yang sama, dan tidak membalas pesan dari akun yang tidak ada di `TELEGRAM_ALLOWED_USERS`.

Pola yang sama bisa dipakai untuk bot buatan sendiri (bukan Hermes), misalnya bot notifikasi pesanan untuk klien: kirim pesan ke grup dengan parameter `message_thread_id` = ID topik supaya masuk ke topik yang benar.

### Pindah ke VPS (jalan 24 jam)

Di VPS (modul 09), install Hermes dengan perintah yang sama, salin config, lalu jadikan service:

```bash
sudo hermes gateway install --system
sudo hermes gateway start --system
journalctl -u hermes-gateway -f      # lihat log
```

Pola mentor: 9router dan Hermes jalan di VPS yang sama, Hermes memanggil 9router lewat localhost, dan Telegram dipakai sebagai "remote". Grup Telegram dengan beberapa topik (Ops, Logs, satu topik per project) membantu memisahkan percakapan.

### Persona dan aturan

Tulis aturan agent di `~/.hermes/SOUL.md` dan `~/.hermes/AGENTS.md`. Masukkan Karpathy guidelines dan aturan keamanan (jangan tampilkan token, jangan hapus data tanpa konfirmasi). Skill Hermes bisa disimpan di repo GitHub private supaya sama di laptop dan VPS.

## E. Gemini CLI (opsional)

Kalau punya Google AI Pro, Gemini CLI bisa jadi agent coding cadangan saat kuota Claude habis. Install: `npm install -g @google/gemini-cli`, jalankan `gemini`. Aturan di `AGENTS.md` tetap berguna karena semua agent ini membacanya.

## F. Skala perusahaan: Worg, email perusahaan, on-premise

Untuk perusahaan yang mau memakai AI di produk atau internal dengan data pelanggan, masalahnya bukan cuma harga, tapi **di mana data diproses dan apakah disimpan**.

[Worg](https://getworg.com) adalah layanan AI inference untuk bisnis:
- API OpenAI-compatible (`https://api.getworg.com/v1`), jadi aplikasi cukup ganti base URL.
- Model open-weight yang dijalankan di **mesin lokal di Indonesia**, sehingga data tetap di Indonesia (relevan untuk UU PDP).
- Yang dicatat hanya metadata (waktu, model, jumlah token, biaya, status). Isi prompt, output, dan alamat IP tidak disimpan.
- **Zero Data Retention (ZDR)** untuk B2B. Minta DPA (perjanjian pemrosesan data) tertulis saat onboarding perusahaan.
- Faktur PPN dan dukungan dalam Bahasa Indonesia. Saldo prepaid USD, top-up rupiah lewat QRIS.

Kapan pakai Worg dibanding provider global: data pelanggan masuk ke prompt, klien mensyaratkan data tidak keluar negeri, atau butuh faktur pajak Indonesia.

### Email perusahaan tanpa langganan per user

Untuk perusahaan dengan puluhan karyawan, langganan email per user per bulan cepat membengkak:

| Jumlah karyawan | Google Workspace Business Standard (USD 14/user/bulan, tahunan) | Business Plus (USD 22/user/bulan) |
|---|---|---|
| 10 orang | USD 140/bulan, sekitar Rp2,4 juta/bulan | USD 220/bulan, sekitar Rp3,8 juta/bulan |
| 30 orang | USD 420/bulan, sekitar Rp7 juta/bulan | USD 660/bulan, sekitar Rp11 juta/bulan |
| 70 orang | USD 980/bulan, sekitar Rp16 juta/bulan (sekitar Rp200 juta/tahun) | USD 1.540/bulan, sekitar Rp26 juta/bulan |

Harga Google Workspace dari halaman resmi Google (USD, paket tahunan), dikonversi kasar dengan kurs sekitar Rp17.000. Cek https://workspace.google.com/intl/id/pricing.html untuk harga terbaru.

Mentor menyediakan **jasa setup email perusahaan, mulai Rp10.000.000, bayar sekali** (bukan per user per bulan). Cocok untuk perusahaan yang butuh alamat `nama@perusahaan.com` untuk banyak karyawan. Rincian yang termasuk (jumlah akun, penyimpanan, fitur, dan biaya infrastruktur kalau ada) dibahas saat konsultasi. Hubungi mentor (sagarasea).

Kalau cuma butuh beberapa alamat yang diteruskan ke Gmail, Cloudflare Email Routing gratis sudah cukup (modul 09b bagian B).

### On-premise penuh

Kalau perusahaan mau semuanya benar-benar di mesin sendiri (on-premise), model open-weight juga bisa dijalankan dengan [Ollama](https://ollama.com) di server kantor, lalu didaftarkan ke 9router sebagai provider. Butuh GPU yang memadai.

## Verifikasi

- (Jalur Gratis) `opencode` jalan dengan satu model gratis dan bisa menjawab "baca AGENTS.md dan ringkas".
- (Builder) Dashboard 9router terbuka, minimal satu provider dan satu combo aktif. Tes:
  ```bash
  curl http://localhost:20128/v1/models -H "Authorization: Bearer $ROUTER_API_KEY"
  ```
- (Builder) `hermes doctor` hijau, dan bot Telegram membalas pesan dari akun kamu, tapi tidak membalas akun lain.

## Lanjut

Modul [11 Automation](11-automation.md).
