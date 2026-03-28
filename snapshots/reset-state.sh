#!/usr/bin/env bash
set -euo pipefail

STATE_DIR="/tmp/dji-dictation"
KARABINER_CLI="/Library/Application Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli"

rm -f \
  "$STATE_DIR/mode" \
  "$STATE_DIR/pane_id" \
  "$STATE_DIR/watcher.pid" \
  "$STATE_DIR/pending_confirm" \
  "$STATE_DIR/save_ts" \
  "$STATE_DIR/db_anchor_rowid" \
  "$STATE_DIR/db_anchor_updated_at" \
  "$STATE_DIR/ready_hud.pid" \
  "$STATE_DIR/session_id" \
  "$STATE_DIR/window_deadline" \
  "$STATE_DIR/save_in_progress"

rm -rf "$STATE_DIR/send_consumed.lock"

if [ -x "$KARABINER_CLI" ]; then
  "$KARABINER_CLI" --set-variables '{"dji_watching":0,"dji_ready_to_send":0}'
fi

echo "dji-mic-dictation state reset"
