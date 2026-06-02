# 豆包单击 fn 录音状态机调整

## Brief

## Task ID

`TASK-2026-06-02-001-single-fn-doubao`

## 创建日期

2026-06-02

## 目标结果

仓库快照恢复为适配豆包语音输入“单击 `fn` 开始/停止录音”的 Karabiner 触发语义，同时保留当前状态机清理和 GUI fallback 稳定性补丁。

## 边界

- 范围内：`snapshots/fn-dictation-rule.json`、当前行为说明文档、任务证据记录。
- 范围外：live 本机 `~/.config` 路径、Karabiner 当前 profile、`dictation-enter.sh` 稳定性逻辑重写。
- 停止条件：如果需要真实 live 冒烟或恢复到 live 配置，必须由用户明确授权。

## 执行合同

- Owner：coordinator
- 生命周期状态：closed-local-only
- 必需文件：`task_plan.md`、`visual_map.md`、`progress.md`
- 完成条件：JSON 结构检查通过，任务进度记录证据，相关说明文档同步。

## 第一步

对照历史提交和当前 snapshot，确认双击展开来源与单击调整范围。
