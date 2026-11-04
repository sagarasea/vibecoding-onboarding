# Katalog tools lengkap

Semua yang dipakai di onboarding ini dalam satu tabel: untuk apa, wajib atau opsional, dan cara install. Agent memakai file ini untuk memutuskan apa yang diinstall sesuai jalur dan minat di `PROGRESS.md`.

Kolom **Kapan**: `Dasar` = semua orang. `Web`, `Video`, `Agent`, `Desain` = sesuai minat. Flag di kolom Script menunjukkan tool itu ikut terinstall oleh `scripts/install-macos.sh` / `install-windows.ps1` dengan flag tersebut.

## 1. Tools terminal dan aplikasi

| Tool | Untuk apa | Kapan | macOS | Windows | Script |
|---|---|---|---|---|---|
| Homebrew | pemasang tools di Mac | Dasar | lihat modul 02 | (pakai winget) | dasar |
| Git | lacak perubahan kode | Dasar | `brew install git` | `winget install Git.Git` | dasar |
| GitHub CLI (`gh`) | GitHub dari terminal: repo, PR, login | Dasar | `brew install gh` | `winget install GitHub.cli` | dasar |
| Node.js (LTS) | jalanin JavaScript, `npm`, `npx` (hampir semua MCP butuh ini) | Dasar | `brew install node` | `winget install OpenJS.NodeJS.LTS` | dasar |
| uv | Python dan paket Python | Dasar | `brew install uv` | `winget install astral-sh.uv` | dasar |
| gitleaks | menolak commit yang berisi API key atau token | Dasar | `brew install gitleaks` | `winget install Gitleaks.Gitleaks` | dasar |
| jq | baca dan olah JSON di terminal (dipakai di hook dan script) | Dasar | `brew install jq` | `winget install jqlang.jq` | dasar |
| VS Code | editor kode | Dasar | `brew install --cask visual-studio-code` | `winget install Microsoft.VisualStudioCode` | dasar |
| Claude Code | agent coding utama | Dasar | `curl -fsSL https://claude.ai/install.sh \| bash` | `irm https://claude.ai/install.ps1 \| iex` | dasar |
| Codex CLI | agent coding dari OpenAI, login pakai akun ChatGPT | Dasar | `brew install --cask codex` | `winget install OpenAI.Codex` | dasar |
| Claude Desktop | Claude dengan tab Code, browser bawaan, sesi paralel | Dasar | `brew install --cask claude` | `winget install Anthropic.Claude` | dasar |
| Google Chrome | browser untuk Playwright, Chrome DevTools MCP, Claude in Chrome | Dasar | `brew install --cask google-chrome` | `winget install Google.Chrome` | dasar |
| Playwright (browser) | browser yang dikendalikan agent untuk ngetes aplikasi | Web | `npx playwright install chromium` | sama | `--web` |
| Vercel CLI | deploy dan cek project Vercel dari terminal | Web | `npm i -g vercel` | sama | `--web` |
| Supabase CLI | database lokal, migration, generate type | Web | `brew install supabase/tap/supabase` | `npx supabase` | `--web` |
| cloudflared | link publik sementara ke localhost (demo ke klien, terima webhook pembayaran/bot) | Web | `brew install cloudflared` | `winget install Cloudflare.cloudflared` | `--web` |
| Wrangler | CLI Cloudflare: Workers, Pages, D1, R2 | Web | `npm i -g wrangler` | sama | `--web` |
| Docker Desktop | menjalankan layanan dalam container (n8n, Supabase lokal, database) | Web, Agent | `brew install --cask docker-desktop` (alternatif lebih ringan: OrbStack) | `winget install Docker.DockerDesktop` (butuh WSL 2, installer yang mengaktifkan) | `--web` |
| Bun | runtime JavaScript cepat, beberapa tools butuh | opsional | `curl -fsSL https://bun.com/install \| bash` | `powershell -c "irm bun.sh/install.ps1\|iex"` | |
| ffmpeg | potong, gabung, convert, render video dan audio | Video | `brew install ffmpeg` | `winget install Gyan.FFmpeg` | `--video` |
| yt-dlp | download video referensi (YouTube, IG, TikTok) | Video | `brew install yt-dlp` | `winget install yt-dlp.yt-dlp` | `--video` |
| Deno | dibutuhkan yt-dlp untuk YouTube | Video | `brew install deno` | `winget install DenoLand.Deno` | `--video` |
| ImageMagick | olah gambar massal: resize, convert, thumbnail | Video, Desain | `brew install imagemagick` | `winget install ImageMagick.ImageMagick` | `--video` |
| whisper.cpp | transkrip audio jadi teks di laptop, gratis (untuk caption clipper) | Video | `brew install whisper-cpp` | pakai API Whisper/Gemini, atau build manual | `--video` (Mac) |
| opencode | agent coding dengan model gratis/murah | Dasar | `curl -fsSL https://opencode.ai/install \| bash` | `npm i -g opencode-ai` | dasar |
| Hermes Agent | asisten 24 jam, Telegram/WhatsApp, cron | Agent | `curl -fsSL https://hermes-agent.nousresearch.com/install.sh \| bash` | `iex (irm https://hermes-agent.nousresearch.com/install.ps1)` | `--agent` |
| 9router | satu endpoint untuk banyak model + fallback | Agent | `npm i -g 9router` | sama | `--agent` |
| Ollama | jalankan model AI di laptop sendiri, offline | Agent, Company | `brew install --cask ollama-app` | `winget install Ollama.Ollama` | `--agent` |
| Gemini CLI | agent coding cadangan dari Google | Agent | `npm i -g @google/gemini-cli` | sama | `--agent` |
| Figma Desktop | desain sebelum dikodekan, sumber MCP Figma | Desain | `brew install --cask figma` | `winget install Figma.Figma` | `--desain` |

