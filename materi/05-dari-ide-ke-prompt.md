# Materi 05: Dari ide ke prompt (brainstorm dulu di ChatGPT atau Gemini)

> Muncul di: **modul 13**, sebelum masuk plan mode untuk proyek pertama. Berlaku juga setiap kali mulai project atau fitur besar.
> Agent: kalau orangnya bingung mau mulai dari mana atau prompt-nya cuma satu kalimat, tawarkan alur ini. Berikan "prompt untuk bikin prompt" di bawah, minta dia bawa ke ChatGPT atau Gemini, lalu tunggu hasilnya ditempel kembali.

**Setelah ini kamu bisa:**

- mengubah ide satu kalimat jadi brief lengkap lewat ChatGPT atau Gemini
- menyimpan brief di `docs/brief.md` dan memakainya di plan mode

## Kenapa

Agent coding bekerja sebaik konteks yang dia terima. Prompt "bikinin aplikasi buat tim klien" menghasilkan aplikasi generik. Prompt yang menjelaskan siapa penggunanya, proses mereka sekarang, apa yang menyakitkan, dan apa yang belum perlu dibuat, menghasilkan aplikasi yang benar-benar dipakai.

Masalahnya, saat baru punya ide, kamu sendiri belum tahu semua detailnya. Di sinilah chat biasa (ChatGPT, Gemini, Claude.ai) berguna: tempat ngobrol panjang lebar, ditanya balik, sampai idenya matang. Brainstorm di sana murah dan tidak memakai kuota agent coding.

## Alurnya

```
1. Ide mentah di kepala
2. ChatGPT / Gemini: brainstorm, dia yang bertanya balik sampai konteks lengkap
3. ChatGPT / Gemini: tulis "brief" lengkap untuk agent coding
4. (opsional) cek GitHub: sudah ada yang bikin? (materi 06)
5. Tempel brief ke Claude Code / Codex / opencode di VS Code, dalam plan mode
6. Agent bikin rencana → kamu koreksi → baru mulai bangun
```

## Prompt untuk bikin prompt

Salin ini ke ChatGPT atau Gemini, ganti bagian dalam kurung siku:

```
Aku mau bikin [ide kasar, misalnya: aplikasi internal untuk tim operasional klien].
Aku bukan programmer, aku [profesi, misalnya: desainer]. Nanti yang ngoding adalah
AI coding agent (Claude Code / Codex).

Tugasmu: wawancarai aku sampai kamu punya konteks yang lengkap. Tanya satu kelompok
pertanyaan per pesan, jangan semua sekaligus. Gali sampai detail:

1. Siapa penggunanya, berapa orang, seberapa melek teknologi, pakai HP atau laptop.
2. Bagaimana proses mereka sekarang (tools apa, langkah demi langkah) dan bagian mana
   yang paling menyakitkan atau makan waktu.
3. Apa 3 hal yang WAJIB bisa dilakukan di versi pertama.
4. Apa yang SENGAJA belum dibuat di versi pertama.
5. Data apa yang disimpan, siapa boleh melihat dan mengubah apa.
6. Integrasi yang dibutuhkan (WhatsApp, Google Sheets, email, pembayaran, AI).
7. Batasan: budget per bulan, tenggat, harus di Indonesia atau tidak, bahasa antarmuka.
8. Gaya visual: referensi aplikasi atau situs yang disukai dan yang tidak.
9. Bagaimana tahu aplikasinya berhasil (contoh: laporan harian selesai dalam 5 menit,
   bukan 30 menit).

Setelah semua jelas, tulis BRIEF lengkap dalam Markdown untuk AI coding agent, dengan
bagian: Latar belakang, Pengguna, Masalah sekarang, Tujuan dan ukuran berhasil,
Fitur versi pertama (dengan alur langkah demi langkah per fitur), Di luar cakupan,
Data dan hak akses, Integrasi, Batasan teknis dan budget, Arah desain, Pertanyaan
yang masih terbuka. Tulis panjang dan spesifik. Jangan mengarang angka atau nama
yang tidak aku sebutkan, tulis [PERLU DIKONFIRMASI] kalau belum tahu.
```

## Setelah brief jadi

1. Simpan brief ke project sebagai `docs/brief.md`, supaya semua agent bisa membacanya kapan saja (bukan cuma di satu chat).
2. Di VS Code, buka panel Claude Code (atau Codex / opencode), masuk **plan mode** (`Shift+Tab`), lalu:
   ```
   Baca docs/brief.md, AGENTS.md, dan DESIGN.md. Bikin rencana implementasi versi pertama:
   stack, struktur folder, urutan fitur, dan cara mengecek tiap fitur. Jangan coding dulu.
   Tanyakan semua yang masih [PERLU DIKONFIRMASI] sebelum mulai.
   ```
3. Baca rencananya, koreksi, baru setujui.

## Tips

- **Panjang itu bagus di sini.** Brief 2-3 halaman wajar. Agent tidak bosan membaca.
- **Satu brief, satu versi.** Fitur versi kedua bikin brief baru, jangan ditempel ke brief lama.
- **Bawa screenshot.** ChatGPT dan Gemini bisa membaca gambar: screenshot spreadsheet atau grup WhatsApp yang dipakai klien sekarang memperjelas masalahnya. Hapus data pribadi dulu.
- **Jangan tempel data rahasia klien** (nomor HP pelanggan, data keuangan) ke chat AI gratis.

## Coba sendiri

Tulis idemu dalam satu kalimat. Bawa "prompt untuk bikin prompt" di atas ke ChatGPT atau Gemini, jawab pertanyaan-pertanyaannya, lalu tempel hasil akhirnya ke `docs/brief.md`.

## Salah kaprah yang sering muncul

- "Makin panjang prompt, makin bagus." Yang penting jelas: siapa penggunanya, masalah apa yang diselesaikan, dan kapan dianggap selesai. Panjang tanpa isi bikin agent menebak.
- "Brainstorm dulu buang waktu." Lima belas menit brainstorm biasanya menghemat berjam-jam revisi.
- "Brief harus final sebelum mulai." Brief boleh berubah. Ubah file-nya, jangan cuma bilang di chat.

## Cek pemahaman

Agent tanyakan satu per satu.

1. "Kenapa brief-nya disimpan ke `docs/brief.md` di project, bukan cuma ditempel ke chat agent?"

Jawaban yang diharapkan: supaya semua agent dan semua sesi berikutnya bisa membacanya. Isi chat hilang saat `/clear` atau ganti agent, file di repo tetap ada.

2. "Brief-mu belum menyebut siapa penggunanya. Apa akibatnya ke hasil agent?"

Jawaban yang diharapkan: agent menebak pengguna yang generik, jadi tampilan, bahasa, dan alurnya ikut generik.

Kalau jawabannya meleset, jelaskan ulang bagian itu dengan analogi lain, lalu tanya lagi dengan skenario yang sedikit berbeda.

## Kartu contekan

- Ide satu kalimat, brainstorm di ChatGPT/Gemini, brief di `docs/brief.md`, plan mode, baru kerja.
- Brief yang baik menyebut pengguna, masalah, fitur inti, dan definisi selesai.
- Brief berubah? Ubah file-nya.
