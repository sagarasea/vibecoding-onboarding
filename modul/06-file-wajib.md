# 06 File wajib: aturan kerja agent

**Tujuan:** agent kamu punya aturan kerja yang sama di semua project (global), dan setiap project punya file konteks sendiri.

**Waktu:** 15 menit.

AI agent tidak ingat apa-apa antar sesi. Yang dia baca setiap kali mulai adalah file-file ini. Kualitas hasil sangat ditentukan oleh isinya.

## Peta file

| File | Lokasi | Isi | Dipakai oleh |
|---|---|---|---|
| `~/.claude/CLAUDE.md` | global, sekali pasang | Cara kerja agent: Karpathy guidelines + aturan mentor (model, em-dash, keamanan DB, rahasia) | Claude Code di semua project |
| `AGENTS.md` | root tiap project | Konteks project: apa ini, stack, perintah, aturan keras, keputusan, to-do | Claude Code (lewat `CLAUDE.md`), opencode, Codex, Cursor, Hermes |
| `CLAUDE.md` | root tiap project | Satu baris: `@AGENTS.md` | Claude Code |
| `DESIGN.md` | root tiap project | Referensi desain, palet, tipografi, motion, suara copy | Agent saat menulis UI dan copy |
| `MEMORY.md` | root project (opsional) | Log keputusan, terbaru di atas, tanggal absolut | Agent dan kamu |

Kenapa `AGENTS.md` yang jadi sumber utama dan `CLAUDE.md` cuma menunjuk ke sana: satu file dibaca oleh semua agent. Kalau nanti kamu pakai opencode dengan model gratis, aturannya tetap sama.

## Langkah 1: CLAUDE.md global (Karpathy + aturan mentor)

Sudah dipasang di modul 04. Cek:

```bash
head -20 ~/.claude/CLAUDE.md
```

Isinya empat prinsip dari [andrej-karpathy-skills](https://github.com/multica-ai/andrej-karpathy-skills/blob/main/CLAUDE.md):

1. **Think before coding.** Sebut asumsi, tanya kalau ragu.
2. **Simplicity first.** Kode paling sedikit yang menyelesaikan masalah.
3. **Surgical changes.** Ubah hanya yang perlu.
4. **Goal-driven execution.** Tentukan cara mengecek berhasil, ulangi sampai terbukti.

Ditambah aturan mentor: pilih model sesuai tugas, tanpa em-dash, keamanan database, dan rahasia tidak boleh di-commit.

Alternatif lewat plugin (kalau mau update otomatis dari sumbernya):
```
/plugin marketplace add forrestchang/andrej-karpathy-skills
/plugin install andrej-karpathy-skills@karpathy-skills
```

## Langkah 2: antislop (filter "AI slop")

[antislop](https://github.com/miqdadbadjuber/anti-slop) adalah kumpulan skill yang menahan agent dari hasil generik: UI gradien ungu, copy penuh buzzword, komentar kode basa-basi, kontras jelek, layout yang rusak di HP.

Install global (sekali, untuk semua project dan semua agent yang terdeteksi):

```bash
npx antislop-ai
```

Installer akan bertanya: skill mana (pilih semua), lokasi (pilih **global / home directory**), dan agent apa yang kamu pakai (Claude Code, opencode, dll). Pilih mode **during** kalau ditanya.

Isinya enam skill:

| Skill | Untuk |
|---|---|
| `antislop` | Inti. Selalu di-load. |
| `antislop-ui` | Warna, layout, komponen, motion |
| `antislop-copywriting` | Headline, CTA, nada tulisan |
| `antislop-human` | Kontras, keyboard, focus, aksesibilitas (ada contrast checker) |
| `antislop-layoutmobile` | Layout yang rapi dari HP sampai desktop |
| `antislop-code` | Bersihin komentar kode basa-basi |

Alternatif untuk Claude Code saja:
```
/plugin marketplace add https://github.com/miqdadbadjuber/anti-slop
/plugin install antislop@anti-slop
```

Update: `npx antislop-ai --update`, lalu mulai sesi baru.

## Langkah 3: file project (tiap project baru)

Di folder project baru, agent jalankan:

```bash
cp <folder-onboarding>/templates/AGENTS.project.md AGENTS.md
cp <folder-onboarding>/templates/DESIGN.md DESIGN.md
cp <folder-onboarding>/templates/gitignore .gitignore
echo "@AGENTS.md" > CLAUDE.md
```

Lalu isi `AGENTS.md` bareng agent. Cara paling cepat: jalankan `/init` di Claude Code, lalu minta "pindahkan hasil /init ke AGENTS.md mengikuti struktur template, dan ganti CLAUDE.md jadi `@AGENTS.md`".

## Langkah 4: DESIGN.md wajib pakai referensi

`DESIGN.md` tidak boleh diisi dari imajinasi agent. Sebelum UI pertama ditulis:

1. Buka 2-3 situs referensi di modul 08 sesuai jenis produk.
2. Simpan link dan screenshot ke tabel Referensi di `DESIGN.md` (`docs/reference/` untuk gambar).
3. Tulis "pola yang diambil" dari tiap referensi: layout, palet, tipografi, atau interaksi.
4. Baru minta agent mengisi palet dan tipografi berdasarkan referensi itu.

## Verifikasi

- `~/.claude/CLAUDE.md` ada dan berisi empat prinsip Karpathy.
- `npx antislop-ai` selesai tanpa error. Di sesi Claude Code baru, ketik `/` lalu cari `antislop`, skill-nya muncul.
- Folder `templates/` berisi `AGENTS.project.md`, `DESIGN.md`, `gitignore`.

## Lanjut

Modul [07 Skills, plugin, MCP](07-skills-plugins-mcp.md).