## 2. Ekstensi VS Code

Diinstall otomatis oleh script dasar (`code --install-extension <id>`). Login tiap agent ada di modul 04.

| Ekstensi | ID | Untuk apa |
|---|---|---|
| Claude Code | `anthropic.claude-code` | Claude di dalam editor (login langganan Claude) |
| Codex | `openai.chatgpt` | Codex di dalam editor (login akun ChatGPT) |
| opencode | `sst-dev.opencode` | opencode di panel editor (model gratis/murah) |
| ESLint | `dbaeumer.vscode-eslint` | tanda error JavaScript/TypeScript |
| Prettier | `esbenp.prettier-vscode` | rapikan format kode |
| Tailwind CSS IntelliSense | `bradlc.vscode-tailwindcss` | autocomplete class Tailwind |
| Python | `ms-python.python` | Python |
| Playwright Test | `ms-playwright.playwright` | jalankan dan lihat test browser |
| GitLens | `eamodio.gitlens` | lihat siapa mengubah apa |

## 3. Ekstensi browser

| Ekstensi | Untuk apa | Install |
|---|---|---|
| Claude in Chrome | agent mengendalikan Chrome kamu yang sudah login (isi form, cek dashboard) | https://claude.com/chrome |
| Password manager (Bitwarden/1Password) | simpan password semua akun | dari situs masing-masing |

## 4. MCP

