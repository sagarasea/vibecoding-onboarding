# CLAUDE.md

Behavioral guidelines to reduce common LLM coding mistakes. Merge with project-specific instructions as needed.

**Tradeoff:** These guidelines bias toward caution over speed. For trivial tasks, use judgment.

## 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:
- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

## 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

## 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:
- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:
- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

## 4. Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform tasks into verifiable goals:
- "Add validation" → "Write tests for invalid inputs, then make them pass"
- "Fix the bug" → "Write a test that reproduces it, then make it pass"
- "Refactor X" → "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:
```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong success criteria let you loop independently. Weak criteria ("make it work") require constant clarification.

---

**These guidelines are working if:** fewer unnecessary changes in diffs, fewer rewrites due to overcomplication, and clarifying questions come before implementation rather than after mistakes.

> Bagian 1-4 di atas diambil apa adanya dari [multica-ai/andrej-karpathy-skills](https://github.com/multica-ai/andrej-karpathy-skills). Bagian 5-8 tambahan dari mentor.

---

## 5. Pilih model sesuai tugas

Sebelum mulai task baru, perkirakan scope-nya lalu sarankan model yang paling efisien. Jangan pakai model terbesar untuk semua hal.

- **Haiku:** cari fungsi, baca satu file, rename, format, ringkas teks, edit kecil di satu file.
- **Sonnet (default):** fitur kecil-menengah (1-5 file), bug fix lintas file, tulis dan jalankan test, review PR sedang.
- **Opus:** desain arsitektur, refactor besar lintas banyak file, debug masalah halus, planning panjang dengan banyak tradeoff.

Kalau ragu, pakai Sonnet. Kalau task ternyata simpel, sarankan turun. Kalau buntu, sarankan naik.

## 6. Hindari em-dash

Jangan pakai em-dash (karakter garis panjang) di tulisan apa pun, baik obrolan maupun copy yang dihasilkan. Ubah kalimatnya dulu. Kalau tetap perlu tanda baca, pakai koma, titik, kurung, atau titik dua.

## 7. Keamanan database

Perintah berikut dilarang kecuali user secara eksplisit memintanya di pesan yang sama:
- `php artisan migrate:fresh`, `migrate:reset`, `migrate:rollback`, `db:wipe`
- `DROP DATABASE`, `DROP TABLE`, `TRUNCATE TABLE`, `DROP COLUMN`, dan raw SQL `DELETE FROM`

Migration yang sifatnya menambah (additive) tetap aman. Anggap semua data database tidak punya backup.

## 8. Rahasia

Jangan pernah menulis API key, token, atau password ke file yang di-commit. Simpan di `.env`, pastikan `.env` ada di `.gitignore`, dan buat `.env.example` berisi nama variabel tanpa nilai.
