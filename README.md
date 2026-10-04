# OpenCode Agents Hub

Koleksi template agent resmi dan pengelola profil AI (`agent.md`) otomatis untuk OpenCode di Android / Termux. Dilengkapi antarmuka TUI interaktif dan integrasi instan ke MT Manager / Internal Storage.

---

## ✨ Fitur Utama

- **7 Template Agent Resmi**: Termasuk Full-Stack Builder, Code Reviewer, System Architect, AppSec Auditor, UI Designer, Debugger, dan Documenter.
- **Auto Link ke MT Manager**: Otomatis membuat shortcut `/sdcard/agent.md` sehingga file agent bisa langsung dibuka dan diedit santai lewat aplikasi file manager / text editor Android biasa.
- **Interactive Switcher (`opencode-agents`)**: Ganti agent default yang aktif hanya dengan satu klik lewat menu TUI minimalis berestetika OpenCode asli.
- **Support Primary & Subagent**: Mendukung konfigurasi agent utama (`primary`) serta agent pembantu (`subagent`) yang bisa dipanggil dengan `@nama-agent`.

---

## ⚡ Instalasi Cepat (One-Line Setup)

Jalankan perintah berikut di terminal Termux Anda:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/rndsa/opencode-agents/main/install.sh)
```

Perintah di atas akan langsung:
1. Memasang seluruh template agent ke `~/.config/opencode/agents/`.
2. Mengaktifkan agent default `builder.md` sebagai `agent.md`.
3. Menyambungkan symlink ke `/sdcard/agent.md` untuk MT Manager.
4. Membuka menu TUI **Agents Hub** untuk memilih agent.

---

## 🎛️ Buka Agents Hub Kapan Saja (`opencode-agents`)

Untuk mengganti agent aktif kapan saja, cukup ketik di terminal:

```bash
opencode-agents
```

Tampilan minimalis ala OpenCode TUI akan muncul:

```
  OpenCode v2.0.19 · Agents Hub

  Pilih template agent untuk diaktifkan:

  › ●  1. builder         Full-Stack Dev   [Primary] 
    ○  2. reviewer        Code Review QA   [Subagent]
    ○  3. architect       Clean Architect  [Primary] 
    ○  4. security-audit  Security Audit   [Primary] 
    ○  5. ui-designer     Modern UI/UX     [Primary] 
    ○  6. debugger        Diagnostics/Fix  [Primary] 
    ○  7. documenter      Docs & API Specs [Subagent]

  ─────────────────────────────────────────
  Navigasi: [↑/↓] Geser · [1-7] Langsung · [Enter] Terapkan
  Storage:  [s] Sambungkan ke MT Manager (/sdcard/agent.md)
  Keluar:   [q] Batal
```

- **Ganti Agent**: Tekan angka `1`–`7` lalu tekan `Enter`.
- **Sambung Ulang ke MT Manager**: Tekan `s`.
- **Batal**: Tekan `q`.

---

## 🧠 Katalog 7 Template Agent

| No | Agent Template | Mode | Fokus & Deskripsi Tugas |
|:--:|---|:--:|---|
| 1 | `builder.md` | Primary | Full-stack software engineer dengan izin edit file & bash untuk pembuatan fitur end-to-end. |
| 2 | `reviewer.md` | Subagent | Auditor kode read-only (edit & bash denied) untuk meninjau kualitas PR/diff tanpa risiko merusak file. |
| 3 | `architect.md` | Primary | Perancang sistem modular, refactoring arsitektur bersih (clean code), dan eliminasi technical debt. |
| 4 | `security-audit.md` | Primary | Spesialis audit keamanan kode defensif (SAST) mengacu pada standar OWASP Top 10 dan CWE-25. |
| 5 | `ui-designer.md` | Primary | Frontend architect dengan fokus pada desain anti-template, tema dark slate, token 4px/8px, dan responsivitas fluid. |
| 6 | `debugger.md` | Primary | Pakar pelacakan root cause kerusakan sistem, pembuatan tes reproduksi bug, dan perbaikan presisi. |
| 7 | `documenter.md` | Subagent | Penulis teknis untuk pembuatan spesifikasi API, panduan instalasi, dan dokumentasi arsitektur. |

---

## 📱 Cara Edit Lewat MT Manager

1. Buka aplikasi **MT Manager**.
2. Di panel penyimpanan utama (`/sdcard` atau Internal Storage), cari file bernama **`agent.md`**.
3. Buka dan edit prompt kustom Anda di sana.
4. Simpan file (`Save`).
5. Jalankan `opencode` di Termux—perubahan langsung terbaca seketika!