| MCP | Untuk apa | Kapan | Perintah | Script |
|---|---|---|---|---|
| **Playwright** | agent buka browser, klik, isi form, screenshot, cek aplikasi benar-benar jalan | Dasar | `claude mcp add --scope user playwright -- npx @playwright/mcp@latest` | dasar |
| **Chrome DevTools** | agent baca console error, network, performa | Dasar | `claude mcp add --scope user chrome-devtools -- npx chrome-devtools-mcp@latest` | dasar |
| **Context7** | dokumentasi library versi terbaru | Dasar | `npx ctx7 setup --claude` (login di browser) | manual |
| Supabase | kelola database dan tabel | Web | `claude mcp add --scope project --transport http supabase "https://mcp.supabase.com/mcp?project_ref=ID&read_only=true"` | manual (per project) |
| Vercel | cek deploy, log, domain | Web | `claude mcp add --scope user --transport http vercel https://mcp.vercel.com` | `--web` |
| Cloudflare | DNS, Workers, R2, D1 | Web | `/plugin marketplace add cloudflare/skills` lalu `/plugin install cloudflare@cloudflare` | manual |
| GitHub | issue, PR (biasanya `gh` sudah cukup) | opsional | `/plugin install github@claude-plugins-official` | manual |
| Figma | baca frame Figma jadi kode | Desain | `/plugin install figma@claude-plugins-official` | manual |
| Jiro | 1.400+ referensi desain | Desain | `claude mcp add --scope user --transport http jiro https://mcp.jiro.build` | `--desain` |
| Refero | design system dari situs nyata (berbayar) | Desain | `claude mcp add --scope user --transport http refero https://api.refero.design/mcp` | manual |
| 21st.dev Magic | komponen UI | Desain | `npx @21st-dev/cli@latest init --client claude` | manual (butuh API key) |
| 60fps.design | pola interaksi iOS (berbayar) | Desain | URL setelah beli | manual |
| Repliz | jadwal posting, auto-reply | Agent | `https://mcp.repliz.com/mcp` + Access/Secret Key | manual |

Yang "manual" butuh login di browser atau API key, jadi agent memandu dan orangnya yang klik atau menyalin key ke `.env`.

## 5. Plugin Claude Code

| Plugin | Untuk apa | Kapan | Install |
|---|---|---|---|
| frontend-design | UI yang tidak terlihat template | Dasar | `/plugin install frontend-design@claude-plugins-official` |
| antislop | filter AI slop (atau lewat `npx antislop-ai`) | Dasar | modul 06 |
| andrej-karpathy-skills | aturan kerja Karpathy (atau salin CLAUDE.md global) | Dasar | modul 06 |
| playwright | Playwright MCP versi plugin | Web | `/plugin install playwright@claude-plugins-official` |
| hyperframes | video dari HTML | Video | `claude plugin marketplace add heygen-com/hyperframes` lalu `claude plugin install hyperframes@hyperframes` |
| claude-seo | audit SEO | Marketing | `/plugin marketplace add AgriciDaniel/claude-seo` lalu `/plugin install claude-seo@agricidaniel-claude-seo` |
| cloudflare | skill Workers, DNS, Wrangler | Web | lihat tabel MCP |

## 6. Skill

| Skill | Untuk apa | Kapan | Install |
|---|---|---|---|
| antislop (6 skill) | filter UI, copy, aksesibilitas, mobile, komentar kode | Dasar | `npx antislop-ai` |
| hyperframes (7 skill) | video, caption, motion | Video | plugin (lihat tabel plugin) atau `npx hyperframes skills update` |
| motion-studio (berbayar, private) | playbook dan router tools untuk motion graphic: memilih tool yang tepat per kebutuhan, kurasi musik, SFX, dan font sesuai tema, voiceover Gemini TTS (termasuk Bahasa Indonesia), plus template musik dan color grading yang sudah teruji di produksi | Video | beli dari mentor, Rp500.000 (harga khusus student) |
| watch | agent "nonton" video referensi | Video | `/plugin marketplace add bradautomates/claude-video` lalu `/plugin install watch@claude-video` |
| agent-reach | riset internet 15 platform | Agent | https://github.com/Panniantong/Agent-Reach |
| awwwards | situs kelas award | Desain | `npx skills add wheresryan22/anatomy` |
| emil-design-eng, review-animations, apple-design | polish UI dan motion | Desain | animations.dev (Emil Kowalski) |
| 60fps | pola interaksi | Desain | `npx skills add 60fps-Design/plugin` |
| skill-creator | bikin skill sendiri | Dasar | bawaan Claude (claude.ai Settings, Capabilities) |

