---
name: belajar-lanjut
description: Cek level vibe coding dan kasih satu fokus belajar berikutnya berdasarkan project nyata orangnya. Pakai saat orangnya bertanya "harus belajar apa lagi?", "next belajar apa?", "aku udah sampai mana?", "cek level", atau minta rencana belajar setelah onboarding, dari folder mana pun.
---

# Belajar lanjut (cek level)

Alur lengkapnya ada di repo onboarding vibe coding. Jangan mengarang alur sendiri.

1. Folder onboarding: `__ONBOARDING_DIR__`. Kalau folder itu tidak ada (dipindah atau diganti nama), cari folder yang berisi `modul/15-cek-level.md`:
   - macOS/Linux: `find ~/Projects ~ -maxdepth 3 -name 15-cek-level.md -path '*modul*' 2>/dev/null | head -1`
   - Windows (PowerShell): `Get-ChildItem $HOME -Recurse -Depth 3 -Filter 15-cek-level.md -ErrorAction SilentlyContinue | Select-Object -First 1 FullName`

   Kalau tetap tidak ketemu, bilang ke orangnya dan minta path folder onboarding-nya.
2. Baca `<folder onboarding>/modul/15-cek-level.md` dan `<folder onboarding>/AGENTS.md` (bagian cara kerja dan bahasa), lalu jalankan modul 15 dari langkah 1.
3. Script (`scripts/cek-setup.sh`) dijalankan dari folder onboarding. Perintah bukti project dijalankan di `~/Projects`.
4. Hasil dicatat ke `<folder onboarding>/PROGRESS.md`, bagian Cek level, bukan ke folder project yang sedang dibuka.

Bahasa Indonesia santai, tanpa em-dash. Satu resep, bukan daftar panjang.
