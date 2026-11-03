# AGENTS.md

> Template project. Salin ke root project sebagai `AGENTS.md`, lalu buat `CLAUDE.md` yang isinya satu baris: `@AGENTS.md`.
> Dengan begitu Claude Code, opencode, Codex, Cursor, dan Hermes membaca satu sumber yang sama.
> Isi bagian bertanda `[...]` bersama agent. Hapus bagian yang tidak relevan.

## Apa ini

[Satu paragraf: produk apa, untuk siapa, masalah apa yang diselesaikan.]

Status per [tanggal, format 2026-11-04]: [prototype / dipakai internal / live].

## Sumber kebenaran

- Desain: `DESIGN.md`
- Keputusan dan log: `MEMORY.md` (terbaru di atas, pakai tanggal absolut)
- [Dokumen lain: brief klien, PRD, Figma link]

## Peta folder

```
[folder]/   [isi]
```

## Stack dan perintah

- Stack: [contoh: Next.js + Supabase + Tailwind, deploy di Vercel]
- Install: `[npm install]`
- Dev server: `[npm run dev]` di `http://localhost:[3000]`
- Test: `[npm test]`
- Build: `[npm run build]`

## Repo dan deploy

- Repo: `github.com/[user]/[repo]` (private)
- Deploy: [Vercel auto-deploy dari branch main / VPS lewat script]
- Environment variable: daftar nama di `.env.example`, nilai asli hanya di `.env` dan dashboard hosting.

## Aturan keras

- Jangan commit `.env`, API key, token, atau password.
- Jangan menjalankan perintah database yang menghapus data tanpa diminta eksplisit.
- Jangan mengarang data: angka, testimoni, nama klien, dan logo hanya yang asli. Kalau belum ada, pakai placeholder yang jelas tertulis placeholder.
- [Aturan khusus project: nama yang tidak boleh muncul di publik, area kode yang tidak boleh disentuh]

## Keputusan yang sudah diambil (jangan diubah tanpa owner)

- [Contoh: warna utama #xxxxxx, font Inter, tidak pakai dark mode di v1]

## To-do terbuka

- [ ] [...]

## Pedoman kerja

Ikuti `~/.claude/CLAUDE.md` (Karpathy guidelines + aturan mentor). Untuk UI dan copy, load skill `antislop` (core) lalu `antislop-ui`, `antislop-copywriting`, `antislop-human`, `antislop-layoutmobile` sesuai tugas.

Mode antislop di repo ini: [during / after / off]
