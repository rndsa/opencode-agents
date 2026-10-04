#!/data/data/com.termux/files/usr/bin/bash
# ==============================================================================
# OpenCode Agents Installer & Auto MT Manager Linker
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

# Clean screen
clear 2>/dev/null || true
printf "\033[H\033[2J\033[3J"

# Zinc / OpenCode Colors
ESC="\033"
C_RESET="${ESC}[0m"
C_BOLD="${ESC}[1m"
C_DIM="${ESC}[38;5;242m"
C_CYAN="${ESC}[38;5;81m"
C_GREEN="${ESC}[38;5;120m"
C_WHITE="${ESC}[38;5;255m"

AGENTS_DIR="$HOME/.config/opencode/agents"
PREFIX_BIN="/data/data/com.termux/files/usr/bin"
AGENT_BIN="$PREFIX_BIN/opencode-agents"
MT_STORAGE_FILE="/sdcard/agent.md"

mkdir -p "$AGENTS_DIR"

echo ""
echo -e "  ${C_CYAN}${C_BOLD}OpenCode${C_RESET} ${C_DIM}v2.0.19 · Auto Agents Setup${C_RESET}"
echo ""

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd || echo "")"

# 1. Sync Agent Templates
echo -e "  ${C_CYAN}›${C_RESET} Memasang 7 template agent resmi..."
TEMPLATES=(
    "builder"
    "reviewer"
    "architect"
    "security-audit"
    "ui-designer"
    "debugger"
    "documenter"
)

for t in "${TEMPLATES[@]}"; do
    target="$AGENTS_DIR/$t.md"
    if [ -n "$SCRIPT_DIR" ] && [ -f "$SCRIPT_DIR/agents/$t.md" ]; then
        cp "$SCRIPT_DIR/agents/$t.md" "$target"
    else
        curl -fsSL "https://raw.githubusercontent.com/rndsa/opencode-agents/main/agents/$t.md?v=$(date +%s)" -o "$target" 2>/dev/null || true
    fi
done

# If no active agent.md exists, set builder as default
if [ ! -f "$AGENTS_DIR/agent.md" ]; then
    cp "$AGENTS_DIR/builder.md" "$AGENTS_DIR/agent.md"
fi

# 2. Install CLI binary
echo -e "  ${C_CYAN}›${C_RESET} Memasang tools 'opencode-agents' ke terminal..."
if [ -n "$SCRIPT_DIR" ] && [ -f "$SCRIPT_DIR/bin/opencode-agents" ]; then
    cp "$SCRIPT_DIR/bin/opencode-agents" "$AGENT_BIN" 2>/dev/null || true
    chmod +x "$AGENT_BIN" 2>/dev/null || true
else
    curl -fsSL "https://raw.githubusercontent.com/rndsa/opencode-agents/main/bin/opencode-agents?v=$(date +%s)" -o "$AGENT_BIN" 2>/dev/null || true
    chmod +x "$AGENT_BIN" 2>/dev/null || true
fi

# 3. Auto-link to MT Manager / Internal Storage
echo -e "  ${C_CYAN}›${C_RESET} Menyambungkan shortcut ke MT Manager (/sdcard/agent.md)..."
if [ -d "/sdcard" ]; then
    ln -sf "$AGENTS_DIR/agent.md" "$MT_STORAGE_FILE" 2>/dev/null || cp "$AGENTS_DIR/agent.md" "$MT_STORAGE_FILE" 2>/dev/null || true
fi

echo -e "\n  ${C_GREEN}✓ Selesai! Membuka Agents Hub...${C_RESET}\n"
sleep 0.8

if [ -f "$AGENT_BIN" ]; then
    exec "$AGENT_BIN"
fi
