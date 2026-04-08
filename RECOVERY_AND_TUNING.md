# Recovery And Tuning

## Recovery

When the local state machine gets stuck, run:

```bash
micReset
```

That command executes [snapshots/reset-state.sh](./snapshots/reset-state.sh), whose live target is:

- `~/.config/dji-mic-dictation/reset-state.sh`

It currently does two things:

1. remove runtime files under `/tmp/dji-dictation`
2. reset Karabiner variables:
   - `dji_dictation_active=0`
   - `dji_watching=0`
   - `dji_ready_to_send=0`

## Why A Separate Reset Script Exists

The upstream install gave a good base, but the local workflow accumulated runtime state in `/tmp/dji-dictation`.

Once that state drifted, the quickest fix was not reinstalling Karabiner or rewriting rules. It was a user-level reset command that:

- does not touch installation files
- does not rewrite Karabiner profiles
- only clears runtime state

## Why Single Press Was Remapped

The new input method expects:

- double press to start
- double press to stop

Instead of rewriting the whole workflow, the local Karabiner rule was narrowed to one behavior change:

- one real press now emits a spaced double `fn`

This preserved:

- existing `save`
- existing `watch`
- existing `preconfirm`
- existing `confirm`

and only changed the start/stop trigger shape.

## Why Manual GUI Fallback Was Added

The original script relied on Typeless DB updates to determine that transcription had completed.

After switching input method, that assumption stopped holding. The result was:

- start/stop could still work
- final send never entered `confirm`
- the last button press kept being treated as `preconfirm queued`

So the local fallback was added:

- only in `gui` mode
- only when transcript completion is not observed
- if enough time has passed since `save_ts`, a `preconfirm` press is upgraded to manual send

## Current Timers

There are two different timers worth knowing:

### 1. Manual GUI confirm fallback

Current value:

- `1.5s`

Meaning:

- after stopping voice input, the script waits at least `1.2s`
- after that, a `preconfirm` press can directly send `Enter` even without Typeless completion

Location:

- [snapshots/dictation-enter.sh](./snapshots/dictation-enter.sh)

Search key:

- `DJI_MANUAL_CONFIRM_FALLBACK_SECONDS`

### 2. Review/send window

Current value:

- `3s`

Meaning:

- once content is considered ready, the ready-to-send confirm window lasts `3s`

Source:

- [snapshots/config.env](./snapshots/config.env)

Search key:

- `DJI_REVIEW_WINDOW_SECONDS`

## If You Need To Tune Again

### Make manual send more conservative

Raise:

- `MANUAL_CONFIRM_FALLBACK_SECONDS`

Good candidates:

- `1.5`
- `2.0`

Use this when the input method still performs a late recognition optimization after recording stops.

### Make press-to-send window longer

Raise:

- `DJI_REVIEW_WINDOW_SECONDS`

Good candidates:

- `3`
- `4`
- `5`
- `10`

Use this when you can already enter ready-to-send state, but the confirm window expires too quickly.

### Reduce dead-air wait before cleanup

Current values:

- `WATCH_MAX_POLLS=80`
- `WATCH_POLL_INTERVAL=0.1`
- `NO_RECORD_LOG_AFTER_POLLS=50`

Meaning:

- if no usable completion signal arrives, the GUI path times out in about `8s`
- a “still no record” log appears around `5s`

Use this when HUD should disappear faster after a failed recognition round.

### Reset after every tuning change

```bash
micReset
```
