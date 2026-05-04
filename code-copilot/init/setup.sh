#!/bin/bash
# Code Copilot 安装脚本
# 用于在目标项目中快速部署框架

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 安装到目标项目根目录下的框架目录名
CODE_COPILOT_DIR="code-copilot"

echo -e "${GREEN}Code Copilot 安装脚本${NC}"
echo "=============================="
echo ""

# 检查当前目录是否已有框架
if [ -d "$CODE_COPILOT_DIR" ]; then
    echo -e "${YELLOW}警告: 当前目录已存在 $CODE_COPILOT_DIR/ 目录${NC}"
    read -p "是否覆盖? (y/N): " confirm
    if [[ $confirm != [yY] && $confirm != [yY][eE][sS] ]]; then
        echo "安装已取消"
        exit 0
    fi
    rm -rf "$CODE_COPILOT_DIR"
fi

# 复制框架目录
echo "正在复制框架文件..."
cp -r "$(dirname "$0")/.." .

# 检测 IDE 并创建相应配置文件
echo ""
echo "正在检测 IDE 配置..."

INIT_DIR="$(dirname "$0")"

# Cursor
if [ -d ".cursor" ] || command -v cursor &> /dev/null; then
    echo -e "${GREEN}检测到 Cursor IDE${NC}"
    if [ ! -f ".cursorrules" ]; then
        cp "$INIT_DIR/cursor/.cursorrules" .
        echo -e "${GREEN}已创建 .cursorrules 文件${NC}"
    else
        echo -e "${YELLOW}.cursorrules 已存在，跳过创建${NC}"
    fi
fi

# Claude Code
if command -v claude &> /dev/null; then
    echo -e "${GREEN}检测到 Claude Code${NC}"
    if [ ! -f "CLAUDE.md" ]; then
        cp "$INIT_DIR/claude/CLAUDE.md" .
        echo -e "${GREEN}已创建 CLAUDE.md 文件${NC}"
    else
        echo -e "${YELLOW}CLAUDE.md 已存在，跳过创建${NC}"
    fi
fi

# opencode
if command -v opencode &> /dev/null; then
    echo -e "${GREEN}检测到 opencode${NC}"
    if [ ! -f "opencode.yaml" ]; then
        cp "$INIT_DIR/opencode/opencode.yaml" .
        echo -e "${GREEN}已创建 opencode.yaml 文件${NC}"
    else
        echo -e "${YELLOW}opencode.yaml 已存在，跳过创建${NC}"
    fi
fi

echo ""
echo -e "${GREEN}安装完成!${NC}"
echo ""
echo "使用方法:"
echo "  1. 启动 AI 对话工具 (Cursor/Claude Code/opencode)"
echo "  2. 输入命令: /init 初始化项目"
echo "  3. 输入命令: /propose <需求描述> 开始需求开发"
echo ""
echo "文档: https://github.com/your-org/code-copilot"
