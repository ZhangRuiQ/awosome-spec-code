# IDE 适配层

本目录包含 Code Copilot 框架对各种 AI 编码工具的适配配置。

## 支持的 IDE 工具

| 工具 | 目录 | 配置文件 | 适用场景 |
|------|------|----------|----------|
| **Cursor** | `cursor/` | `.cursorrules` | IDE 重度用户，GUI 友好 |
| **Claude Code** | `claude/` | `CLAUDE.md` | 终端爱好者，Anthropic 官方 |
| **opencode** | `opencode/` | `opencode.yaml` | 多模型需求，开源社区驱动 |

## 快速使用

### 方式 1：使用安装脚本（推荐）

在项目根目录执行：

```bash
# Linux/Mac
bash /path/to/code-copilot/.code-copilot/ide-adapters/setup.sh

# Windows
powershell /path/to/code-copilot/.code-copilot/ide-adapters/setup.ps1
```

脚本会自动：
1. 复制 `.code-copilot/` 框架到项目
2. 检测你使用的 IDE 工具
3. 自动复制对应的配置文件到项目根目录

### 方式 2：手动复制

根据你使用的工具，手动复制对应的配置文件：

#### Cursor

```bash
cp /path/to/.code-copilot/ide-adapters/cursor/.cursorrules your-project/
```

将 `.cursorrules` 放在项目根目录，Cursor 会自动识别并加载。

#### Claude Code

```bash
cp /path/to/.code-copilot/ide-adapters/claude/CLAUDE.md your-project/
```

将 `CLAUDE.md` 放在项目根目录，启动 `claude` 时会自动加载。

##### 全局配置（可选）

```bash
# 复制到全局配置目录
mkdir -p ~/.config/claude
cp CLAUDE.md ~/.config/claude/

# 设置全局系统提示词
claude config set system_prompt_file ~/.config/claude/CLAUDE.md
```

#### opencode

```bash
cp /path/to/.code-copilot/ide-adapters/opencode/opencode.yaml your-project/
```

将 `opencode.yaml` 放在项目根目录，启动 `opencode` 时会自动加载。

##### 指定配置文件

```bash
opencode --config opencode.yaml
```

## 配置说明

### Cursor (.cursorrules)

- **作用**：Cursor 的 AI 助手系统提示词
- **加载时机**：打开项目时自动加载
- **生效范围**：当前项目的所有 AI 对话
- **官方文档**：[Cursor Rules](https://docs.cursor.com/context/rules)

### Claude Code (CLAUDE.md)

- **作用**：Claude Code 的系统提示词
- **加载时机**：启动 `claude` 时自动读取当前目录的 CLAUDE.md
- **生效范围**：当前会话
- **官方文档**：[Claude Code 文档](https://docs.anthropic.com/en/docs/agents-and-tools/claude-code/overview)

### opencode (opencode.yaml)

- **作用**：opencode 的完整配置，包括系统提示词和自定义命令
- **加载时机**：启动 `opencode` 时自动加载
- **生效范围**：当前项目
- **官方文档**：[opencode 文档](https://opencode.ai/docs/)

## 多工具共存

你可以同时在项目中配置多个工具：

```
your-project/
├── .code-copilot/              # 核心框架
├── .cursorrules               # Cursor 配置
├── CLAUDE.md                  # Claude Code 配置
├── opencode.yaml              # opencode 配置
└── src/
```

根据场景切换工具：
- **日常开发**：Cursor（GUI 友好）
- **复杂任务**：Claude Code（终端操作更灵活）
- **模型对比**：opencode（切换不同模型测试效果）

## 自定义配置

### 修改系统提示词

编辑对应工具目录下的配置文件：
- `cursor/.cursorrules`
- `claude/CLAUDE.md`
- `opencode/opencode.yaml`

### 添加新工具支持

1. 在 `ide-adapters/` 下创建新目录（如 `new-tool/`）
2. 添加配置文件
3. 更新 `setup.sh` 和 `setup.ps1` 添加检测逻辑
4. 更新本 README 添加说明

## 故障排查

### Cursor 没有读取 .cursorrules

- 确认文件在项目根目录
- 检查文件名是否正确（注意点前缀）
- 重启 Cursor 或重新打开项目

### Claude Code 没有加载 CLAUDE.md

- 确认文件在项目根目录
- 检查文件名是否正确（全大写）
- 尝试显式指定：`claude --system-prompt CLAUDE.md`

### opencode 配置未生效

- 确认文件在项目根目录
- 检查 YAML 格式是否正确
- 尝试显式指定：`opencode --config opencode.yaml`

## 参考

- [Cursor 官方文档](https://docs.cursor.com/)
- [Claude Code 官方文档](https://docs.anthropic.com/en/docs/agents-and-tools/claude-code/overview)
- [opencode 官方文档](https://opencode.ai/docs/)
