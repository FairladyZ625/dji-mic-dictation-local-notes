# Current State

## Machine Scope

- Host: this Mac only
- Purpose: persist the working local setup for `DJI Mic Mini + Karabiner + dji-mic-dictation`
- Upstream base: `Johnixr/dji-mic-dictation`

## Active Paths

- Config dir: `~/.config/dji-mic-dictation/`
- Karabiner script: `~/.config/karabiner/scripts/dictation-enter.sh`
- Karabiner CLI: `/Library/Application Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli`
- User command: `~/.local/bin/micReset`

## Active Settings

- Karabiner profile: `Default profile`
- Trigger mode: `keyboard+dji`
- Notification sound: `Sosumi`
- Ready HUD: enabled
- Review/send window: `3s`
- Manual GUI confirm fallback: `1.2s`

## Active Local Overrides

### 1. User-level reset command

- `~/.config/dji-mic-dictation/reset-state.sh`
- `~/.local/bin/micReset`

Purpose:

- clear `/tmp/dji-dictation` runtime state
- clear Karabiner state variables `dji_watching` and `dji_ready_to_send`

### 2. Single press mapped to spaced double `fn`

Current local Karabiner rule no longer emits one `fn`.
It emits:

1. `fn` with `hold_down_milliseconds: 80`
2. `vk_none` with `hold_down_milliseconds: 80`
3. `fn` with `hold_down_milliseconds: 80`

This is applied to:

- keyboard start dictation
- keyboard stop dictation
- DJI start dictation
- DJI stop dictation

Snapshot:

- [snapshots/fn-dictation-rule.json](./snapshots/fn-dictation-rule.json)

### 3. GUI-mode manual send fallback

Typeless is no longer treated as the only completion source.

Current local script behavior:

- if GUI mode does not observe a Typeless transcript completion
- and elapsed time since `save_ts` is at least `1.2s`
- the next `preconfirm` press is treated as a manual send fallback

This is the local adaptation that made the new input method usable without depending on Typeless DB updates.

Snapshot:

- [snapshots/dictation-enter.sh](./snapshots/dictation-enter.sh)

## Validation Commands

```bash
karabiner_cli --show-current-profile-name
karabiner_cli --list-connected-devices
command -v micReset
micReset
```
