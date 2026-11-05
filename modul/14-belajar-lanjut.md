# 14 Belajar lanjut

**Tujuan:** kamu punya jalur belajar setelah onboarding, dan tahu harus ngapain minggu depan.

## Langkah pertama: kuis akhir (15 menit)

Agent jalankan [materi/kuis-akhir.md](../materi/kuis-akhir.md): sepuluh pertanyaan skenario campuran dari semua materi, satu per satu. Tujuannya bukan nilai, tapi menemukan bagian yang belum nempel selagi masih ada waktu untuk mengulang. Skor dan materi yang perlu diulang dicatat di `PROGRESS.md`.

## Kursus gratis dari Anthropic

Semua di https://anthropic.skilljar.com, gratis, dapat sertifikat. Urutan yang disarankan:

1. **Claude Code 101**: dasar.
2. **Claude Code in Action**: 9 pelajaran praktik, paling relevan untuk modul ini.
3. **Introduction to agent skills**: cara bikin skill sendiri.
4. **Introduction to subagents**: membagi kerja ke beberapa agent.
5. **Introduction to Model Context Protocol**: cara kerja MCP, lalu **MCP: Advanced Topics** kalau mau bikin MCP sendiri.
6. **Building with the Claude API**: kalau produkmu memanggil Claude dari kode.
7. **AI Fluency: Framework & Foundations**: cara berpikir bekerja dengan AI, bagus untuk tim non-teknis.

## Dokumentasi yang perlu di-bookmark

- Claude Code: https://code.claude.com/docs
- Memory dan CLAUDE.md: https://code.claude.com/docs/en/memory
- Skills: https://code.claude.com/docs/en/skills
- Plugin: https://code.claude.com/docs/en/plugins
- MCP: https://code.claude.com/docs/en/mcp
- Hooks: https://code.claude.com/docs/en/hooks-guide
- Hermes Agent: https://hermes-agent.nousresearch.com/docs/
- antislop: https://antislop.ai.id

## Rencana 7 hari setelah onboarding

| Hari | Fokus |
|---|---|
| 1 | Rapikan proyek pertama dari feedback pengguna. Commit tiap perubahan. |
| 2 | Kerjakan "Claude Code in Action" di Skilljar. |
| 3 | Bikin satu skill sendiri untuk tugas yang kamu ulang-ulang (pakai skill `skill-creator`). |
| 4 | Tambah satu fitur yang butuh database (Supabase) atau satu automation (Repliz/n8n). |
| 5 | Coba opencode dengan model gratis untuk tugas ringan, bandingkan dengan Claude. |
| 6 | (Builder) Pasang Hermes di laptop, sambungkan Telegram. |
| 7 | Ulangi kuis akhir dengan agent, bandingkan skornya dengan hari onboarding. Tulis di `MEMORY.md`: apa yang berhasil, apa yang boros waktu, apa yang mau dibikin berikutnya. |

Setelah hari ke-7, rencananya tidak lagi sama untuk semua orang. Seminggu sekali, dari folder project mana pun, tanya agent "harus belajar apa lagi?". Agent menjalankan [modul 15 Cek level](15-cek-level.md): memeriksa project kamu, menentukan level, dan memberi satu fokus untuk minggu itu.

## Kebiasaan jangka panjang

- Setiap ide baru: brainstorm dulu di ChatGPT/Gemini sampai jadi brief ([materi 05](../materi/05-dari-ide-ke-prompt.md)), lalu cek GitHub apakah sudah ada yang bikin ([materi 06](../materi/06-cari-repo-open-source.md)).

- Setiap kali agent melakukan kesalahan yang sama dua kali, tambahkan aturannya ke `AGENTS.md` project atau `~/.claude/CLAUDE.md`.
- Setiap kali kamu mengulang alur kerja tiga kali, jadikan skill.
- Bersih-bersih sebulan sekali: worktree dan branch yang sudah di-merge, `node_modules` project lama, cache. Caranya di [materi 04](../materi/04-worktree-dan-bersih-bersih.md#bersih-bersih-kapan-dan-kenapa).
- Update tools sebulan sekali: `brew upgrade` (Mac) atau `winget upgrade --all` (Windows), `npx antislop-ai --update`, `/plugin` lalu update marketplace.
- Simpan keputusan dengan tanggal absolut ("2026-11-04", bukan "kemarin").

## Kalau buntu

1. Tanya agent: "jelaskan errornya dalam bahasa sederhana, lalu kasih 2 kemungkinan penyebab".
2. Minta agent cari dokumentasi terbaru (Context7) sebelum menebak.
3. `/clear` dan mulai lagi dengan konteks yang lebih jelas.
4. Tanya mentor, sertakan: apa yang dicoba, pesan error lengkap, dan isi `PROGRESS.md`.
