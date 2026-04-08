# DJI Mic Dictation Local Notes

An open-source, machine-verified reference repo for a working `DJI Mic Mini + Karabiner + dji-mic-dictation` setup on macOS.

它不是上游 `Johnixr/dji-mic-dictation` 的 fork，也不是替代品。
它的定位是：

- 记录这台 Mac 上已经验证通过的本地改造
- 保存 live 脚本和配置快照
- 提供一个可复刻、可交接、可继续调参的基线
- 避免以后只能回聊天记录里翻

## Upstream Reference

- Upstream project: <https://github.com/Johnixr/dji-mic-dictation>

## 当前本机路径

- `dji-mic-dictation` 配置目录：`~/.config/dji-mic-dictation/`
- 主脚本：`~/.config/karabiner/scripts/dictation-enter.sh`
- Karabiner CLI：`/Library/Application Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli`
- 用户重置命令：`~/.local/bin/micReset`

## 当前行为

- `Fn` 单按一次会被 Karabiner 映射成一组带间隔的双击 `fn`
- DJI Mic Mini 按钮走同一套开始/结束逻辑
- `micReset` 可以在状态机乱掉时一键清理 `/tmp/dji-dictation`
- 当前 GUI 发送方式为 `key code 36`
- 当前 GUI 手动发送 fallback 阈值为 `1.5s`
- 当前 review/send window 配置为 `3s`
- 当前无记录等待上限约为 `8s`

## One-command Restore

This repo now includes a local restore helper:

```bash
./scripts/restore-live-config.sh
```

It copies the snapshotted files in this repo back to the live local paths:

- `~/.config/dji-mic-dictation/reset-state.sh`
- `~/.local/bin/micReset`
- `~/.config/dji-mic-dictation/config.env`
- `~/.config/dji-mic-dictation/install-state.json`
- `~/.config/karabiner/scripts/dictation-enter.sh`

## Copy To AI

如果你想让另一个 AI 直接帮你在新电脑上复刻，优先把这份提示词整段复制给它：

- [AI_SETUP_PROMPT.md](./AI_SETUP_PROMPT.md)

如果你更希望 AI 直接看恢复脚本，也可以让它参考：

- [scripts/restore-live-config.sh](./scripts/restore-live-config.sh)

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
- [scripts/restore-live-config.sh](./scripts/restore-live-config.sh)
  把当前仓库快照恢复到 live 本机路径的辅助脚本。
- [AI_SETUP_PROMPT.md](./AI_SETUP_PROMPT.md)
  给 AI 直接执行的复刻提示词。

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

这轮修复后，仓库里的快照还包含这些稳定性补丁：

- `cleanup()` 同步清 Karabiner 变量，避免 HUD 超时后下一次按键还被误判成 `preconfirm`
- `save` 分支主动写回 `dji_dictation_active=1`，避免 shell 和 Karabiner 异步竞态
- GUI 发送默认走 `key code 36`

## License

MIT. See [LICENSE](./LICENSE).
