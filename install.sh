#!/data/data/com.termux/files/usr/bin/bash
# ==============================================================================
# OpenCode Soul / Agent.md Auto Installer
# ==============================================================================

set -e

# Setup TTY
if [ -t 0 ]; then
    HAS_TTY=true
elif [ -e /dev/tty ]; then
    exec < /dev/tty
    HAS_TTY=true
else
    HAS_TTY=false
fi

# Clean screen & scrollback
clear 2>/dev/null || true
printf "\033[H\033[2J\033[3J"

# OpenCode Colors
ESC="\033"
C_RESET="${ESC}[0m"
C_BOLD="${ESC}[1m"
C_DIM="${ESC}[38;5;242m"
C_CYAN="${ESC}[38;5;81m"
C_GREEN="${ESC}[38;5;120m"
C_WHITE="${ESC}[38;5;255m"

CONFIG_DIR="$HOME/.config/opencode"
AGENT_FILE="$CONFIG_DIR/agent.md"
OPENCODE_JSON="$CONFIG_DIR/opencode.json"
PREFIX_BIN="/data/data/com.termux/files/usr/bin"
CLI_BIN="$PREFIX_BIN/opencode-agent"

mkdir -p "$CONFIG_DIR" "$PREFIX_BIN"

echo ""
echo -e "  ${C_CYAN}${C_BOLD}OpenCode${C_RESET} ${C_DIM}· Agent.md (Soul Prompt) Setup${C_RESET}"
echo ""

# 1. Create agent.md if not exists
if [ ! -f "$AGENT_FILE" ]; then
    echo -e "  ${C_CYAN}›${C_RESET} Men-generate template dasar agent.md..."
    cat << 'EOF' > "$AGENT_FILE"
# Workspace Identity & Soul

You are an expert AI software engineer, systems architect, and personal assistant.
Your operating principles:

## 1. Tone & Persona
- Direct, concise, technical, and outcome-oriented.
- Zero fluff, no unsolicited preambles, and no conversational filler ("Certainly!", "I hope this helps!").
- Lead with the solution, followed by necessary mechanics and architecture.

## 2. Engineering Standards
- Write clean, modular, and type-safe code.
- Prioritize high performance, zero-copy memory patterns, and minimal latency.
- Handle edge cases, runtime exceptions, and input validation proactively.
- Never substitute stubs, placeholders, or pseudocode for working implementations.
EOF
else
    echo -e "  ${C_GREEN}✓${C_RESET} File agent.md yang ada tetap dipertahankan."
fi

# Mirror to AGENTS.md for ambient discovery
cp "$AGENT_FILE" "$CONFIG_DIR/AGENTS.md" 2>/dev/null || true

# 2. Hardwire into opencode.json so OpenCode injects agent.md into every turn
echo -e "  ${C_CYAN}›${C_RESET} Menghubungkan agent.md ke opencode.json..."

python3 - << 'PY' 2>/dev/null || node - << 'JS' 2>/dev/null || true
import json, os

path = os.path.expanduser("~/.config/opencode/opencode.json")
cfg = {}
if os.path.exists(path):
    try:
        with open(path, "r") as f:
            cfg = json.load(f)
    except:
        pass

cfg["$schema"] = cfg.get("$schema", "https://opencode.ai/config.json")

# Add to instructions
instructions = cfg.get("instructions", [])
rule = "{file:~/.config/opencode/agent.md}"
if rule not in instructions:
    instructions.insert(0, rule)
cfg["instructions"] = instructions

# Add to build agent prompt
agent = cfg.get("agent", {})
build = agent.get("build", {})
build["prompt"] = "{file:~/.config/opencode/agent.md}"
agent["build"] = build
cfg["agent"] = agent

with open(path, "w") as f:
    json.dump(cfg, f, indent=2)
PY
const fs = require("fs");
const path = process.env.HOME + "/.config/opencode/opencode.json";
let cfg = {};
try { cfg = JSON.parse(fs.readFileSync(path, "utf8")); } catch(e){}
cfg.$schema = cfg.$schema || "https://opencode.ai/config.json";
cfg.instructions = cfg.instructions || [];
const rule = "{file:~/.config/opencode/agent.md}";
if (!cfg.instructions.includes(rule)) {
    cfg.instructions.unshift(rule);
}
cfg.agent = cfg.agent || {};
cfg.agent.build = cfg.agent.build || {};
cfg.agent.build.prompt = rule;
fs.writeFileSync(path, JSON.stringify(cfg, null, 2));
JS

# 3. Install CLI helper 'opencode-agent'
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd || echo "")"
if [ -n "$SCRIPT_DIR" ] && [ -f "$SCRIPT_DIR/bin/opencode-agent" ]; then
    cp "$SCRIPT_DIR/bin/opencode-agent" "$CLI_BIN" 2>/dev/null || true
else
    curl -fsSL "https://raw.githubusercontent.com/rndsa/opencode-agents/main/bin/opencode-agent?v=$(date +%s)" -o "$CLI_BIN" 2>/dev/null || true
fi
chmod +x "$CLI_BIN" 2>/dev/null || true

echo ""
echo -e "  ${C_GREEN}${C_BOLD}✓ Berhasil terpasang!${C_RESET}"
echo -e "  OpenCode sekarang otomatis membaca ${C_CYAN}agent.md${C_RESET} di setiap request ke AI."
echo ""
echo -e "  ${C_WHITE}Lokasi file :${C_RESET} ${C_CYAN}$AGENT_FILE${C_RESET}"
echo -e "  ${C_WHITE}Perintah CLI:${C_RESET} ${C_CYAN}opencode-agent${C_RESET} ${C_DIM}(kelola/edit soul prompt)${C_RESET}\n"
