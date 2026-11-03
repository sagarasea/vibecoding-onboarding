# DESIGN.md

> Template. Salin ke root project. Wajib diisi **sebelum** agent menulis UI pertama.
> Aturan nomor satu: **wajib ada referensi nyata.** Tanpa referensi, AI akan menghasilkan desain generik (gradien ungu, kartu bayangan tebal, hero "Unlock your potential"). Cari referensi di modul 08.

## Identitas

- Nama produk: [...]
- Untuk siapa: [...]
- Satu kalimat rasa yang dicari: [contoh: tenang, rapi, seperti alat kerja, bukan iklan]
- Hindari: [contoh: gradien neon, emoji di heading, ilustrasi 3D generik, stock photo orang tersenyum]

## Referensi (hasil riset [tanggal])

Jangan pakai 15 referensi sekaligus. Pilih 3 utama + 3 pendukung.

| Sumber (link) | Kenapa dipilih | Pola yang diambil |
|---|---|---|
| [https://...] | [...] | [contoh: layout hero dua kolom, ukuran heading besar] |
| [https://...] | [...] | [contoh: palet netral dengan satu aksen] |
| [https://...] | [...] | [contoh: micro-interaction tombol] |

Di-skip: [referensi yang dilihat tapi ditolak, dan alasannya]

Screenshot referensi simpan di `docs/reference/` supaya agent bisa melihatnya.

## Palet

| Token | Hex | Dipakai untuk |
|---|---|---|
| `--bg` | [#...] | latar |
| `--fg` | [#...] | teks utama |
| `--muted` | [#...] | teks sekunder |
| `--accent` | [#...] | tombol utama, link |
| `--border` | [#...] | garis |

Sumber palet: [contoh: diambil dari styles.refero.design / brand klien]

## Tipografi

- Heading: [font, weight]
- Body: [font, ukuran dasar 16px]
- Skala: [contoh: 14 / 16 / 20 / 28 / 40]

## Komponen dan layout

- Radius: [contoh: 8px]
- Spasi dasar: [contoh: kelipatan 4px]
- Lebar konten maksimal: [contoh: 1200px]
- Mobile dulu: semua layout dicek di lebar 375px.

## Motion

- Dial antislop: `ENERGY [1-3] / RHYTHM [1-3] / MOTION [1-3]`
- [contoh: transisi 150-200ms ease-out, tanpa animasi masuk di setiap section]
- Referensi micro-interaction: [link designspells / 60fps]

## Suara (copy)

- [contoh: kalimat pendek, kata kerja jelas, tidak ada buzzword]
- CTA: [contoh: "Buat jadwal", bukan "Mulai sekarang"]

## Belum diputuskan (konfirmasi owner)

- [ ] [...]
