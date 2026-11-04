# Materi 08: Penempatan folder yang rapi (laptop, GitHub, dan workdesk agent di VPS)

> Muncul di: **bagian A** di modul 05, tepat sebelum bikin repo pertama. **Bagian B** di modul 10 bagian D, saat Hermes mau dipindah ke VPS dan orangnya pegang lebih dari satu brand atau klien (jalur Builder dan Company).
> Agent: mulai dari masalahnya (project nyasar di Downloads, agent salah folder, gaya brand A kebawa ke brand B), baru struktur foldernya. Praktikkan dengan memeriksa laptop orangnya sendiri.

**Setelah ini kamu bisa:**

- menunjukkan di mana project baru harus dibuat, dan kenapa bukan di Desktop, Downloads, atau folder yang disinkron cloud
- memberi nama folder dan repo yang konsisten antara laptop dan GitHub
- (Builder) menjelaskan cara memisahkan beberapa brand di satu VPS: satu profile Hermes dan satu workdesk per brand

## Gambaran besar

Bayangkan studio desain. Kalau file klien disimpan sembarangan (sebagian di Desktop, sebagian di Downloads, sebagian di flashdisk), cepat atau lambat kamu mengirim logo klien A ke klien B. Studio yang rapi punya satu lemari, satu laci per klien, dan label yang sama di laci dan di map arsip.

Di dunia ngoding, agent memperparah masalah ini. Agent bekerja di folder tempat dia dibuka. Kalau project ada di lima tempat berbeda, agent bisa membuka folder yang salah, mengedit salinan lama, atau membaca `AGENTS.md` milik project lain.

Aturannya sederhana: **satu lemari (`~/Projects`), satu laci per brand atau klien, satu folder per repo, dan namanya sama dengan repo di GitHub.**

## Istilah

| Istilah | Artinya |
|---|---|
| **home folder** (`~`) | folder pribadi akunmu di komputer. macOS: `/Users/nama`, Windows: `C:\Users\nama`, VPS Linux: `/home/nama` |
| **workdesk** | folder kerja agent di server: tempat dia membaca konteks brand, menyimpan repo, dan menaruh hasil kerja |
| **profile (Hermes)** | satu "rumah" Hermes terpisah, dengan memori, aturan, API key, bot Telegram, dan jadwal sendiri |

---

## Bagian A: di laptop dan di GitHub

### Struktur yang dipakai

```
~/Projects/
├── halo-dunia/                 ← project latihan, boleh langsung di sini
├── brand-kopi/                 ← laci per brand atau klien (BUKAN repo)
│   ├── kopi-web/               ← repo  → github.com/akunmu/kopi-web
│   ├── kopi-bot-wa/            ← repo  → github.com/akunmu/kopi-bot-wa
│   └── kopi-web-fitur-promo/   ← worktree dari kopi-web (materi 04)
├── klien-sinar/
│   └── sinar-dashboard/        ← repo  → github.com/sinar-org/sinar-dashboard
└── _arsip/                     ← project yang sudah selesai, tidak dihapus
```

Windows sama saja, di `C:\Users\nama\Projects`.

Aturannya:

1. **Semua project di `~/Projects`.** Satu tempat, jadi kamu dan agent selalu tahu harus mencari di mana.
2. **Laci per brand atau klien** begitu kamu pegang lebih dari satu. Laci ini folder biasa, bukan repo. Project latihan boleh langsung di `~/Projects`.
3. **Satu folder = satu repo.** Nama folder sama persis dengan nama repo di GitHub.
4. **Nama pakai huruf kecil dan tanda hubung**: `kopi-web`, bukan `Kopi Web Final (2)`. Spasi di nama folder bikin banyak perintah terminal gagal.
5. **Awali nama repo dengan brand** (`kopi-web`, `kopi-bot-wa`). Di GitHub semua repo tampil dalam satu daftar, awalan ini yang membuatnya tetap terkelompok.
6. **Worktree diletakkan di sebelah repo induknya** (materi 04), dengan nama `repo-nama-fitur`.
7. **Jangan menaruh repo di dalam repo lain.** Git jadi bingung file ini milik siapa.

