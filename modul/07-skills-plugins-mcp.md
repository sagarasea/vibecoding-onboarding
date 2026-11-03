# 07 Skills, plugin, dan MCP: global atau per repo

**Tujuan:** kamu paham bedanya skill, plugin, dan MCP, tahu mana yang dipasang global dan mana di repo, dan sudah memasang paket dasar.

**Waktu:** 20 menit.

## Bedanya apa

| | Apa | Contoh | Lokasi |
|---|---|---|---|
| **Skill** | Folder berisi `SKILL.md`: instruksi + script untuk satu jenis tugas. Agent memuatnya otomatis saat tugasnya cocok, atau dipanggil dengan `/nama-skill`. | antislop, hyperframes, watch | global `~/.claude/skills/`, repo `.claude/skills/` |
| **Plugin** | Paket berisi skill, slash command, subagent, hook, atau MCP sekaligus. Diinstall dari marketplace. | frontend-design, claude-seo, figma | dikelola lewat `/plugin` |
| **MCP** | Jembatan agent ke aplikasi atau data luar (Figma, Supabase, browser, GitHub). | Context7, Playwright, Supabase | `~/.claude.json` atau `.mcp.json` di repo |

Analogi: skill itu SOP, plugin itu paket SOP + alat, MCP itu kabel ke aplikasi lain.

## Global atau per repo: aturan mentor

| Pasang **global** kalau... | Pasang **di repo** kalau... |
|---|---|
| dipakai di hampir semua project (antislop, frontend-design, Context7) | khusus satu project (skill deploy project itu, set skill marketing untuk satu brand) |
| alat pribadi kamu (watch, agent-reach) | harus sama persis untuk semua anggota tim (versi antislop dikunci di `.claude/skills/`) |
| tidak butuh kredensial project | butuh koneksi ke resource project itu (MCP Supabase dengan `project_ref` project tersebut) |

Lokasi per jenis:

| Jenis | Global | Per repo (ikut di-commit) | Per repo, pribadi (tidak di-commit) |
|---|---|---|---|
| Aturan agent | `~/.claude/CLAUDE.md` | `AGENTS.md` + `CLAUDE.md` | `CLAUDE.local.md` |
| Skill | `~/.claude/skills/<nama>/` | `.claude/skills/<nama>/` | |
| Plugin | `--scope user` (default) | `--scope project` | `--scope local` |
| MCP | `claude mcp add --scope user` | `--scope project` → `.mcp.json` | `--scope local` (default) |
| Izin & hook | `~/.claude/settings.json` | `.claude/settings.json` | `.claude/settings.local.json` |

Untuk agent selain Claude Code (opencode, Codex), salinan skill di repo ditaruh di folder `skills/` di root, dirujuk dari `AGENTS.md`.

## Langkah 1: plugin dasar (global)

Di Claude Code, ketik:

```
/plugin install frontend-design@claude-plugins-official
```

Marketplace resmi `claude-plugins-official` sudah otomatis tersedia. Ketik `/plugin` lalu buka tab **Discover** untuk melihat semua plugin. Banyak MCP populer (context7, github, playwright, supabase, vercel, figma) juga tersedia sebagai plugin sekali klik di sana, sering lebih gampang dari `claude mcp add`.

## Langkah 2: MCP dasar

Agent jalankan dari terminal biasa (bukan di dalam sesi Claude), lalu buka sesi Claude dan ketik `/mcp` untuk login yang pakai OAuth.

| MCP | Untuk | Perintah | Scope |
|---|---|---|---|
| Context7 | dokumentasi library versi terbaru, supaya agent tidak pakai API usang | `npx ctx7 setup --claude` | user |
| Playwright | agent membuka browser, klik, dan screenshot untuk ngetes aplikasi | `claude mcp add --scope user playwright -- npx @playwright/mcp@latest` | user |
| Chrome DevTools | debug performa dan console di Chrome | `claude mcp add --scope user chrome-devtools -- npx chrome-devtools-mcp@latest` | user |

## Langkah 3: MCP sesuai minat

| MCP | Untuk | Perintah | Scope |
|---|---|---|---|
| Supabase | baca/ubah database dan tabel lewat agent | `claude mcp add --scope project --transport http supabase "https://mcp.supabase.com/mcp?project_ref=ID_PROJECT&read_only=true"` | project |
| Vercel | cek deploy, log, domain | `claude mcp add --transport http vercel https://mcp.vercel.com` | user |
| GitHub | issue, PR, repo lewat MCP (biasanya `gh` sudah cukup) | `/plugin install github@claude-plugins-official` | user |
| Figma | baca frame Figma jadi kode | `/plugin install figma@claude-plugins-official` | user |
| Jiro | 1.400+ referensi desain yang bisa ditarik agent | `claude mcp add --scope user --transport http jiro https://mcp.jiro.build` | user |
| Refero | design system dari situs nyata (butuh paket berbayar Refero) | `claude mcp add --scope user --transport http refero https://api.refero.design/mcp` | user |
| 21st.dev Magic | komponen UI siap pakai | `npx @21st-dev/cli@latest init --client claude` (butuh API key dari https://21st.dev/mcp) | user |
| 60fps.design | pola interaksi dan motion dari aplikasi iOS nyata (berbayar) | URL MCP didapat setelah beli di https://60fps.design/mcp. Skill-nya: `npx skills add 60fps-Design/plugin` | user |
| Repliz | jadwal posting dan auto-reply sosmed | MCP `https://mcp.repliz.com/mcp` dengan Access Key + Secret Key dari dashboard Repliz (modul 11) | user |

Supabase dengan `read_only=true` dulu. Matikan read-only hanya kalau kamu paham apa yang akan diubah agent.

## Langkah 4: izin dasar per project

Salin `templates/claude-settings.json` ke `.claude/settings.json` di project. Isinya: izinkan perintah aman (npm, git status/diff/log), larang `rm -rf` dan membaca `.env`. Ini mengurangi pertanyaan izin tanpa membuka akses berbahaya.

## Perintah yang sering dipakai

```bash
claude mcp list              # daftar MCP dan statusnya
claude mcp remove nama       # hapus MCP
claude plugin list           # daftar plugin
```
Di dalam sesi: `/mcp` dan `/plugin`. Skill yang tersedia muncul saat kamu mengetik `/`.

## Verifikasi

- `claude mcp list` menampilkan Context7 dan Playwright berstatus connected.
- Di sesi Claude, ketik: "pakai context7, cek cara bikin route handler di Next.js versi terbaru". Agent memanggil tool Context7.
- `/plugin` menampilkan frontend-design terpasang.

## Kalau gagal

- MCP status `failed`: jalankan `claude mcp get nama` untuk lihat error. Biasanya `npx` belum ada (install Node) atau perlu login lewat `/mcp`.
- Terlalu banyak MCP bikin agent lambat dan boros konteks. Pasang yang dipakai saja, hapus yang tidak.

## Lanjut

Modul [08 Referensi desain](08-referensi-desain.md).
