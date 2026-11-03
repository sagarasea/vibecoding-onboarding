# 12 Jalur minat: install sesuai yang mau kamu bikin

**Tujuan:** install hanya tools, skill, dan MCP yang dipakai untuk minat kamu. Sisanya bisa nanti.

**Waktu:** 15-30 menit per jalur.

Agent: baca minat di `PROGRESS.md`, jalankan bagian yang cocok saja. Cek dulu sebelum install (`command -v`, `/plugin`, `claude mcp list`). Cara tercepat: jalankan ulang script install dengan flag minatnya (`--web`, `--video`, `--agent`, `--desain`), lalu pasang yang butuh login secara manual. Daftar lengkap ada di [referensi/katalog-tools.md](../referensi/katalog-tools.md).

## A. SaaS dan web app

Contoh: aplikasi operasional untuk tim klien, dashboard, booking, tool internal.

| Jenis | Yang diinstall | Perintah |
|---|---|---|
| CLI | Vercel CLI | `npm i -g vercel` lalu `vercel login` |
| CLI | Supabase CLI | macOS: `brew install supabase/tap/supabase`. Windows: pakai `npx supabase` |
| CLI | Wrangler (Cloudflare) | `npm i -g wrangler` lalu `wrangler login` |
| App | Docker Desktop (database lokal, n8n, Supabase lokal) | macOS: `brew install --cask docker-desktop`. Windows: `winget install Docker.DockerDesktop` |
| Browser | Playwright browser + Playwright Test | `npx playwright install chromium`, test di repo: `npm init playwright@latest` |
| Plugin | frontend-design | `/plugin install frontend-design@claude-plugins-official` |
| Skill | antislop (sudah di modul 06) | |
| MCP | Context7 (dokumentasi library terbaru) | lihat modul 07 |
| MCP | Supabase | lihat modul 07 |
| MCP | Playwright (agent bisa buka browser dan ngetes) | lihat modul 07 |

Stack default yang disarankan: **Next.js + Tailwind + Supabase (database + login) + Vercel**. Kalau butuh backend yang jalan terus atau harus di Indonesia, pindah ke VPS (modul 09).

## B. AI agent dan automation

Contoh: asisten Telegram untuk tim, agent yang kerja 24 jam di VPS, posting otomatis.

| Jenis | Yang diinstall | Perintah / modul |
|---|---|---|
| Agent | Hermes Agent | modul 10 |
| Router | 9router (satu endpoint untuk banyak model, termasuk yang gratis) | modul 10 |
| Agent coding gratis | opencode | modul 10 |
| Automation | Repliz, Buffer, n8n | modul 11 |
| Skill | agent-reach (riset internet) | `pip install https://github.com/Panniantong/agent-reach/archive/main.zip` lalu ikuti README-nya |
| Server | VPS (Sumopod atau lainnya) | modul 09 |
| Model lokal | Ollama | macOS: `brew install --cask ollama-app`. Windows: `winget install Ollama.Ollama` |
| Agent cadangan | Gemini CLI | `npm i -g @google/gemini-cli` |
| App | Docker Desktop (untuk n8n) | lihat jalur A |

## C. Video dan konten

Contoh: clipper podcast, reels, motion graphic, caption otomatis.