### Kenapa bukan Desktop, Downloads, iCloud, atau OneDrive

| Lokasi | Masalahnya |
|---|---|
| Desktop, Downloads | tempat sementara, sering dibersihkan, gampang tertimpa file lain |
| iCloud Drive (macOS: Desktop dan Documents sering ikut tersinkron), OneDrive (Windows: Documents sering ikut), Google Drive | ribuan file kecil di `node_modules` dan `.git` bikin sinkron lambat, kadang file `.git` rusak karena disinkron setengah jalan. Backup kode itu tugas GitHub, bukan Drive |

### Di GitHub: akun pribadi atau organization

| Situasi | Pilihan |
|---|---|
| brand milikmu sendiri, kerja sendirian | akun pribadi, repo private, nama diawali brand |
| klien, atau brand yang punya tim sendiri | **organization** gratis per brand atau klien (`github.com/sinar-org`). Anggota tim diundang ke organization itu saja, dan kalau kerja sama selesai, repo tinggal diserahkan tanpa memindahkan apa pun |

Agent bisa bikin repo langsung di organization: `gh repo create sinar-org/sinar-dashboard --private --source=. --push`. Organization-nya sendiri dibuat orangnya di browser (agent bukakan https://github.com/organizations/plan).

### Praktik

Agent jalankan, orangnya menebak dulu hasilnya:

```bash
mkdir -p ~/Projects && ls ~/Projects
# cari repo yang nyasar di luar ~/Projects
find ~/Desktop ~/Downloads ~/Documents -maxdepth 4 -name .git -type d 2>/dev/null
```

Windows (PowerShell):

```powershell
New-Item -ItemType Directory -Force "$HOME\Projects" | Out-Null; Get-ChildItem "$HOME\Projects"
Get-ChildItem "$HOME\Desktop","$HOME\Downloads","$HOME\Documents" -Recurse -Depth 3 -Directory -Filter .git -Force -ErrorAction SilentlyContinue
```

Kalau ketemu repo nyasar, agent tawarkan memindahkannya ke laci yang benar. Memindahkan folder repo aman, riwayat git ikut pindah. Kalau repo itu punya worktree, jalankan `git worktree repair` setelah dipindah. Sesudah pindah, buka ulang folder itu di VS Code atau sesi agent baru, karena sesi lama masih menunjuk alamat lama.

---

## Bagian B: workdesk agent Hermes di VPS untuk banyak brand

### Masalahnya

Satu Hermes untuk semua brand terasa praktis, sampai terjadi ini:

- agent menulis caption brand B dengan gaya bahasa brand A, karena memorinya satu
- API key atau bot Telegram brand A terpakai untuk kerjaan brand B
- jadwal posting otomatis (cron) semua brand bercampur di satu daftar, susah dicek
- klien minta datanya dipisah, ternyata semua sudah tercampur

Solusinya mirip laptop: satu laci per brand. Di Hermes, laci itu namanya **profile**.

### Pilih tingkat pemisahan

| Situasi | Cara | Yang terpisah |
|---|---|---|
| satu brand, atau beberapa project kecil milikmu sendiri | satu Hermes, satu grup Telegram, satu topik per project (modul 10 bagian D) | percakapan saja. Memori dan API key tetap satu |
| **beberapa brand dengan gaya, API key, atau jadwal berbeda** | **satu profile Hermes per brand** (rekomendasi) | memori, aturan (`SOUL.md`), `.env`, bot Telegram, cron, riwayat sesi |
| klien yang datanya sensitif, atau timnya ikut memakai bot | profile per klien **ditambah** user Linux terpisah atau `terminal.backend: docker`. Kalau perlu, VPS sendiri | semua di atas, plus akses file. Profile saja tidak mengunci file |

Catatan penting dari dokumentasi Hermes: **profile memisahkan isi kepala agent, bukan mengunci folder.** Agent profile brand A secara teknis masih bisa membaca folder brand B kalau disuruh. Untuk klien yang sensitif, pakai baris ketiga.

### Struktur di VPS

Hermes jalan di bawah satu user non-root (contoh: `agent`), bukan `root`.

```
/home/agent/
├── .hermes/                         ← Hermes, profile default = Ops (urusan server)
│   ├── config.yaml  .env  SOUL.md
│   └── profiles/
│       ├── kopi/                    ← profile brand Kopi
│       │   ├── config.yaml          ← terminal.cwd: /home/agent/workdesk/kopi
│       │   ├── .env                 ← bot Telegram dan API key khusus Kopi
│       │   ├── SOUL.md              ← persona dan gaya bahasa Kopi
│       │   ├── memories/  skills/  cron/
│       └── sinar/                   ← profile klien Sinar
└── workdesk/
    ├── kopi/
    │   ├── AGENTS.md                ← konteks brand: siapa, tone, aturan, ID topik Telegram
    │   ├── repos/                   ← git clone repo brand ini saja
    │   │   ├── kopi-web/
    │   │   └── kopi-bot-wa/
    │   ├── aset/                    ← logo, brand guideline, referensi
    │   └── output/                  ← draft konten, laporan, hasil render
    └── sinar/
        └── ...
```

Pola namanya sama dengan laptop: nama profile = nama folder workdesk = awalan nama repo brand itu.

### Cara memasangnya

Agent yang menjalankan, langkah demi langkah, setelah Hermes default sudah jalan di VPS (modul 10 bagian D):

1. **Bikin workdesk:**
   ```bash
   mkdir -p ~/workdesk/kopi/{repos,aset,output}
   ```
   Isi `~/workdesk/kopi/AGENTS.md` dari `templates/AGENTS.project.md`, disesuaikan untuk brand.
2. **Bikin profile:**
   ```bash
   hermes profile create kopi
   ```
   Pakai `--clone` kalau mau menyalin pengaturan model dan skill dari profile default. Clone tidak menyalin bot token, daftar user yang diizinkan, dan cron, jadi itu tetap diisi ulang per brand.
3. **Arahkan folder kerjanya ke workdesk brand:**
   ```bash
   hermes -p kopi config set terminal.cwd /home/agent/workdesk/kopi
   ```
4. **Bot Telegram sendiri per brand.** Bikin bot baru di @BotFather (contoh `kopi_agent_bot`), lalu agent bukakan `~/.hermes/profiles/kopi/.env` dan orangnya menempel `TELEGRAM_BOT_TOKEN` dan `TELEGRAM_ALLOWED_USERS` di sana. Satu token tidak bisa dipakai dua profile, Hermes menolaknya. Grup Telegram per brand (contoh "Kopi HQ" dengan topik Konten, Logs, Web) disiapkan dengan cara yang sama seperti modul 10.
5. **Login GitHub dan SSH terpisah (disarankan).** Secara default semua profile berbagi `~/.ssh` dan login `gh` milik user `agent`. Supaya profile Kopi hanya bisa push ke repo Kopi:
   ```bash
   hermes -p kopi config set terminal.home_mode profile
   ```
   lalu login `gh` di profile itu memakai akun atau token yang aksesnya terbatas ke repo atau organization brand tersebut.
6. **Tulis `SOUL.md` brand**: persona, tone, kata yang dipakai dan dihindari, plus aturan keamanan yang sama dengan profile default.
7. **Nyalakan gateway.** Hermes versi sekarang (November 2026) secara default menjalankan **satu gateway untuk semua profile**, bukan satu service per profile. Agent baca halaman *Multi-profile gateways* di https://hermes-agent.nousresearch.com/docs/ untuk perintah versi terbaru, lalu cek:
   ```bash
   hermes gateway list        # status gateway semua profile
   hermes profile list
   ```

### Simpan konfigurasinya di GitHub

VPS bisa rusak. Simpan semua yang bukan rahasia di satu repo private, contoh `agent-server`:

```
agent-server/
├── AGENTS.md                ← peta server: profile apa saja, workdesk di mana, ID grup Telegram
├── profiles/kopi/SOUL.md
├── profiles/kopi/config.yaml
├── profiles/sinar/...
└── skills/                  ← skill bersama
```

`.env`, `auth.json`, memori, dan riwayat sesi **tidak** ikut di-commit. Pasang `templates/gitignore` dan tambahkan `**/.env`, `auth.json`, `memories/`, `sessions/`, `state.db`.

### Menambah brand baru (ceklis)

1. `mkdir -p ~/workdesk/brand-baru/{repos,aset,output}` + `AGENTS.md`
2. `hermes profile create brand-baru` + `terminal.cwd` ke workdesk-nya
3. bot Telegram baru, token dan allowed users di `.env` profile itu
4. `SOUL.md` brand, commit ke repo `agent-server`
5. tes: kirim "kamu brand apa, dan sekarang kerja di folder mana?" ke bot baru

Menghapus brand: arsipkan dulu `workdesk/brand` dan profile-nya (`hermes profile export brand`), baru `hermes profile delete brand`. Jangan hapus tanpa arsip.

---

## Salah kaprah yang sering muncul

- "Folder project di Documents aman karena ke-backup iCloud atau OneDrive." Sinkron cloud dan `.git` sering bentrok. Backup kode itu GitHub.
- "Nama folder di laptop tidak harus sama dengan repo di GitHub." Boleh beda, tapi beberapa minggu kemudian kamu dan agent akan bingung mana yang mana. Samakan.
- "Topik Telegram per brand sudah cukup memisahkan brand." Topik hanya memisahkan percakapan. Memori, API key, dan cron tetap satu. Untuk brand yang benar-benar berbeda, pakai profile.
- "Profile Hermes sudah mengunci folder brand lain." Tidak. Profile memisahkan memori dan konfigurasi. Untuk mengunci akses file, pakai user Linux terpisah atau backend docker.

## Cek pemahaman

Agent tanyakan satu per satu.

1. "Kamu baru dapat klien baru, toko roti bernama Manis, dan mau bikin landing page untuk mereka. Di mana foldernya kamu buat, dan apa nama repo-nya di GitHub?"

Jawaban yang diharapkan: `~/Projects/klien-manis/manis-web` (atau nama sejenis, huruf kecil dan tanda hubung), repo GitHub bernama sama, private, di akun pribadi atau organization klien.

2. (Builder) "Hermes di VPS sudah mengurus konten brand Kopi. Sekarang kamu pegang brand Sinar yang gaya bahasanya formal dan punya API key sendiri. Apa yang kamu siapkan supaya keduanya tidak tercampur?"

Jawaban yang diharapkan: profile Hermes baru `sinar` dengan `SOUL.md`, `.env`, dan bot Telegram sendiri, plus folder `~/workdesk/sinar` yang dijadikan `terminal.cwd`. Kalau datanya sensitif, tambahkan user Linux terpisah atau docker.

Kalau jawabannya meleset, jelaskan ulang bagian itu dengan analogi lain (misalnya: satu karyawan dengan satu buku catatan untuk semua klien, dibanding satu karyawan per klien dengan buku catatan masing-masing), lalu tanya lagi dengan skenario yang sedikit berbeda.

## Kartu contekan

- Laptop: `~/Projects/<brand-atau-klien>/<repo>`. Huruf kecil, tanda hubung, tanpa spasi.
- Nama folder = nama repo GitHub. Repo diawali nama brand.
- Bukan di Desktop, Downloads, iCloud, OneDrive, atau Drive.
- Klien atau brand dengan tim: organization GitHub sendiri.
- VPS: satu brand = satu profile Hermes + satu `~/workdesk/<brand>` + satu bot Telegram.
- Profile memisahkan memori, bukan mengunci folder. Klien sensitif: user Linux terpisah atau docker.
- Konfigurasi agent (tanpa `.env`) disimpan di repo private `agent-server`.
