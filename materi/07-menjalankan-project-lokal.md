# Materi 07: Menjalankan project di laptop (npm run dev, build, preview localhost)

> Muncul di: **modul 13**, pertama kali project dijalankan. Diingatkan lagi di modul 09 (cek `npm run build` sebelum deploy).
> Agent: jelaskan tabel perintah di bawah, lalu **tawarkan tiga pilihan** di bagian "Siapa yang menjalankan" dan ikuti pilihan orangnya. Tutup dengan pertanyaan cek pemahaman.

**Setelah ini kamu bisa:**

- tahu urutan `npm install`, `npm run dev`, lalu buka localhost
- menjalankan `npm run build` sebelum push
- memilih siapa yang menjalankan dev server: agent, kamu, atau preview Claude Desktop

## Gambaran besar

Kode di folder itu seperti file desain. Untuk melihat hasilnya, kode harus **dijalankan** dulu oleh sebuah program di laptopmu (dev server), lalu dibuka di browser lewat alamat `localhost`.

Analogi desainer: `npm run dev` itu tombol **Present / Preview** di Figma. Selama preview terbuka, setiap perubahan langsung terlihat. `npm run build` itu **Export final**: hasilnya dioptimalkan dan siap dikirim ke hosting.

## Perintah yang perlu dikenali

Semua perintah project JavaScript tertulis di file `package.json` bagian `"scripts"`. Agent bisa membacakannya: "perintah apa saja yang ada di package.json?"

| Perintah | Fungsinya | Kapan |
|---|---|---|
| `npm install` | mengunduh semua library yang dibutuhkan project ke folder `node_modules` | pertama kali clone/bikin project, setiap ada library baru, setelah `git pull` yang mengubah `package.json` |
| `npm run dev` | menyalakan **dev server**: aplikasi jalan di `http://localhost:3000` (Next.js) atau `:4321` (Astro) atau `:5173` (Vite), dan otomatis reload saat file berubah | setiap kali mau melihat dan mengetes hasil kerja |
| `npm run build` | membuat versi final yang dioptimalkan. Kalau ada error (tipe data salah, import hilang), build gagal di sini | **sebelum push / deploy**. Kalau build gagal di laptop, deploy di Vercel juga pasti gagal |
| `npm run start` / `npm run preview` | menjalankan hasil build di laptop, persis seperti di production | mengecek versi final sebelum deploy, atau mengejar bug yang hanya muncul di production |
| `npm run lint` | memeriksa kode dari kesalahan umum | sebelum commit, kalau project punya perintah ini |
| `npm test` | menjalankan test otomatis | sebelum commit dan merge |

Project jenis lain punya padanannya:

| Jenis project | Install | Jalankan lokal |
|---|---|---|
| Python | `uv sync` | `uv run main.py` atau `uv run uvicorn app:app --reload` |
| Laravel (PHP) | `composer install && npm install` | `php artisan serve` + `npm run dev` |
| HTML statis | tidak perlu | `npx serve .` |
| HyperFrames (video) | `npm install` | `npx hyperframes preview` |

## Siapa yang menjalankan: tiga pilihan

Agent tawarkan ini dengan kalimat seperti: "Mau aku yang jalanin dev server dan ngecek sendiri, kamu yang jalanin di terminal VS Code, atau pakai preview di Claude Desktop?"