| Jenis | Yang diinstall | Perintah |
|---|---|---|
| CLI | ffmpeg | macOS: `brew install ffmpeg`. Windows: `winget install Gyan.FFmpeg` |
| CLI | yt-dlp | macOS: `brew install yt-dlp`. Windows: `winget install yt-dlp.yt-dlp` |
| Skill | HyperFrames (HTML jadi video, 450 blok siap pakai) | `npx skills add heygen-com/hyperframes` |
| Skill | watch (agent bisa "nonton" video referensi) | lihat [bradautomates/claude-video](https://github.com/bradautomates/claude-video) |
| Framework | Remotion (video pakai React) | `npx create-video@latest` |
| CLI | ImageMagick (thumbnail, resize massal) | macOS: `brew install imagemagick`. Windows: `winget install ImageMagick.ImageMagick` |
| Transkrip | whisper.cpp (lokal, gratis) | macOS: `brew install whisper-cpp`. Windows: pakai API Whisper/Gemini |
| Runtime | Deno (dibutuhkan yt-dlp untuk YouTube) | macOS: `brew install deno`. Windows: `winget install DenoLand.Deno` |

Catatan lisensi: Remotion gratis untuk individu dan perusahaan sampai 3 karyawan, perusahaan yang lebih besar butuh Company License. HyperFrames (Apache-2.0) bebas dipakai komersial, dan bisa juga diinstall sebagai plugin: `claude plugin marketplace add heygen-com/hyperframes` lalu `claude plugin install hyperframes@hyperframes`. Cek https://www.remotion.dev/license sebelum dipakai untuk klien.

## D. Desain dan landing page

Contoh: landing page, portofolio, design system, Figma ke kode.

| Jenis | Yang diinstall | Perintah |
|---|---|---|
| Plugin | frontend-design | `/plugin install frontend-design@claude-plugins-official` |
| App | Figma Desktop | macOS: `brew install --cask figma`. Windows: `winget install Figma.Figma` |
| Skill | antislop (wajib) | modul 06 |
| Skill | emil-design-eng, review-animations, apple-design | dari animations.dev (Emil Kowalski) |
| Skill | awwwards | `npx skills add wheresryan22/anatomy` |
| MCP | Figma (baca desain jadi kode) | modul 07 |
| MCP | 21st.dev Magic (komponen UI) | modul 07 |
| MCP | 60fps.design (pola interaksi) | modul 07 |
| MCP | jiro.build (1.400+ referensi desain) | modul 07 |
| Referensi | situs-situs di modul 08 | |

## E. Laptop atau PC kuat: ArtCraft suite

Kalau mesinnya kuat, pasang [ArtCraft](https://getartcraft.com): 15 aplikasi kreatif gratis dan open source (MIT/Apache-2.0) yang dirender native di GPU. Kelebihannya untuk vibe coding: setiap aplikasi punya **CLI headless untuk agent**, dan beberapa punya **MCP server**, jadi agent bisa mendesain, mengedit video, dan bikin motion langsung di aplikasinya. Mentor memakai FigCraft untuk mendesain sebelum dikodekan, dan untuk deck serta company profile.

Saran spesifikasi (dari mentor, bukan syarat resmi): Mac Apple Silicon dengan RAM 16 GB ke atas, atau PC Windows dengan GPU terpisah (DirectX 12) dan RAM 16 GB ke atas.

| Aplikasi | Pengganti | Akses agent |
|---|---|---|
| FigCraft | Figma: desain UI dan prototype | MCP (`figcraft-cli mcp`), 400+ perintah |
| EffectCraft | After Effects: motion graphics dan VFX | CLI headless |
| FilmCraft | Premiere: edit video | CLI + MCP (`filmcraft-cli`) |
| PhotoCraft | Photoshop: edit gambar | CLI (`photocraft-cli`) |
| VectorCraft | Illustrator | CLI |
| DeckCraft | Keynote/PowerPoint | CLI |
| SoundCraft, WordCraft, PdfCraft, GridCraft, DesignCraft, LightCraft, CadCraft, TextureCraft, MaterialCraft | DAW, Word, PDF, spreadsheet, layout, Lightroom, CAD, tekstur, material | CLI (`pdfcraft-cli` punya MCP) |

Install:
- macOS: `bash scripts/install-macos.sh --craft` (Launcher + FigCraft, EffectCraft, FilmCraft, PhotoCraft, VectorCraft, DeckCraft + CLI). Satuan: `brew install --cask figcraft`, `effectcraft`, `filmcraft`, dll.
- Windows: `powershell -ExecutionPolicy Bypass -File scripts\install-windows.ps1 -Craft` membuka halaman download **ArtCraft Launcher**. Install Launcher, lalu pilih aplikasinya dari sana.

MCP FigCraft (macOS):
1. Download **Command-line tool** di https://getartcraft.com/apps/figcraft, ekstrak, pindahkan `figcraft-cli` ke `~/.local/bin/`.
2. Daftarkan MCP yang menempel ke aplikasi FigCraft yang terbuka:
   ```bash
   claude mcp add --scope user figcraft -- bash "$(pwd)/scripts/figcraft-mcp.sh"
   ```
3. Tes: "buka FigCraft, bikin frame 1440x900 berisi hero dari DESIGN.md, lalu screenshot".

Untuk CLI lain, jalankan `<nama>-cli --help` dan minta agent membaca perintah MCP-nya.

## F. SEO dan marketing (tambahan untuk semua jalur)

| Jenis | Yang diinstall | Perintah |
|---|---|---|
| Plugin | claude-seo | `/plugin marketplace add AgriciDaniel/claude-seo` lalu `/plugin install claude-seo@agricidaniel-claude-seo` |

## Global atau per repo?

Aturan singkat (detail di modul 07): skill yang kamu pakai di banyak project dipasang **global**. Skill yang khusus satu project, atau harus versinya terkunci supaya semua anggota tim sama, dipasang **di repo**.

## Verifikasi

- Jalankan `bash scripts/cek-setup.sh` (atau `.ps1`), semua tools jalur kamu berstatus OK.
- Di Claude Code, `/plugin` menampilkan plugin yang diinstall, `/mcp` menampilkan MCP yang tersambung.

## Lanjut

Modul [13 Proyek pertama](13-proyek-pertama.md).
