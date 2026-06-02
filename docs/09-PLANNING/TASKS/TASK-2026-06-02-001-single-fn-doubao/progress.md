# 豆包单击 fn 录音状态机调整 - 进度

## 状态：已完成

## 进度记录

证据使用 `type:path:summary` 格式。

### 2026-06-02 19:59 - 历史与范围确认

- 做了什么：检查当前工作区、搜索 `fn`/状态机相关文件，并查看 `2706320`、`60af922`、`eb1a1de`、`afacb82` 附近的 `snapshots/fn-dictation-rule.json`。
- 验证结果：历史提交没有发现只发送单次 `fn` 的 snapshot；早期版本已经有 `fn -> vk_none -> fn` 双击展开，`dji_internal_double_fn` 防递归变量由 `eb1a1de` 引入。
- 下一步：按豆包当前“单击 fn 开始录音”事实直接收窄当前规则输出，而不是 checkout 某个历史版本。
- 证据：command:git show/log:确认历史里不存在可直接恢复的单次 `fn` 快照；command:rg:确认当前双击说明分布在 README/CURRENT_STATE/RECOVERY/notes 和 snapshot。

### 2026-06-02 20:04 - Snapshot 与 live 替换

- 做了什么：将 `snapshots/fn-dictation-rule.json` 的 keyboard/DJI start-stop 分支从双击展开收窄为单次 `fn`；同步 README、CURRENT_STATE、RECOVERY、notes、Architecture SSoT；运行恢复脚本复制 live 脚本/config；备份并替换 live `~/.config/karabiner/karabiner.json` 同名 rule。
- 验证结果：snapshot JSON 可解析且不含 `dji_internal_double_fn` / `vk_none`；live Karabiner 当前 profile 为 `Default profile`，同名 rule 9 个 manipulator，4 个 start/stop 分支输出均为单个 `fn`；`micReset` 成功执行。
- 下一步：用户实际按一次 `fn` 或 DJI 按钮确认豆包录音开始/停止。
- 证据：command:snapshots/fn-dictation-rule.json:Node JSON parse passed, markers absent, start_stop_manipulators=4, outputs=`fn`/`fn`/`fn`/`fn`；command:~/.config/karabiner/karabiner.json:backup at `/Users/lizeyu/.config/karabiner/karabiner.json.backup-20260602-200356`, live markers absent and outputs=`fn`/`fn`/`fn`/`fn`；command:micReset:`dji-mic-dictation state reset`。

### 2026-06-02 20:05 - 防递归修正

- 做了什么：根据用户反馈“第一次成功，后面没反应”检查 `/tmp/dji-dictation/debug.log`，发现合成 `fn` 被自身 `fn-preconfirm` 规则捕获，导致连续 `preconfirm ignored no_active_session`。
- 验证结果：snapshot 和 live 均恢复 `dji_internal_double_fn` guard，只移除 `vk_none` 和第二个 `fn`；4 个 start/stop 分支仍只输出一个 `fn`；`micReset` 已再次执行。
- 下一步：用户实际按键确认连续开始/停止。
- 证据：command:/tmp/dji-dictation/debug.log:出现 `dji-open-window` 后连续 `dji-preconfirm ignored no_active_session`，定位为合成 `fn` 递归；command:snapshot/live JSON:`vk_none absent`, `internal present`, start/stop outputs=`fn`。

## 残余

- 已替换 live 本机 Karabiner 规则和脚本/config；真实豆包录音冒烟仍需用户实际按键确认。
