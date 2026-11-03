# Materi 06: Cari dulu di GitHub, mungkin sudah ada yang bikin

> Muncul di: **modul 13**, setelah ide jelas (materi 05) dan sebelum mulai bangun dari nol. Berlaku setiap kali punya ide baru.
> Agent: tawarkan proaktif, "Mau aku cariin dulu di GitHub, siapa tahu sudah ada project open source yang mirip? Nanti aku kasih report." Kalau setuju, jalankan langkah di bawah dan tulis report ke `docs/riset-repo.md`.

## Kenapa

Hampir semua ide sudah pernah dicoba orang: clipper podcast, aplikasi booking, dashboard operasional, bot Telegram. Memakai project open source yang sudah jalan bisa menghemat berhari-hari, dan kamu belajar dari cara orang lain menyelesaikan masalah yang sama.

Tiga kemungkinan hasil:
- **Pakai langsung:** sudah ada yang cocok, tinggal install dan sesuaikan.
- **Jadikan dasar (fork):** salin repo ke akunmu, ubah sesuai kebutuhan.
- **Jadikan referensi:** tetap bangun sendiri, tapi pelajari strukturnya, library yang dipakai, dan kesalahan yang sudah mereka temui (lihat tab Issues).

## Cara agent mencari

```bash
gh search repos "podcast clipper" --sort stars --limit 20 \
  --json fullName,description,stargazersCount,updatedAt,license,url,language
```

Agent mencoba beberapa kata kunci (bahasa Inggris, sinonim, nama fitur), misalnya "podcast clipper", "video highlight extractor", "auto shorts generator". Untuk kandidat teratas, agent membaca README-nya:

```bash
gh repo view pemilik/nama-repo
```

Cara lain: cari di https://github.com/search, https://github.com/topics (misalnya topic `saas-boilerplate`), dan daftar "awesome-..." (contoh: cari `awesome self-hosted`).

## Cara menilai repo

| Kriteria | Kenapa penting | Tanda bagus |
|---|---|---|
| Update terakhir | repo mati tidak dapat perbaikan bug dan keamanan | commit dalam 3 bulan terakhir |
| Bintang (stars) | ukuran kasar seberapa banyak yang pakai | ratusan ke atas untuk dipakai serius, puluhan cukup untuk referensi |
| Lisensi | menentukan boleh dipakai komersial atau tidak | MIT, Apache-2.0, BSD: bebas. **AGPL/GPL:** kalau dipakai di layanan, kode modifikasimu wajib dibuka. **Tanpa lisensi:** secara hukum tidak boleh dipakai |
| Issues | tanda masalah dan seberapa responsif pembuatnya | issue dijawab, tidak ratusan bug terbuka tanpa respons |
| Stack | cocok dengan stack kamu atau tidak | sama dengan yang kamu pakai (Next.js, Python, dll) |
| Dokumentasi | bisa dijalankan tanpa menebak | README jelas, ada cara install |

## Format report (`docs/riset-repo.md`)

Agent menulis report seperti ini:

```markdown
# Riset repo open source: [ide]
Tanggal: 2026-11-04. Kata kunci: [daftar kata kunci yang dicoba]

## Ringkasan
[2-3 kalimat: ada yang cocok atau tidak, dan saran: pakai / fork / referensi / bangun sendiri]

## Kandidat
| Repo | Bintang | Update terakhir | Lisensi | Stack | Cocok untuk | Catatan |
|---|---|---|---|---|---|---|
| [pemilik/nama](link) | 188 | 2026-11-02 | MIT | TypeScript | pakai langsung | ... |

## Rekomendasi
[repo pilihan, kenapa, dan apa yang perlu diubah]

## Risiko
[lisensi, repo jarang di-update, fitur yang tidak ada]
```

Contoh hasil pencarian "podcast clipper" (dicek 2026-11-04) untuk gambaran: ada repo SaaS clipper podcast ber-lisensi MIT dengan ratusan bintang, ada juga yang AGPL. Yang AGPL boleh dipelajari, tapi pikir dulu sebelum dipakai di produk untuk klien.

## Kalau mau pakai repo orang

- **Jalankan dulu apa adanya** di laptop sebelum mengubah apa pun. Agent: "clone repo ini ke ~/Projects, ikuti README sampai jalan, laporkan kendalanya."
- **Fork kalau mau dimodifikasi:** `gh repo fork pemilik/nama --clone`. Repo hasil fork ada di akunmu.
- **Baca kodenya bareng agent:** "jelaskan struktur repo ini dan alur dari upload video sampai clip jadi."
- **Hati-hati kode dari sumber tidak dikenal:** jangan jalankan script install dari repo dengan sedikit bintang tanpa minta agent membaca isinya dulu.
- **Hormati lisensi:** simpan file LICENSE dan catatan hak cipta asli.

## Cek pemahaman

Agent tanyakan satu: "Kamu menemukan repo yang cocok banget, 2.000 bintang, tapi tidak ada file LICENSE. Boleh dipakai untuk aplikasi klien?"

Jawaban yang diharapkan: tidak. Tanpa lisensi, hak ciptanya penuh di pemilik dan secara hukum tidak boleh dipakai. Jadikan referensi saja, atau tanya pemiliknya lewat issue.
