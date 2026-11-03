# Skill dan plugin global milik mentor

Daftar ini menunjukkan isi `~/.claude/skills/` dan plugin yang aktif di laptop mentor per 2026-11-04. Tidak perlu install semuanya. Ambil yang sesuai minat (lihat modul 12).

Legenda sumber: **Custom** = dibuat mentor untuk infrastruktur sendiri, tidak untuk diinstall orang lain. Lainnya bisa diinstall dengan perintah di kolom Install.

## Skill di `~/.claude/skills/`

| Skill | Fungsi | Sumber / Install |
|---|---|---|
| `antislop` + `antislop-ui`, `-copywriting`, `-human`, `-layoutmobile`, `-code` | Filter AI slop untuk UI, copy, aksesibilitas, layout mobile, komentar kode | `npx antislop-ai` ([miqdadbadjuber/anti-slop](https://github.com/miqdadbadjuber/anti-slop)) |
| `emil-design-eng` | Filosofi polish UI dan animasi Emil Kowalski | animations.dev (Emil Kowalski) |
| `review-animations` | Review kode animasi dengan standar tinggi | animations.dev (Emil Kowalski) |
| `improve-animations` | Audit motion satu codebase + rencana perbaikan | animations.dev (Emil Kowalski) |
| `find-animation-opportunities` | Cari bagian UI yang sebaiknya dianimasikan | animations.dev (Emil Kowalski) |
| `animation-vocabulary` | Ubah deskripsi kabur ("yang mantul pas popup") jadi istilah tepat | satu paket dengan skill Emil |
| `apple-design` | Pendekatan desain dan motion ala Apple untuk web | satu paket dengan skill Emil |
| `awwwards` | Bikin situs kelas Awwwards dari satu prompt | `npx skills add wheresryan22/anatomy` |
| `hyperframes`, `hyperframes-cli`, `hyperframes-registry`, `media-use`, `figma`, `remotion-to-hyperframes`, `slideshow` | Toolkit video HyperFrames (HTML jadi video): CLI, 450 blok siap pakai, media, import Figma, port dari Remotion, slideshow | `npx skills add heygen-com/hyperframes` |
| `watch` | "Nonton" video: yt-dlp + ffmpeg + transkrip, lalu dianalisis agent | [bradautomates/claude-video](https://github.com/bradautomates/claude-video) |
| `agent-reach` | Riset internet di 15 platform (X, Reddit, YouTube, XHS, GitHub, dll) | [Panniantong/Agent-Reach](https://github.com/Panniantong/Agent-Reach) |
| `motion-studio` | Router tools motion/video di Mac mentor | Custom |
| `destockd` | Cari footage arsip public domain dari destockd.com | Custom |
| `vps-vhost` | Kelola vhost nginx di VPS mentor | Custom |
| `client-preview` | Pasang preview situs klien di subdomain | Custom |

## Plugin aktif (Claude Code)

| Plugin | Fungsi | Install |
|---|---|---|
| `frontend-design` | Arahan visual supaya UI tidak terlihat template | `/plugin install frontend-design@claude-plugins-official` |
| `claude-seo` | Audit SEO lengkap, schema, Core Web Vitals, GEO | `/plugin marketplace add AgriciDaniel/claude-seo` lalu `/plugin install claude-seo@agricidaniel-claude-seo` |
| `cloudflare` | Skill Workers, Pages, DNS, Wrangler | `/plugin marketplace add cloudflare/skills` lalu `/plugin install cloudflare@cloudflare` |
| `academic-research-skills` | Riset dan penulisan akademik | `/plugin marketplace add https://github.com/Imbad0202/academic-research-skills.git` |

## Skill dari Anthropic (otomatis di Claude.ai dan Claude Desktop)

`docx`, `pdf`, `pptx`, `xlsx`, `skill-creator`, `doc-coauthoring`, `web-artifacts-builder`, `canvas-design`. Aktifkan di claude.ai: Settings, Capabilities, Skills.

## Skill di level repo (bukan global)

Mentor menaruh skill di dalam repo kalau skill itu khusus untuk project tersebut atau harus versinya terkunci:

- `.claude/skills/` di repo: antislop versi tertentu yang dikunci untuk project itu, atau set skill marketing untuk satu brand.
- `skills/` di root repo: salinan antislop untuk agent non-Claude yang membaca `AGENTS.md`.
- `.claude/agents/` dan `.claude/commands/`: subagent dan slash command khusus project.
- `.claude/settings.json`: izin dan larangan perintah (contoh: larang `rm -rf`, larang baca `.env`).

Aturan praktis ada di modul 07.