## 7. Layanan (akun)

Lihat modul 01 untuk link daftar dan [biaya.md](biaya.md) untuk harga: GitHub, Claude, ChatGPT (Codex), Google AI Studio, Vercel, Supabase, Cloudflare (DNS, Email Routing, R2, Access), Hostinger, Sumopod, TokenomixAI, Worg, Telegram, Repliz, Buffer, Fonnte, n8n, Resend, payment gateway (DOKU, Tripay, Midtrans, Xendit), Mobbin, 21st.dev.

## 7a. Produk berbayar dari mentor

| Produk | Untuk apa | Harga khusus student |
|---|---|---|
| motion-studio (skill) | router tools motion graphic, kurasi aset, voiceover, template grading | Rp500.000 |
| Script AI agent auto reply | auto reply pesan dengan balasan yang terasa seperti manusia | Rp3.000.000 |
| Repo carousel generator | bikin carousel konten sosial media | Rp2.500.000 |
| Article generator + articles to social (paket) | paket article generator + articles to social: bikin artikel, lalu ubah jadi konten sosial media | Rp2.500.000 untuk berdua |
| Repo AI agent outreach Threads | AI agent untuk outreach di Threads, sudah dipakai mentor untuk brand sendiri | Rp10.000.000 |

Private, beli lewat mentor (sagarasea). Harga di atas khusus student.

## 7b. Pengaman

| Pengaman | Untuk apa | Pasang |
|---|---|---|
| hook db-safety | Claude Code menolak perintah database yang menghapus data | `bash scripts/pasang-pengaman.sh` (sekali, global) |
| pre-commit gitleaks | git menolak commit berisi API key atau token | `bash scripts/pasang-pengaman.sh --repo` (per project) |
| `.gitignore` | `.env` tidak ikut ter-commit | salin `templates/gitignore` |

## 8. Laptop atau PC kuat: ArtCraft suite (flag `--craft`)

Aplikasi kreatif native GPU dari [ArtCraft](https://getartcraft.com), masing-masing punya CLI untuk agent. Detail di modul 12 bagian E.

| Aplikasi | Untuk apa | macOS | Agent |
|---|---|---|---|
| ArtCraft Launcher | install dan update semua aplikasi Craft | `brew install --cask artcraft-launcher` | |
| FigCraft | desain UI dan prototype (pengganti Figma) | `brew install --cask figcraft` | MCP via `scripts/figcraft-mcp.sh` |
| EffectCraft | motion graphics dan VFX | `brew install --cask effectcraft` | CLI |
| FilmCraft | edit video | `brew install --cask filmcraft` + `brew install filmcraft-cli` | CLI + MCP |
| PhotoCraft | edit gambar | `brew install --cask photocraft` + `brew install photocraft-cli` | CLI |
| VectorCraft | vektor | `brew install --cask vectorcraft` | CLI |
| DeckCraft | presentasi | `brew install --cask deckcraft` | CLI |
| PdfCraft | edit dan isi PDF | `brew install pdfcraft-cli` | CLI + MCP |

Windows: download ArtCraft Launcher dari https://getartcraft.com, lalu install aplikasinya dari Launcher.

## 9. Khusus VPS (modul 09)

| Tool | Untuk apa | Install (Debian/Ubuntu) |
|---|---|---|
| nginx | reverse proxy, satu vhost per hostname | `apt install -y nginx` |
| PM2 | menjaga aplikasi Node tetap hidup, restart otomatis | `npm i -g pm2` |
| ufw | firewall | `apt install -y ufw` |
| rclone | kirim backup database ke R2 (modul 09b) | `apt install -y rclone` |
| tmux | sesi terminal yang tidak putus saat SSH terputus | `apt install -y tmux` |
| Docker | n8n dan layanan lain | https://docs.docker.com/engine/install/ |
| Hermes + 9router | agent 24 jam + router model | modul 10 |
