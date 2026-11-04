# Materi 02: API key dan file .env

> Muncul di: **modul 07**, pertama kali kamu memasang sesuatu yang butuh key (MCP 21st.dev, Context7, Supabase). Diingatkan lagi di modul 09 (environment variable di Vercel), 10 (key TokenomixAI, 9router, Telegram bot), dan 11 (Repliz).
> Agent: jelaskan sebelum meminta key pertama. Lalu praktikkan langsung: bikin `.env` dan `.env.example`, cek `.gitignore`, buktikan `.env` tidak muncul di `git status`.

**Setelah ini kamu bisa:**

- menjelaskan apa itu API key dengan analogi
- menyimpan key di `.env` tanpa pernah menempelkannya ke chat
- tahu langkah pertama kalau key bocor

## Apa itu API

API itu "pintu layanan" sebuah aplikasi untuk dipakai program lain. Kalau kamu buka ChatGPT di browser, kamu yang ngetik. Kalau aplikasimu memanggil model AI lewat API, kodenya yang "ngetik" dan menerima jawaban.

## Apa itu API key

API key itu **kartu akses + kartu kredit sekaligus**. Bentuknya teks panjang acak, misalnya `sk-xxxxxxxx...`. Siapa pun yang memegangnya bisa:

- memakai layanan atas nama kamu,
- menghabiskan saldo atau kuota kamu,
- di beberapa layanan, membaca dan menghapus data kamu (misalnya service key database).

Karena itu API key diperlakukan seperti password. Bedanya, password kamu ketik sendiri, sedangkan API key dibaca oleh program. Maka dia harus disimpan di tempat yang bisa dibaca program tapi tidak ikut tersebar: file `.env`.

Contoh yang akan kamu temui di onboarding ini:

| Key | Dari mana | Kalau bocor |
|---|---|---|
| Supabase `anon` key | dashboard Supabase | relatif aman (memang dipakai di browser), tapi hanya kalau Row Level Security aktif |
| Supabase `service_role` key | dashboard Supabase | **bahaya**: bisa baca dan hapus semua data. Jangan pernah dipakai di kode frontend |
| TokenomixAI / OpenRouter / Gemini key | dashboard masing-masing | orang lain menghabiskan saldo kamu |
| Token bot Telegram | @BotFather | orang lain mengendalikan bot (dan agent di belakangnya) |
| Repliz Access/Secret key | dashboard Repliz | orang lain memposting atas nama brand |

## Apa itu .env

`.env` adalah file teks biasa di root project, isinya pasangan `NAMA=nilai`:

```
SUPABASE_URL=https://abcd.supabase.co
SUPABASE_ANON_KEY=eyJhbGciOi...
ROUTER_API_KEY=sk-...
```

Program membacanya saat jalan (`process.env.ROUTER_API_KEY` di JavaScript, `os.environ["ROUTER_API_KEY"]` di Python). Kodenya tidak menyimpan nilai rahasia, cuma namanya.

## Lima aturan .env

1. **`.env` tidak pernah di-commit.** Pastikan `.env` ada di `.gitignore` sebelum commit pertama. Repo private pun tetap tidak boleh: repo bisa dibagikan, di-fork, atau dibuka ke publik suatu hari.
2. **Bikin `.env.example`** berisi nama variabel tanpa nilai. File ini yang di-commit, supaya orang lain (dan agent) tahu variabel apa saja yang dibutuhkan:
   ```
   SUPABASE_URL=
   SUPABASE_ANON_KEY=
   ROUTER_API_KEY=
   ```
3. **Jangan tempel key ke chat AI.** Agent membukakan file `.env` (`open -e .env` di macOS, `notepad .env` di Windows), kamu yang menempel nilainya di sana.
4. **Di hosting, key diisi di dashboard**, bukan di file. Vercel: Project, Settings, Environment Variables. VPS: file `.env` dibuat manual di server dengan permission `600`.
5. **Awalan `NEXT_PUBLIC_` (Next.js) atau `VITE_` (Vite) artinya nilainya dikirim ke browser** dan bisa dilihat siapa pun. Hanya untuk nilai yang memang publik (URL, anon key). Key rahasia tanpa awalan itu, dan hanya dipakai di server.

## Kalau key terlanjur bocor

Bocor artinya: ter-commit ke GitHub, tertempel di chat, ter-screenshot, atau terkirim ke orang yang salah.

1. **Revoke / rotate sekarang** di dashboard layanannya: hapus key lama, bikin yang baru. Menghapus commit-nya saja tidak cukup, karena riwayat git dan bot pemindai sudah melihatnya.
2. Ganti nilai di `.env` lokal dan di dashboard hosting.
3. Cek pemakaian dan tagihan di dashboard layanan.
4. Pasang batas pengeluaran (spending limit) kalau layanannya menyediakan.

GitHub juga punya secret scanning yang akan memberi peringatan kalau mendeteksi key di repo. Jangan diabaikan.

## Praktik (agent jalankan)

```bash
touch .env .env.example
grep -qxF '.env' .gitignore || echo '.env' >> .gitignore
git status
```

`.env` tidak boleh muncul di daftar `git status`. `.env.example` boleh.

## Salah kaprah yang sering muncul

- "Repo-nya private, jadi aman taruh key di kode." Repo private bisa dibagikan, di-fork, atau bocor. Key tetap di `.env`.
- "Hapus key dari file lalu commit lagi sudah beres." Key masih ada di riwayat git. Revoke di dashboard, bikin key baru.
- "`.env.example` juga rahasia." Isinya nama variabel tanpa nilai, justru wajib di-commit supaya orang lain tahu key apa saja yang dibutuhkan.

## Cek pemahaman

Agent tanyakan satu per satu.

1. "Kamu butuh key TokenomixAI di aplikasi Next.js yang memanggil AI dari server. Nama variabelnya pakai `NEXT_PUBLIC_TOKENOMIX_KEY` atau `TOKENOMIX_KEY`? Kenapa?"

Jawaban yang diharapkan: `TOKENOMIX_KEY`. Dengan awalan `NEXT_PUBLIC_`, key dikirim ke browser dan siapa pun bisa mengambilnya lalu menghabiskan saldo.

2. "Kamu tidak sengaja menempel API key ke grup WhatsApp. Apa langkah pertamamu?"

Jawaban yang diharapkan: revoke key itu di dashboard layanannya dan bikin yang baru, lalu ganti isi `.env`. Menghapus pesannya saja tidak cukup.

Kalau jawabannya meleset, jelaskan ulang bagian itu dengan analogi lain, lalu tanya lagi dengan skenario yang sedikit berbeda.

## Kartu contekan

- API key: kunci rumah sekaligus kartu tagihan. Siapa pun yang pegang bisa memakai saldomu.
- Tempatnya di `.env`, tidak di kode, tidak di chat.
- `.env` tidak di-commit, `.env.example` di-commit.
- Bocor: revoke dulu, baru yang lain.
