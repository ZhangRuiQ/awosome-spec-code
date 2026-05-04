# Code Copilot - 快速开始指南

## 工具选择指南

根据你的开发环境选择合适的工具：

| 工具 | 适用场景 | 特点 |
|------|----------|------|
| **Cursor** | IDE 重度用户 | GUI 友好，上手快，自动读取 `.cursorrules` |
| **Claude Code** | 终端爱好者 | Anthropic 官方，模型绑定 Claude，功能强大 |
| **opencode** | 多模型需求 | 开源，模型自由选择，社区驱动 |

## Cursor 快速开始

### 安装框架

#### 方式 1：使用安装脚本（推荐）

```bash
cd your-project
bash /path/to/awosome-spec-code/code-copilot/init/setup.sh
```

#### 方式 2：手动复制

```bash
cd your-project
cp -r /path/to/awosome-spec-code/code-copilot .
cp code-copilot/init/cursor/.cursorrules .
```

### 开始使用

1. 用 Cursor 打开项目
2. 按 `Cmd/Ctrl + L` 打开 AI 对话
3. 输入命令开始工作

### 常用命令

```
/init                           # 初始化项目上下文
/propose 实现用户登录功能      # 创建变更提案
/apply feature-user-auth       # 执行编码
/review feature-user-auth      # 两阶段审查
/archive feature-user-auth     # 归档变更
```

## Claude Code 快速开始

### 安装框架

#### 方式 1：使用安装脚本（推荐）

```bash
cd your-project
bash /path/to/awosome-spec-code/code-copilot/init/setup.sh
```

#### 方式 2：手动复制

```bash
cd your-project
cp -r /path/to/awosome-spec-code/code-copilot .
cp code-copilot/init/claude/CLAUDE.md .
```

### 开始使用

1. 在终端中进入项目目录
2. 启动 Claude Code：`claude`
3. 系统会自动读取 `CLAUDE.md` 中的配置

### 常用命令

```bash
claude                          # 启动，自动加载 CLAUDE.md
/init                           # 初始化项目
/propose "实现用户登录功能"      # 创建变更提案
/apply feature-user-auth       # 执行编码
/review feature-user-auth      # 审查
```

### 全局安装（可选）

```bash
# 复制系统提示词到全局配置
mkdir -p ~/.config/claude
cp code-copilot/init/claude/CLAUDE.md ~/.config/claude/

# 设置全局系统提示词
claude config set system_prompt_file ~/.config/claude/CLAUDE.md
```

## opencode 快速开始

### 安装框架

#### 方式 1：使用安装脚本（推荐）

```bash
cd your-project
bash /path/to/awosome-spec-code/code-copilot/init/setup.sh
```

#### 方式 2：手动复制

```bash
cd your-project
cp -r /path/to/awosome-spec-code/code-copilot .
cp code-copilot/init/opencode/opencode.yaml .
```

### 开始使用

1. 确保已安装 opencode：`npm install -g opencode`
2. 在终端中进入项目目录
3. 启动 opencode：`opencode`
4. 系统会自动读取 `opencode.yaml` 中的配置

### 常用命令

```bash
opencode                        # 启动，自动加载配置
/init                           # 初始化项目
/propose "实现用户登录功能"      # 创建变更提案
/apply feature-user-auth       # 执行编码
/review feature-user-auth      # 审查
```

### 指定配置文件

```bash
opencode --config opencode.yaml
```

## 首次使用流程

无论使用哪种工具，首次使用的标准流程都是：

### 第 1 步：初始化项目（一次性）

```
/init
```

AI 会分析你的工程结构并填充 `code-copilot/rules/project-context.md`。

### 第 2 步：创建第一个变更

```
/propose 实现一个简单的用户登录功能
```

AI 会：
1. Research 现有代码
2. 提问澄清需求
3. 生成 Spec
4. 拆分 Tasks
5. 等待你确认

### 第 3 步：执行编码

```
/apply feature-user-auth
```

AI 会按 Tasks 逐个执行，每个 Task 完成后等你确认。

### 第 4 步：审查

```
/review feature-user-auth
```

AI 会进行两阶段审查：Spec 合规 + Code Quality。

### 第 5 步：归档

```
/archive feature-user-auth
```

AI 会展示知识发现，询问是否沉淀到 knowledge/。

## 常见问题

### Q: 可以在多个工具中使用同一个框架吗？

可以。框架是工具无关的，你可以：
- 用 Cursor 做日常开发
- 用 Claude Code 处理复杂任务
- 用 opencode 测试不同模型

它们都读取相同的 `code-copilot/` 目录。

### Q: 如何更新框架？

1. 获取最新版本的 `code-copilot/`
2. 覆盖你项目中的旧版本
3. 保留你的 `changes/` 和 `knowledge/` 目录（不要在覆盖时删除）

### Q: 团队如何共享配置？

1. 将 `code-copilot/` 提交到 Git 仓库
2. 团队成员克隆后直接使用
3. 每个人的 `changes/` 和 `knowledge/` 可以在 `.gitignore` 中排除，或提交共享知识

## 进阶配置

### 自定义规则

编辑 `code-copilot/rules/` 下的文件，添加：
- 项目特定的编码规范
- 业务领域规则
- 安全红线

### 沉淀知识

在开发过程中，遇到有价值的发现时，AI 会建议沉淀到 `knowledge/`。这些知识会被后续需求复用。

### 模板定制

编辑 `code-copilot/changes/templates/` 下的模板，适应你的团队需求。

## 获取帮助

在 AI 对话中输入：

```
帮助
```

或查看完整文档：
- [框架详细说明](README.md)
- [原文指南](https://mp.weixin.qq.com/s/7Lgb3GfgXKI0J9L9e9sq0w)
