# 15 Cek level: "harus belajar apa lagi?"

**Tujuan:** orang yang sudah vibecode beberapa hari atau minggu dapat satu fokus belajar berikutnya yang cocok dengan project dia sendiri, bukan daftar generik.

**Waktu:** 15-20 menit. Boleh diulang kapan saja, idealnya seminggu sekali.

**Pemicu:** orangnya bertanya "harus belajar apa lagi?", "next belajar apa?", "cek level", atau sejenisnya. Bisa dari folder onboarding ini, atau dari folder project mana pun lewat skill global `belajar-lanjut` (dipasang di modul 06).

Jangan mulai ulang dari modul 00. Kalau orangnya belum pernah ikut onboarding di repo ini (tidak ada `PROGRESS.md`), salin `PROGRESS.template.md` jadi `PROGRESS.md`, isi Profil dari jawaban langkah 2, lalu langsung jalankan modul ini.

Cara kerjanya seperti dokter: periksa dulu, baru kasih resep.

## Langkah 1: kumpulkan bukti (agent jalankan sendiri)

Bukti dari mesin lebih jujur daripada perasaan "kayaknya aku udah bisa". Agent kumpulkan tanpa bertanya:

1. **`PROGRESS.md`** di folder onboarding: modul yang dicentang, skor kuis akhir, materi yang perlu diulang, isi "Nanti dieksplor", dan hasil cek level sebelumnya (kalau ada).
2. **Tools terpasang:** `bash scripts/cek-setup.sh` (Windows: `scripts\cek-setup.ps1`).
3. **Project nyata di `~/Projects`.** macOS, atau Windows lewat Git Bash:

```bash
find ~/Projects -maxdepth 3 -name .git -type d 2>/dev/null | while read -r g; do
  d="$(dirname "$g")"; cd "$d" || continue
  echo "== ${d#$HOME/}"
  echo "   commit 14 hari terakhir: $(git log --since='14 days ago' --oneline 2>/dev/null | wc -l | tr -d ' '), terakhir: $(git log -1 --format=%cs 2>/dev/null)"
  echo "   remote: $(git remote get-url origin 2>/dev/null || echo belum ada)"
  ls -d AGENTS.md DESIGN.md MEMORY.md .gitignore .vercel vercel.json wrangler.toml supabase playwright.config.* .claude/skills .mcp.json 2>/dev/null | tr '\n' ' '; echo
  git ls-files --error-unmatch .env >/dev/null 2>&1 && echo "   PERINGATAN: .env ikut ter-commit"
  [ -f package.json ] && grep -oE '"(@supabase/[a-z-]+|stripe|midtrans-client|resend|next-auth|@clerk/[a-z-]+|drizzle-orm|prisma|vitest|@playwright/test)"' package.json | tr '\n' ' ' && echo
done
```

4. **Kebiasaan agent:** skill buatan sendiri di `~/.claude/skills/` (selain yang dipasang onboarding), hook di `~/.claude/settings.json`, isi `~/.claude/CLAUDE.md` yang sudah ditambah aturan sendiri.

Rangkum hasilnya dalam 3-5 baris ke orangnya sebelum lanjut, dengan bahasa sederhana. Contoh: "Kamu punya 2 project, satu sudah online di Vercel, commit rutin. Belum ada yang pakai database. Belum bikin skill sendiri."

Kalau ada **PERINGATAN `.env` ter-commit**, bereskan itu dulu sebelum bicara soal belajar ([materi 02](../materi/02-api-key-dan-env.md), bagian "Kalau key terlanjur bocor").

## Langkah 2: tanya maksimal tiga hal (satu pesan)

1. Minggu ini lagi bikin apa, dan bagian mana yang paling bikin frustrasi atau paling lama?
2. Ada kerjaan yang kamu ulang-ulang terus, atau terasa boros waktu?
3. Target sebulan ke depan: produk jalan dan dipakai orang, dapat klien, otomasi kerjaan sendiri, atau lainnya?

Jawaban frustrasi lebih penting daripada tangga level di bawah. Kalau orangnya bilang "deploy selalu error", resepnya deploy, walaupun secara bukti dia sudah di level 3.

## Langkah 3: petakan ke tangga level

Tentukan level dari bukti, bukan dari pengakuan. Level orangnya adalah anak tangga **pertama yang tandanya belum terpenuhi**.