| Pilihan | Caranya | Cocok untuk |
|---|---|---|
| **1. Agent yang menjalankan** (disarankan untuk pemula) | Agent menjalankan `npm run dev` di background, membuka `localhost` di browser default (`open http://localhost:3000` / `Start-Process http://localhost:3000`), lalu mengecek sendiri pakai Playwright: klik, isi form, screenshot di lebar HP dan desktop, baca error console. Kamu tinggal lihat dan kasih feedback. | hampir semua kasus, terutama saat agent sedang membangun fitur |
| **2. Kamu yang menjalankan** | Di VS Code buka terminal (`` Ctrl+` ``), ketik `npm run dev`, lalu `Cmd/Ctrl+klik` link `localhost` yang muncul. Biarkan terminal itu terbuka. Matikan dengan `Ctrl+C`. | kamu mau belajar, atau mau dev server tetap jalan walau sesi agent ditutup |
| **3. Preview di Claude Desktop** | Di tab Code, agent menyalakan preview dari `.claude/launch.json` dan aplikasinya tampil di panel browser di sebelah chat. Agent dan kamu melihat halaman yang sama. | kerja di Claude Desktop, mau lihat hasil tanpa pindah jendela |

Contoh `.claude/launch.json` untuk pilihan 3 (agent yang membuat):

```json
{
  "version": "0.0.1",
  "configurations": [
    { "name": "web", "runtimeExecutable": "npm", "runtimeArgs": ["run", "dev"], "port": 3000 }
  ]
}
```

Apa pun pilihannya, minta agent **membuktikan** hasilnya: "jalankan, cek pakai Playwright di 375px dan 1440px, kirim screenshot, baru bilang selesai."

## Melihat di HP dan menunjukkan ke klien

- **HP di Wi-Fi yang sama:** jalankan dev server dengan akses jaringan, contoh `npm run dev -- --hostname 0.0.0.0` (Next.js) atau `npm run dev -- --host` (Vite/Astro). Buka `http://<IP-laptop>:3000` di HP. Agent bisa mencarikan IP laptop.
- **Klien di tempat lain, belum mau deploy:** buka link publik sementara dengan Cloudflare Tunnel:
  ```bash
  cloudflared tunnel --url http://localhost:3000
  ```
  Muncul link `https://xxxx.trycloudflare.com` yang bisa dibuka siapa pun selama perintah itu jalan. Matikan dengan `Ctrl+C` setelah demo. Jangan dipakai untuk aplikasi yang berisi data asli tanpa login.
- Untuk yang permanen: deploy (modul 09), kirim link preview Vercel.

## Masalah yang sering muncul

| Gejala | Artinya | Solusi |
|---|---|---|
| `command not found: npm` | Node belum terpasang atau terminal belum di-refresh | buka terminal baru, cek `node --version` |
| `Cannot find module ...` | library belum di-install | `npm install` |
| `Port 3000 is already in use` | dev server lain (mungkin dari sesi agent sebelumnya) masih jalan | matikan yang lama, atau pakai port lain: `npm run dev -- --port 3001`. Agent bisa mencari dan mematikan proses di port itu |
| halaman putih / error merah di browser | ada error di kode | salin pesan error (atau minta agent baca console lewat Chrome DevTools MCP) |
| perubahan tidak muncul | dev server mati, atau cache | cek terminal dev server masih jalan, refresh `Cmd/Ctrl+Shift+R` |
| `npm run build` gagal tapi `npm run dev` jalan | dev lebih longgar, build lebih ketat | kirim error build ke agent, perbaiki sebelum push |

## Coba sendiri

Jalankan dev server dengan pilihan mana pun, buka localhost, lalu minta agent mengganti satu teks di halaman. Perhatikan halamannya berubah sendiri tanpa refresh.

## Salah kaprah yang sering muncul

- "Menutup terminal tidak mematikan aplikasi." Dev server ikut mati kalau terminalnya ditutup atau kena `Ctrl+C`.
- "Setiap ubah kode harus restart." Dev server memuat ulang sendiri. Restart hanya setelah mengubah `.env` atau menginstall library baru.
- "Jalan di `npm run dev` berarti pasti jalan di production." Build lebih ketat. Jalankan `npm run build` dulu sebelum push.

## Cek pemahaman

Agent tanyakan satu per satu.

1. "Aplikasimu jalan normal di `npm run dev`, tapi deploy di Vercel gagal. Perintah apa yang seharusnya kamu (atau agent) jalankan di laptop sebelum push, dan kenapa?"

Jawaban yang diharapkan: `npm run build`. Vercel menjalankan build yang sama; kalau build gagal di laptop, deploy juga gagal. Dev server lebih longgar sehingga error baru ketahuan saat build.

2. "Kamu baru menambah key di `.env`, tapi aplikasi masih bilang key tidak ditemukan. Apa yang kamu coba dulu?"

Jawaban yang diharapkan: matikan dev server (`Ctrl+C`) lalu jalankan lagi, karena `.env` dibaca saat dev server mulai.

Kalau jawabannya meleset, jelaskan ulang bagian itu dengan analogi lain, lalu tanya lagi dengan skenario yang sedikit berbeda.

## Kartu contekan

- Pertama kali: `npm install`.
- Kerja harian: `npm run dev`, buka localhost.
- Sebelum push: `npm run build`.
- Ubah `.env`: restart dev server.
