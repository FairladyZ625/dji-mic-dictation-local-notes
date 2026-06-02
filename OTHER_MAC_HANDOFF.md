# Other Mac Handoff

This handoff is for applying the current `DJI Mic Mini + Karabiner + dji-mic-dictation` setup on another Mac after Doubao voice input changed back to single `fn` start/stop.

## What Changed

- The repository snapshot now emits one synthetic `fn` per keyboard/DJI start-stop trigger.
- The old spaced double sequence `fn -> vk_none -> fn` was removed.
- `dji_internal_double_fn` is intentionally still used as an internal guard so Karabiner does not recursively capture its own synthetic `fn`.
- The local script/config restore path is still `./scripts/restore-live-config.sh`.

## Update The Repo

If the repo already exists:

```bash
cd ~/Projects/dji-mic-dictation-local-notes
git pull --ff-only
```

If the repo is missing:

```bash
mkdir -p ~/Projects
cd ~/Projects
git clone git@github.com:FairladyZ625/dji-mic-dictation-local-notes.git
cd dji-mic-dictation-local-notes
```

## Apply Live Local Files

This copies the snapshotted shell scripts and dji-mic config into the live local paths:

```bash
./scripts/restore-live-config.sh
```

Then reset runtime state:

```bash
command -v micReset
micReset
```

## Apply The Karabiner Rule

The restore script does not edit `~/.config/karabiner/karabiner.json`.
Apply `snapshots/fn-dictation-rule.json` to the active Karabiner profile manually or with a structured JSON update.

Expected live rule:

- profile: `Default profile`
- rule description: `Fn dictation toggle + confirm/preconfirm to send Enter`
- start/stop trigger output: one `fn`
- no `vk_none`
- `dji_internal_double_fn` present as a guard

After updating Karabiner, run:

```bash
micReset
```

Then test:

1. Press `fn` or the DJI Mic Mini button once.
2. Doubao should start recording.
3. Press once again.
4. Doubao should stop recording and the local state machine should continue into watch/send flow.

## Quick Verification

```bash
node - <<'NODE'
const fs = require('fs');
const path = `${process.env.HOME}/.config/karabiner/karabiner.json`;
const j = JSON.parse(fs.readFileSync(path, 'utf8'));
const profile = j.profiles.find((p) => p.selected) || j.profiles[0];
const rule = profile.complex_modifications.rules.find((r) => r.description === 'Fn dictation toggle + confirm/preconfirm to send Enter');
const text = JSON.stringify(rule);
console.log('profile', profile.name);
console.log('vk_none', /vk_none/.test(text));
console.log('internal_guard', /dji_internal_double_fn/.test(text));
const startsStops = rule.manipulators.filter((m) => {
  const cmd = JSON.stringify(m.to || []) + JSON.stringify(m.to_if_alone || []);
  return /fn-save|fn-open-window|dji-save|dji-open-window/.test(cmd);
});
console.log(startsStops.map((m) => (m.to || []).filter((t) => t.key_code).map((t) => t.key_code).join(',')).join(' | '));
NODE
```

Expected output shape:

```text
profile Default profile
vk_none false
internal_guard true
fn | fn | fn | fn
```

## If It Fails

Inspect the local state log:

```bash
tail -80 /tmp/dji-dictation/debug.log
```

If repeated `preconfirm ignored no_active_session` appears after a DJI press, the Karabiner rule is probably missing the `dji_internal_double_fn` guard around the synthetic single `fn`.
