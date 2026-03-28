# Task Plan: DJI Mic Dictation Local Notes Repo

## Goal

Create a standalone local git repository under `/Users/lizeyu/Projects` that captures the working `dji-mic-dictation` setup, scripts, local overrides, and tuning notes for this Mac.

## Phases

- [x] Create standalone repo
- [x] Snapshot current local scripts and config
- [x] Write operator-facing documentation
- [ ] Commit initial state

## Key Questions

1. Which files are true local sources of behavior and should be snapshotted?
2. Which timing and fallback changes matter enough to document for future recovery?

## Decisions Made

- Repository is outside Agora and lives at `/Users/lizeyu/Projects/dji-mic-dictation-local-notes`
- Snapshot the live local files instead of paraphrasing them from memory
- Record both behavior and rationale, not just file paths

## Errors Encountered

- `micReset` originally used `rm -f` on `send_consumed.lock`, but runtime creates that as a directory. Fixed to `rm -rf`.

## Status

Currently in finalization: documentation and snapshots are in place, initial commit pending.
