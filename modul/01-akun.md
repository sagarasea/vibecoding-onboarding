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
| ChatGPT (opsional) | https://chatgpt.com | Untuk Codex. Plus (USD 20/bulan) ke atas. Lewati kalau belum mau, Free punya akses Codex terbatas. |

## Untuk deploy (jalur Gratis dan Hemat)

| Akun | Link | Catatan |
|---|---|---|
| Vercel | https://vercel.com/signup | **Daftar pakai "Continue with GitHub"** supaya repo langsung tersambung. Hobby gratis, tapi khusus pemakaian pribadi/non-komersial. |
| Supabase | https://supabase.com/dashboard | Login pakai GitHub. Database + login user gratis, project di-pause kalau tidak dipakai seminggu. |
| Cloudflare | https://dash.cloudflare.com/sign-up | DNS domain, Email Routing, R2 (backup dan media), Access, Workers. Gratis. Lihat modul 09b. |

## Untuk jalur Builder dan Company

| Akun | Link | Catatan |
|---|---|---|
| Hostinger | https://www.hostinger.com/id/domain-murah | Beli domain `.com` atau `.id`. |
| Sumopod | https://sumopod.com | VPS dan app hosting lokal (Jakarta/Singapura), bayar rupiah. |
| TokenomixAI | https://tokenomixai.com | Beli token AI prepaid, satu key untuk banyak model. Lihat modul 10. |
| Worg | https://getworg.com | Inference AI untuk perusahaan. Lihat modul 10. |
| Telegram | https://telegram.org | Untuk ngobrol dengan agent Hermes dari HP. |

## Untuk SaaS: terima pembayaran dan kirim email (modul 12)

**Daftar sedini mungkin.** Akun pembayaran butuh verifikasi dokumen yang bisa makan beberapa hari kerja, jadi mulai sekarang walau fiturnya baru dibuat minggu depan.

| Akun | Link | Catatan |
|---|---|---|
| DOKU (disarankan) | https://dashboard.doku.com/bo/register | Payment gateway: QRIS, VA bank, e-wallet, kartu. **Personal** (KTP + rekening) oke untuk satu brand. Kalau rencananya **multi brand**, mending urus **Corporate** atas nama badan usaha dari awal. |
| Midtrans (alternatif) | https://dashboard.midtrans.com/register | Payment gateway lain dengan QRIS, VA, e-wallet. |
| GoBiz (GoPay merchant) | https://www.gobiz.co.id, atau aplikasi GoBiz di Play Store / App Store | Jalur cepat tanpa gateway: dapat **QRIS statis**, lalu agent bikin QRIS dinamis dengan nominal + kode unik (modul 12). |
| ShopeePay Merchant | https://shopeepay.co.id | Alternatif QRIS statis selain GoBiz. |
| Resend | https://resend.com/signup | Kirim email dari aplikasi (verifikasi akun, reset password, notifikasi). Free 3.000 email/bulan. |

Data yang diminta (KTP, NPWP, rekening, dokumen usaha) diisi orangnya sendiri. Agent tidak pernah meminta data ini di chat.

## Untuk automation (opsional, modul 11)

| Akun | Link | Catatan |
|---|---|---|
| Repliz | https://repliz.com | Jadwal posting dan auto-reply sosmed |
| Buffer | https://buffer.com | Jadwal posting X/Twitter |
| Fonnte | https://fonnte.com | Kirim WhatsApp otomatis. Pakai nomor khusus, bukan nomor pribadi |

## Untuk desain (opsional, modul 08)

| Akun | Link | Catatan |
|---|---|---|
| Figma | https://figma.com/signup | Desain sebelum dikodekan, MCP Figma |
| Jiro | https://jiro.build | Referensi desain, login lewat MCP (OAuth) |
| Mobbin | https://mobbin.com | Alur aplikasi nyata, Free terbatas |
| 21st.dev | https://21st.dev | Komponen UI, API key untuk MCP Magic |

## Verifikasi

Orangnya bilang "udah" untuk tiap akun wajib, dan agent centang di `PROGRESS.md`:

- [ ] GitHub (username dicatat di `PROGRESS.md`)
- [ ] Claude Pro aktif (atau tercatat pakai jalur Gratis)
- [ ] Vercel tersambung ke GitHub
- [ ] Supabase login dengan GitHub
- [ ] (SaaS) Pendaftaran DOKU / Midtrans / GoBiz sudah diajukan, catat statusnya di `PROGRESS.md` karena verifikasi butuh beberapa hari

## Lanjut

macOS: modul [02 Install macOS](02-install-macos.md). Windows: modul [03 Install Windows](03-install-windows.md).
