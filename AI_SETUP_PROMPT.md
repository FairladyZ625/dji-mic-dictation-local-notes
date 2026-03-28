# AI Setup Prompt

Copy the block below into an AI coding agent on a new Mac.

```text
You are on a macOS machine.

Your job is to restore the local DJI Mic Mini dictation setup from this repository.

Repository goal:
- restore the exact local working state for `dji-mic-dictation`
- do not redesign the workflow
- prefer copying the snapshotted files directly

Repository files to use:
- README.md
- CURRENT_STATE.md
- RECOVERY_AND_TUNING.md
- scripts/restore-live-config.sh
- snapshots/reset-state.sh
- snapshots/micReset
- snapshots/dictation-enter.sh
- snapshots/fn-dictation-rule.json
- snapshots/config.env
- snapshots/install-state.json

What to do:
1. Read README.md, CURRENT_STATE.md, and RECOVERY_AND_TUNING.md.
2. Verify these live paths exist or can be created:
   - ~/.config/dji-mic-dictation/
   - ~/.config/karabiner/scripts/
   - ~/.local/bin/
3. Run ./scripts/restore-live-config.sh
4. Verify:
   - command -v micReset
   - micReset
   - karabiner_cli --show-current-profile-name
5. Do not reinstall Karabiner unless the machine is clearly missing it.
6. Do not overwrite unrelated Karabiner rules outside the snapshotted dictation flow.
7. Report back:
   - what files were restored
   - whether micReset works
   - whether any manual macOS permission step is still required
```
