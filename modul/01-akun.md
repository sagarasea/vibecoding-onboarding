# 01 Akun yang perlu dibuat

**Tujuan:** semua akun siap sebelum install, supaya alur berikutnya tidak berhenti di tengah karena nunggu verifikasi email.

**Waktu:** 15-20 menit.

**Cara agent memandu:** buka halaman signup satu per satu langsung di browser default (`open "<link>"` di macOS, `Start-Process "<link>"` di Windows), bilang apa yang harus diklik, lalu tunggu orangnya bilang "udah" sebelum membuka halaman berikutnya. Orangnya yang mengisi form, mengetik password, verifikasi email, dan membayar.

Tips: pakai **satu email yang sama** untuk semua akun, dan aktifkan login dengan Google atau GitHub kalau tersedia. Simpan password di password manager (Apple Passwords, Bitwarden, 1Password).

## Wajib untuk semua jalur

| Akun | Link | Catatan |
|---|---|---|
| GitHub | https://github.com/signup | Tempat simpan kode. Gratis. Aktifkan 2FA. |
| Claude | https://claude.ai | Jalur Hemat ke atas: langganan **Pro (USD 20/bulan)**. Paket Free tidak termasuk Claude Code. |
| Google | (akun Gmail yang sudah ada) | Untuk Google AI Studio (Gemini API gratis) dan login ke banyak layanan. |

## Untuk deploy (jalur Gratis dan Hemat)

| Akun | Link | Catatan |
|---|---|---|
| Vercel | https://vercel.com/signup | **Daftar pakai "Continue with GitHub"** supaya repo langsung tersambung. Hobby gratis, tapi khusus pemakaian pribadi/non-komersial. |
| Supabase | https://supabase.com/dashboard | Login pakai GitHub. Database + login user gratis, project di-pause kalau tidak dipakai seminggu. |
| Cloudflare | https://dash.cloudflare.com/sign-up | DNS domain, proteksi, Workers. Gratis. |

## Untuk jalur Builder dan Company

| Akun | Link | Catatan |
|---|---|---|
| Hostinger | https://www.hostinger.com/id/domain-murah | Beli domain `.com` atau `.id`. |
| Sumopod | https://sumopod.com | VPS dan app hosting lokal (Jakarta/Singapura), bayar rupiah. |
| TokenomixAI | https://tokenomixai.com | Beli token AI prepaid, satu key untuk banyak model. Lihat modul 10. |
| Worg | https://getworg.com | Inference AI untuk perusahaan. Lihat modul 10. |
| Telegram | https://telegram.org | Untuk ngobrol dengan agent Hermes dari HP. |

## Untuk automation (opsional, modul 11)

| Akun | Link |
|---|---|
| Repliz | https://repliz.com |
| Buffer | https://buffer.com |

## Verifikasi

Orangnya bilang "udah" untuk tiap akun wajib, dan agent centang di `PROGRESS.md`:

- [ ] GitHub (username dicatat di `PROGRESS.md`)
- [ ] Claude Pro aktif (atau tercatat pakai jalur Gratis)
- [ ] Vercel tersambung ke GitHub
- [ ] Supabase login dengan GitHub

## Lanjut

macOS: modul [02 Install macOS](02-install-macos.md). Windows: modul [03 Install Windows](03-install-windows.md).
