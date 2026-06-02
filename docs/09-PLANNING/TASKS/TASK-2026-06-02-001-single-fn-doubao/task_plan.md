# 豆包单击 fn 录音状态机调整

Task Contract: harness-task/v1

## 目标

把仓库中的 Karabiner 快照从一次真实按键展开成双击 `fn`，调整为一次真实按键只发送单次 `fn`。

## 范围

- 做什么：更新 `snapshots/fn-dictation-rule.json` 的 keyboard/DJI start-stop 分支；同步 README、CURRENT_STATE、RECOVERY_AND_TUNING、notes；记录证据。
- 不做什么：不写入 live `~/.config`；不运行 restore；不改变最终发送清理逻辑。
- 主要风险：未做真实豆包录音冒烟前，只能确认仓库快照和 JSON 结构正确，不能声称 live 已恢复。

## 任务信息架构预算

选择预算：simple

## 上下文包（Context Packet）

| ID | 类型 | 路径 | 为什么需要 | 使用者 |
| --- | --- | --- | --- | --- |
| C-001 | public-doc | TARGET:README.md | 当前行为入口说明 | coordinator |
| C-002 | public-doc | TARGET:CURRENT_STATE.md | 当前本机配置事实 | coordinator |
| C-003 | code | TARGET:snapshots/fn-dictation-rule.json | Karabiner 触发状态机快照 | coordinator |
| C-004 | git-history | TARGET:git log/show | 验证历史提交中双击展开来源 | coordinator |

## Artifact Index

| Artifact ID | 类型 | 路径 | 摘要 |
| --- | --- | --- | --- |
| A-001 | command | git show / git log | 历史提交中未找到单次 `fn` snapshot；当前双击展开来自已有规则，`dji_internal_double_fn` 来自 `eb1a1de`，仍需保留为合成 `fn` 防递归 guard |
| A-002 | command | `node -e JSON.parse(...)` | 验证 Karabiner JSON 语法 |

## 步骤

1. 对照历史提交和当前规则，定位双击展开字段。
2. 将 start/stop 触发输出从 `fn -> vk_none -> fn` 收窄为 guard 包裹的单次 `fn`。
3. 同步文档当前行为和调参说明。
4. 运行 JSON 结构检查并记录证据。

## 验收标准

- [x] `snapshots/fn-dictation-rule.json` 不再包含 `vk_none` 或第二个合成 `fn`
- [x] keyboard 和 DJI start/stop 分支只输出 guard 包裹的单次 `fn`
- [x] 文档不再宣称当前规则映射成双击 `fn`
- [x] 任务 `progress.md` 记录检查证据和 live 触达边界

## 工作树（Worktree）

- 路径：当前工作区 `/Users/lizeyu/Projects/dji-mic-dictation-local-notes`
- 分支：`master`
- Worker owner：coordinator
- Worker handoff commit required：no
- Coordinator integration branch：不适用
- 未使用 worktree 的原因：单 owner 小仓快照修正，无并行 worker。

## 审查判定

- 是否需要对抗性审查：否
- Reviewer：self
- No-finding 要求：不适用

## 关联

- 功能 SSoT 条目：不适用
- 相关 Regression Gate：`docs/05-TEST-QA/Regression-SSoT.md` RG-003，live 冒烟需用户授权后执行
- 审查报告：不适用
- Harness Ledger 条目：HL-2026-06-02-001
- 前置任务：无
