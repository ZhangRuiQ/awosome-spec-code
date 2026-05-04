# Code Copilot 安装脚本 (PowerShell)
# 用于在目标项目中快速部署框架

$ErrorActionPreference = "Stop"

# 颜色定义
$Green = "`e[32m"
$Yellow = "`e[33m"
$Red = "`e[31m"
$Reset = "`e[0m"

$CODE_COPILOT_DIR = "code-copilot"

Write-Host "${Green}Code Copilot 安装脚本${Reset}"
Write-Host "=============================="
Write-Host ""

# 检查当前目录是否已有框架
if (Test-Path $CODE_COPILOT_DIR) {
    Write-Host "${Yellow}警告: 当前目录已存在 $CODE_COPILOT_DIR/ 目录${Reset}"
    $confirm = Read-Host "是否覆盖? (y/N)"
    if ($confirm -ne "y" -and $confirm -ne "Y") {
        Write-Host "安装已取消"
        exit 0
    }
    Remove-Item -Recurse -Force $CODE_COPILOT_DIR
}

# 复制框架目录
Write-Host "正在复制框架文件..."
$parentDir = Split-Path -Parent $PSScriptRoot
Copy-Item -Recurse -Path $parentDir -Destination .

# 检测 IDE 并创建相应配置文件
Write-Host ""
Write-Host "正在检测 IDE 配置..."

$initDir = $PSScriptRoot

# Cursor
$cursorExists = Test-Path ".cursor" -ErrorAction SilentlyContinue
$cursorCmd = Get-Command cursor -ErrorAction SilentlyContinue
if ($cursorExists -or $cursorCmd) {
    Write-Host "${Green}检测到 Cursor IDE${Reset}"
    if (-not (Test-Path ".cursorrules")) {
        $cursorSource = Join-Path $initDir "cursor\.cursorrules"
        Copy-Item $cursorSource .
        Write-Host "${Green}已创建 .cursorrules 文件${Reset}"
    } else {
        Write-Host "${Yellow}.cursorrules 已存在，跳过创建${Reset}"
    }
}

# Claude Code
$claudeCmd = Get-Command claude -ErrorAction SilentlyContinue
if ($claudeCmd) {
    Write-Host "${Green}检测到 Claude Code${Reset}"
    if (-not (Test-Path "CLAUDE.md")) {
        $claudeSource = Join-Path $initDir "claude\CLAUDE.md"
        Copy-Item $claudeSource .
        Write-Host "${Green}已创建 CLAUDE.md 文件${Reset}"
    } else {
        Write-Host "${Yellow}CLAUDE.md 已存在，跳过创建${Reset}"
    }
}

# opencode
$opencodeCmd = Get-Command opencode -ErrorAction SilentlyContinue
if ($opencodeCmd) {
    Write-Host "${Green}检测到 opencode${Reset}"
    if (-not (Test-Path "opencode.yaml")) {
        $opencodeSource = Join-Path $initDir "opencode\opencode.yaml"
        Copy-Item $opencodeSource .
        Write-Host "${Green}已创建 opencode.yaml 文件${Reset}"
    } else {
        Write-Host "${Yellow}opencode.yaml 已存在，跳过创建${Reset}"
    }
}

Write-Host ""
Write-Host "${Green}安装完成!${Reset}"
Write-Host ""
Write-Host '使用方法:'
Write-Host '  1. 启动 AI 对话工具 (Cursor/Claude Code/opencode)'
Write-Host '  2. 输入命令: /init 初始化项目'
Write-Host '  3. 输入命令: /propose <需求描述> 开始需求开发'
Write-Host ""
Write-Host '文档: https://github.com/your-org/code-copilot'
