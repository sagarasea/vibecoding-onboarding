# 08 Referensi desain: berhenti bikin desain AI generik

**Tujuan:** setiap project punya `DESIGN.md` yang berdasar referensi nyata, dan agent punya akses ke sumber referensi itu.

**Waktu:** 20 menit untuk setup, 30 menit per project untuk riset.

Kalau agent dibiarkan menebak, hasilnya selalu sama: gradien ungu, kartu dengan bayangan tebal, ikon di lingkaran, headline "Unlock your potential". Obatnya: kasih referensi konkret dan filter antislop.

## Sumber referensi

| Sumber | Isi | Akses agent | Biaya |
|---|---|---|---|
| [jiro.build](https://jiro.build) | 1.400+ desain dan prompt yang bisa ditarik agent | MCP: `claude mcp add --scope user --transport http jiro https://mcp.jiro.build` | ada versi gratis |
| [designspells.com](https://designspells.com) | kumpulan micro-interaction dan detail UI yang bikin "wah" | buka manual, screenshot ke `docs/reference/` | gratis |
| [styles.refero.design](https://styles.refero.design) | 2.000+ design system (warna, tipografi) dari situs nyata, bisa diekspor jadi DESIGN.md | MCP Refero (paket berbayar): `claude mcp add --scope user --transport http refero https://api.refero.design/mcp` | lihat situsnya |
| [supahero.io](https://supahero.io) | koleksi hero section situs web | manual | lihat situsnya |
| [mobbin.com](https://mobbin.com) | alur aplikasi mobile dan web nyata (onboarding, checkout, settings) | MCP di paket Pro | Free terbatas, Pro sekitar USD 10/bulan (tahunan) |
| [60fps.design](https://60fps.design/mcp) | 2.000 interaksi iOS nyata + breakdown motion + kode SwiftUI | MCP berbayar, skill: `npx skills add 60fps-Design/plugin` | USD 29/bulan |
| [21st.dev](https://21st.dev) | komponen UI React siap pakai, ada MCP Magic | `npx @21st-dev/cli@latest init --client claude` | Free 2 komponen/hari, Builder mulai USD 6/bulan |

Untuk mulai gratis: jiro.build (MCP gratis) + designspells + styles.refero.design (lihat manual) + supahero. Tambah Mobbin kalau bikin aplikasi dengan banyak alur.

## Skill desain yang dipasang

- `frontend-design` (plugin resmi Anthropic): arahan visual supaya tidak terlihat template.
- `antislop` + `antislop-ui` + `antislop-human` + `antislop-layoutmobile`: filter wajib (modul 06).
- Opsional, untuk yang serius di motion: skill Emil Kowalski (`emil-design-eng`, `review-animations`), `apple-design`, `awwwards`.

## Cara riset untuk satu project

1. **Tentukan jenis halaman:** landing page, dashboard, aplikasi mobile, portofolio.
2. **Kumpulkan 3 referensi utama + 3 pendukung.** Jangan 15 sekaligus, agent jadi bingung.
   - Hero dan layout: supahero, jiro.
   - Warna dan tipografi: styles.refero.design.
   - Alur aplikasi: mobbin.
   - Interaksi: designspells, 60fps.
3. **Simpan screenshot** ke `docs/reference/` di project.
4. **Isi tabel Referensi di `DESIGN.md`:** link, kenapa dipilih, pola apa yang diambil. Tulis juga yang **di-skip** dan alasannya.
5. **Minta agent:**
   ```
   Baca DESIGN.md dan gambar di docs/reference/. Isi bagian Palet, Tipografi, dan Motion
   berdasarkan referensi itu. Jangan menambah warna atau font di luar referensi.
   Pakai skill antislop dan frontend-design. Tanya kalau ada yang bertentangan.
   ```
6. **Review hasil pertama di HP**, bukan cuma di laptop.

## Kalau kamu desainer

Kelebihanmu di sini besar. Desain dulu di Figma (atau FigCraft), lalu sambungkan MCP Figma supaya agent membaca frame langsung. Tulis keputusan desain yang sudah final di `DESIGN.md` bagian "Keputusan", supaya agent tidak mengubahnya.

## Verifikasi

- `claude mcp list` menampilkan `jiro`.
- `templates/DESIGN.md` sudah disalin ke project pertama, tabel Referensi berisi minimal 3 link.

## Lanjut

Modul [09 Deploy](09-deploy.md).
