#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SNAPSHOT_DIR="$REPO_ROOT/snapshots"
CONFIG_DIR="$HOME/.config/dji-mic-dictation"
KARABINER_SCRIPT_DIR="$HOME/.config/karabiner/scripts"
LOCAL_BIN_DIR="$HOME/.local/bin"

mkdir -p "$CONFIG_DIR" "$KARABINER_SCRIPT_DIR" "$LOCAL_BIN_DIR"

cp "$SNAPSHOT_DIR/reset-state.sh" "$CONFIG_DIR/reset-state.sh"
cp "$SNAPSHOT_DIR/micReset" "$LOCAL_BIN_DIR/micReset"
cp "$SNAPSHOT_DIR/config.env" "$CONFIG_DIR/config.env"
cp "$SNAPSHOT_DIR/install-state.json" "$CONFIG_DIR/install-state.json"
cp "$SNAPSHOT_DIR/dictation-enter.sh" "$KARABINER_SCRIPT_DIR/dictation-enter.sh"

chmod +x \
  "$CONFIG_DIR/reset-state.sh" \
  "$LOCAL_BIN_DIR/micReset" \
  "$KARABINER_SCRIPT_DIR/dictation-enter.sh"

echo "Restored live dji-mic-dictation files from snapshots."
echo "Next:"
echo "  command -v micReset"
echo "  micReset"
echo "  karabiner_cli --show-current-profile-name"
