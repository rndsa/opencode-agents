# OpenCode Agent.md (Soul Prompt)

Pengaturan otomatis file `agent.md` sebagai **System Prompt / Soul** permanen untuk OpenCode di Termux.

Sama seperti konsep `SOUL.md` pada Hermes Agent, OpenCode akan **otomatis membaca `agent.md` setiap kali mulai dan menyuntikkannya ke dalam setiap request yang dikirim ke provider AI**.

---

## ⚡ Instalasi Cepat (One-Line Setup)

Jalankan perintah berikut di terminal Termux Anda:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/rndsa/opencode-agents/main/install.sh)
```

Skrip ini akan secara otomatis:
1. Men-generate file `~/.config/opencode/agent.md` dengan template persona software engineer yang to the point dan zero-fluff.
2. Mengonfigurasi `~/.config/opencode/opencode.json` agar `agent.md` terkunci sebagai prompt utama model pada setiap turn percakapan.
3. Memasang CLI helper `opencode-agent` untuk memudahkan pengecekan dan pengeditan prompt.

---

## 🛠️ Cara Mengubah Isi `agent.md`

Anda dapat mengedit persona, instruksi, dan aturan coding kapan saja dengan perintah:

```bash
opencode-agent edit
```

Atau langsung menggunakan editor nano:

```bash
nano ~/.config/opencode/agent.md
```

Setiap kali Anda mengubah file tersebut dan menjalankan `opencode`, model AI akan langsung mengadopsi instruksi terbaru tanpa perlu konfigurasi ulang.

---

## 📋 Perintah CLI `opencode-agent`

- `opencode-agent` — Membuka menu ringkas status prompt.
- `opencode-agent edit` — Mengedit file `agent.md` menggunakan editor terminal.
- `opencode-agent cat` — Menampilkan isi prompt `agent.md` di terminal.
- `opencode-agent reset` — Mengembalikan isi `agent.md` ke template bawaan.
