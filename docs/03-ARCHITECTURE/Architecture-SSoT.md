# 架构事实源 / Architecture SSoT

Context Doc Type: architecture-ssot
Owner: project coordinator
Last Verified: 2026-06-02
Confidence: medium

## System Summary

本仓库保存这台 Mac 上已经验证可用的 `DJI Mic Mini + Karabiner + dji-mic-dictation` 本机配置、恢复脚本和复刻说明。它不是上游 `Johnixr/dji-mic-dictation` 的 fork，也不承载运行时服务；主要作用是让未来的 Agent 或用户能从仓库快照恢复 live 配置，并继续调参。

## Current Architecture Facts

| ID | Fact | Source Evidence | Last Verified | Confidence | Read Before |
| --- | --- | --- | --- | --- | --- |
| ARCH-001 | 仓库定位是本机配置基线和恢复资料，不是上游项目 fork。 | `README.md` | 2026-05-22 | high | `README.md` |
| ARCH-002 | live 配置路径包括 `~/.config/dji-mic-dictation/`、Karabiner 脚本路径和 `~/.local/bin/micReset`。 | `CURRENT_STATE.md` | 2026-05-22 | high | `CURRENT_STATE.md` |
| ARCH-003 | 恢复入口是 `./scripts/restore-live-config.sh`，它把 `snapshots/` 文件复制回 live 本机路径。 | `README.md`; `scripts/restore-live-config.sh` | 2026-05-22 | high | `scripts/restore-live-config.sh` |
| ARCH-004 | 当前关键行为包含单击 `fn` 触发、GUI manual send fallback、timeout cleanup 和最终发送后强制收口。 | `README.md`; `CURRENT_STATE.md` | 2026-06-02 | high | `CURRENT_STATE.md`; `snapshots/dictation-enter.sh` |

## Promotion Log

| Source Task | Promoted Fact | Destination | Decision | Date |
| --- | --- | --- | --- | --- |
| README install smoke | 初始架构事实从现有 README/CURRENT_STATE 投影到 Harness Architecture SSoT。 | `docs/03-ARCHITECTURE/Architecture-SSoT.md` | accepted | 2026-05-22 |
| TASK-2026-06-02-001-single-fn-doubao | 豆包语音输入恢复为单击 `fn` 开始/停止录音，仓库 snapshot 不再展开双击 `fn`。 | `docs/03-ARCHITECTURE/Architecture-SSoT.md` | accepted | 2026-06-02 |
