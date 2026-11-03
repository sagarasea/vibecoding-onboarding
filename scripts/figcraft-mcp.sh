#!/bin/bash
# MCP FigCraft yang menempel ke aplikasi FigCraft yang sedang terbuka (macOS).
# Menyalakan FigCraft dengan control port kalau belum jalan, lalu menjalankan figcraft-cli mcp --attach.
# Daftarkan sekali:  claude mcp add --scope user figcraft -- bash "$(pwd)/scripts/figcraft-mcp.sh"
PORT="${FIGCRAFT_CONTROL_PORT:-47821}"
CLI="${FIGCRAFT_CLI:-$(command -v figcraft-cli || echo "$HOME/.local/bin/figcraft-cli")}"
if [ ! -x "$CLI" ]; then
  echo "figcraft-cli tidak ditemukan. Download dari https://getartcraft.com/apps/figcraft (Command-line tool), taruh di ~/.local/bin." >&2
  exit 1
fi
if ! nc -z 127.0.0.1 "$PORT" 2>/dev/null; then
  nohup /Applications/FigCraft.app/Contents/MacOS/FigCraft --control "$PORT" >/dev/null 2>&1 &
  for _ in $(seq 1 50); do nc -z 127.0.0.1 "$PORT" 2>/dev/null && break; sleep 0.2; done
fi
exec "$CLI" mcp --attach "$PORT"
