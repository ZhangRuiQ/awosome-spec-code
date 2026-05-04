# Awesome Spec Code

基于《2026 年 AI 编码的"渐进式 Spec"实战指南》文章。

## 目录结构

```
.
├── README.md                          # 本文件
├── code-copilot/                     # Spec 编码框架（复制到项目根目录使用）
│   ├── README.md                      # 框架说明与快速开始
│   ├── QUICKSTART.md                  # 快速开始指南
│   ├── init/                          # 安装脚本与各工具配置模板
│   │   ├── README.md                  # init 目录说明
│   │   ├── cursor/                    # Cursor 模板
│   │   │   └── .cursorrules           # Cursor 配置文件
│   │   ├── claude/                    # Claude Code 模板
│   │   │   └── CLAUDE.md              # Claude 系统提示词
│   │   ├── opencode/                  # opencode 模板
│   │   │   └── opencode.yaml          # opencode 配置
│   │   ├── setup.sh                   # Linux/Mac 安装脚本
│   │   └── setup.ps1                  # Windows 安装脚本
│   ├── agents/                        # Agent 配置与提示词（核心框架）
│   │   ├── copilot-prompt.md         # 主 Agent 完整提示词
│   │   ├── spec-reviewer.md          # Spec 合规审查 Agent
│   │   └── code-quality-reviewer.md  # 代码质量审查 Agent
│   ├── rules/                         # 项目约束（始终生效）
│   │   ├── project-context.md        # 工程结构与核心依赖
│   │   ├── coding-style.md           # 编码规范
│   │   ├── security.md               # 安全红线
│   │   └── domain-rules.md           # 业务领域约束
│   ├── knowledge/                     # 领域知识（按需加载）
│   │   └── index.md                  # 知识索引
│   └── changes/                       # 变更管理
│       ├── README.md                 # 变更管理说明
│       ├── templates/                # 模板文件
│       │   ├── spec.md               # Spec 模板
│       │   ├── tasks.md              # Tasks 模板
│       │   ├── test-spec.md          # 单测 Spec 模板
│       │   └── log.md                # Log 模板
│       └── archives/                 # 已完成变更的归档（运行时创建）
└── 2026 年 AI 编码的"渐进式 Spec"实战指南.pdf  # 原文指南
```

## 快速开始

### 多工具支持

本框架支持主流 AI 编码工具，开箱即用：

| 工具 | 配置文件 | 自动加载方式 |
|------|----------|-------------|
| **Cursor** | `.cursorrules` | 放置于项目根目录，自动生效 |
| **Claude Code** | `CLAUDE.md` | 放置于项目根目录，或执行 `claude --system-prompt CLAUDE.md` |
| **opencode** | `opencode.yaml` | 放置于项目根目录，或执行 `opencode --config opencode.yaml` |

### 1. 复制框架到项目

#### 方式 1：使用安装脚本（推荐）

```bash
# Linux/Mac
cd your-project
bash /path/to/awosome-spec-code/code-copilot/init/setup.sh

# Windows
cd your-project
powershell /path/to/awosome-spec-code/code-copilot/init/setup.ps1
```

脚本会自动检测你的 IDE 工具并创建对应配置。

示例路径中的 `awosome-spec-code` 请换为你本机克隆本仓库后的根目录名。

#### 方式 2：手动复制

```bash
# 复制框架目录
cp -r /path/to/awosome-spec-code/code-copilot your-project/

# 根据你的 IDE 选择配置文件
cp code-copilot/init/cursor/.cursorrules .     # Cursor
cp code-copilot/init/claude/CLAUDE.md .       # Claude Code
cp code-copilot/init/opencode/opencode.yaml . # opencode
```

### 2. 初始化项目

在 AI 对话中执行：

```
/init
```

AI 会分析工程结构并填充 `code-copilot/rules/project-context.md`。

### 3. 创建变更

```
/propose <需求描述>
```

AI 会：
- Research 代码现状
- 逐个提问收敛不确定性
- 分段生成 Spec（每段确认）
- 生成 Tasks
- 等待 HARD-GATE 确认

### 4. 执行编码

```
/apply <变更名>
```

AI 会：
- 检查前置条件（spec + tasks + 用户确认）
- 逐 task 执行
- 每个 task 完成后展示验证证据
- 自动 git commit（一个 task 一个 commit）

### 5. 审查

```
/review <变更名>
```

两阶段审查：
1. Spec Compliance（spec-reviewer）：逐条比对 spec 功能点与实际代码
2. Code Quality（code-quality-reviewer）：检查编码规范、安全红线

### 6. 归档

```
/archive <变更名>
```

展示知识发现，确认后沉淀到 knowledge/。

## 核心理念

### 三条铁律

1. **No Spec, No Code** — 没有文档，不准写代码
2. **Spec is Truth** — 文档和代码冲突时，错的一定是代码
3. **Reverse Sync** — 发现 Bug，先修文档，再修代码

### 渐进式复杂度

不同复杂度的需求，暴露不同深度的流程：

- **简单需求**（≤5人日）：Rules 始终生效，Spec 按需加载
- **中等需求**（5-20人日）：标准 Propose → Apply → Review 流程
- **复杂需求**（>20人日）：完整流程 + 详细设计文档

简单需求不承担复杂流程的成本——流程是可选增强，而非强制前提。

## 工作流程

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   Propose   │ -> │    Apply    │ -> │   Review    │ -> │   Archive   │
│   (提案)     │    │   (执行)     │    │   (审查)     │    │   (归档)     │
└─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘
      │                   │                   │                   │
  人主导              AI主导              Sub Agent          知识沉淀
  AI辅助              人审查              两阶段审查
```

## 命令速查

| 命令 | 作用 |
|------|------|
| `/init` | 初始化项目上下文 |
| `/propose <需求>` | 创建变更提案 |
| `/apply <变更名>` | 执行编码 |
| `/fix <变更名>` | Review 后修正迭代 |
| `/review <变更名>` | 两阶段审查 |
| `/test <变更名>` | 生成并执行单测 |
| `/archive <变更名>` | 归档 + 知识沉淀 |

## 参考

### 原文指南

- [2026 年 AI 编码的"渐进式 Spec"实战指南](https://mp.weixin.qq.com/s/7Lgb3GfgXKI0J9L9e9sq0w) — 本模板基于此指南创建

### 相关资源

- [Superpowers — agentic skills 框架](https://github.com/obra/superpowers)
- [Writing about Agentic Engineering Patterns - Simon Willison](https://simonwillison.net/2026/Feb/23/agentic-engineering-patterns/)
- [Chatbot Arena Leaderboard](https://arena.ai/)
- [opencode 官方文档](https://opencode.ai/docs/)
- [Claude Code 文档](https://docs.anthropic.com/en/docs/agents-and-tools/claude-code/overview)
