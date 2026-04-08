# Notes

## Verified Facts

- Live config dir exists at `~/.config/dji-mic-dictation/`
- Live Karabiner script exists at `~/.config/karabiner/scripts/dictation-enter.sh`
- Live Karabiner CLI exists at `/Library/Application Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli`
- `micReset` resolves from `~/.local/bin/micReset`
- Current selected Karabiner profile is `DJI Mic Dictation`
- Current rule uses spaced double `fn` emission via `fn -> vk_none -> fn`
- Current GUI send style is `key code 36`
- Current manual GUI send fallback threshold is `1.5s`
- Current review/send window is `3s`
- Current watch timeout is about `8s`

## Key Conclusions

- The live local setup is no longer a pure upstream install; it contains meaningful machine-specific overrides.
- The most important artifacts are not only config values but also the exact local script snapshots.
- The local recovery path should start from `micReset`, not reinstalling Karabiner.
- The major remaining failure mode was shell-state and Karabiner-variable drift; current snapshots include cleanup fixes for that.

## Files Worth Preserving

- `snapshots/reset-state.sh`
- `snapshots/micReset`
- `snapshots/dictation-enter.sh`
- `snapshots/fn-dictation-rule.json`
- `snapshots/config.env`
- `snapshots/install-state.json`