| Level | Tanda sudah lewat | Kalau belum, belajar ini |
|---|---|---|
| 1 Jalan di laptop | ada project yang bisa `npm run dev` dan dibuka di localhost | [materi 07](../materi/07-menjalankan-project-lokal.md), [modul 13](13-proyek-pertama.md) |
| 2 Tersimpan rapi | repo di `~/Projects`, ada remote GitHub, commit rutin, `.gitignore` aman, ada `AGENTS.md` | [materi 01](../materi/01-git-github-dasar.md), [materi 08](../materi/08-penempatan-folder.md), [modul 06](06-file-wajib.md) |
| 3 Online | ada URL publik (Vercel, Cloudflare, VPS), env var di hosting, domain sendiri | [materi 03](../materi/03-deploy.md), [modul 09](09-deploy.md), [modul 09b](09b-cloudflare.md) |
| 4 Produk beneran | database, login, email, atau pembayaran; ada tes (Playwright/Vitest) | [modul 09](09-deploy.md) bagian Supabase, [modul 12](12-jalur-minat.md), [materi 02](../materi/02-api-key-dan-env.md) |
| 5 Workflow sendiri | skill buatan sendiri, aturan sendiri di CLAUDE.md, kerja paralel pakai worktree | [modul 07](07-skills-plugins-mcp.md), [materi 04](../materi/04-worktree-dan-bersih-bersih.md), skill `skill-creator` |
| 6 Jalan sendiri | agent 24 jam, automation terjadwal, bot | [modul 10](10-ai-api-routing.md), [modul 11](11-automation.md), [materi 08](../materi/08-penempatan-folder.md) bagian B |

Minat mengubah urutan: jalur video boleh melompati level 4 ke skill dan pipeline video ([modul 12](12-jalur-minat.md) bagian C). Jalur desain boleh fokus ke [modul 08](08-referensi-desain.md) dan `DESIGN.md` sebelum database.

## Langkah 4: kasih resep sempit

Satu resep, bukan lima. Formatnya:

1. **Level kamu sekarang:** angka dan satu kalimat alasan dari bukti.
2. **Fokus minggu ini:** satu topik.
3. **Latihan di project kamu sendiri:** satu tugas konkret yang hasilnya bisa dicek. Contoh: "tambahkan login Supabase ke dashboard-klien, selesai kalau bisa login di URL Vercel-nya", bukan "pelajari autentikasi".
4. **Bacaan:** satu file `materi/` atau `modul/` dari tabel di atas, plus satu kursus Skilljar dari [modul 14](14-belajar-lanjut.md) kalau cocok.
5. **Tanda naik level:** apa yang akan dicek di cek level berikutnya.

Kalau materi untuk fokus itu belum pernah dibahas (lihat "Materi yang sudah dibahas" di `PROGRESS.md`), tawarkan untuk mengajarkannya sekarang dengan cara di [materi/README.md](../materi/README.md), lalu pertanyaan cek pemahamannya.

Kalau fokusnya ide project baru, tawarkan dulu cari di GitHub ([materi 06](../materi/06-cari-repo-open-source.md)).

## Langkah 5: catat

Tambahkan satu baris ke bagian **Cek level** di `PROGRESS.md` folder onboarding, dengan tanggal absolut:

```
- 2026-11-12: level 3, fokus login Supabase di dashboard-klien, tanda naik: login jalan di URL Vercel
```

Cek level berikutnya membaca baris ini dulu dan mulai dengan "minggu lalu fokusnya X, sudah jalan?".

Kalau baris sebelumnya menunjukkan level yang sama dengan hari ini (tertahan dua kali berturut-turut), resep tetap dikasih seperti biasa. Sesudahnya, sekali saja, sebutkan bahwa belajar langsung dengan mentor juga bisa (`AGENTS.md`, bagian Produk dan layanan dari mentor, nomor 3).

## Verifikasi

- Orangnya bisa menyebut ulang fokus minggu ini dan latihan konkretnya dengan kata-katanya sendiri.
- Baris baru ada di bagian Cek level `PROGRESS.md`.

## Kalau gagal

- **Tidak ada repo di `~/Projects`:** tanya di mana project-nya, lalu jalankan perintah bukti di folder itu. Tawarkan merapikan ke `~/Projects` ([materi 08](../materi/08-penempatan-folder.md)).
- **Orangnya merasa levelnya lebih tinggi dari bukti:** tunjukkan tanda yang belum terpenuhi, lalu tawarkan latihan singkat untuk membuktikannya. Kalau lolos, naikkan levelnya.
- **Belum ada project sama sekali:** levelnya 1, resepnya [modul 13](13-proyek-pertama.md).
