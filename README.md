# DJI Mic Dictation Local Notes

这是一份本机可用的 `dji-mic-dictation` 本地记录仓库。

目标不是替代上游项目，而是把这台 Mac 上已经验证过的实际改造、路径、脚本快照和调参记录单独收口，避免以后只能回聊天记录里翻。

## 当前本机路径

- `dji-mic-dictation` 配置目录：`~/.config/dji-mic-dictation/`
- 主脚本：`~/.config/karabiner/scripts/dictation-enter.sh`
- Karabiner CLI：`/Library/Application Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli`
- 用户重置命令：`~/.local/bin/micReset`

## 当前行为

- `Fn` 单按一次会被 Karabiner 映射成一组带间隔的双击 `fn`
- DJI Mic Mini 按钮走同一套开始/结束逻辑
- `micReset` 可以在状态机乱掉时一键清理 `/tmp/dji-dictation`
- 当前 GUI 手动发送 fallback 阈值为 `1.2s`
- 当前 review/send window 配置仍为 `3s`

## 仓库内容

- [CURRENT_STATE.md](./CURRENT_STATE.md)
  当前本机安装路径、关键脚本位置、当前调参值和实际触发语义。
- [RECOVERY_AND_TUNING.md](./RECOVERY_AND_TUNING.md)
  记录 `micReset`、双击 `fn` 映射、无 Typeless 场景下的 manual fallback 逻辑，以及后续怎么继续调参。
- [task_plan.md](./task_plan.md)
  这次沉淀工作的最小计划。
- [notes.md](./notes.md)
  关键事实和排障结论。
- [snapshots/](./snapshots)
  当前本机脚本和配置快照，包含：
  - `reset-state.sh`
  - `micReset`
  - `dictation-enter.sh`
  - `fn-dictation-rule.json`
  - `config.env`
  - `install-state.json`

## 快速操作

查看当前可执行重置命令：

```bash
command -v micReset
```

复位状态机：

```bash
micReset
```

如果以后要继续调发送时机，优先看：

- [RECOVERY_AND_TUNING.md](./RECOVERY_AND_TUNING.md)
- [snapshots/dictation-enter.sh](./snapshots/dictation-enter.sh)
- [snapshots/fn-dictation-rule.json](./snapshots/fn-dictation-rule.json)
