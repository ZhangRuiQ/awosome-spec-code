# 变更管理

## 目录结构

```
changes/
├── README.md              # 本文件
├── templates/             # 模板文件
│   ├── spec.md           # Spec 模板
│   ├── tasks.md          # Tasks 模板
│   ├── test-spec.md      # 单测 Spec 模板
│   └── log.md            # Log 模板
├── <change-name>/        # 进行中的变更（例如: feature-user-auth）
│   ├── spec.md          # 需求规格
│   ├── tasks.md         # 任务拆分
│   ├── test-spec.md     # 测试规格（可选）
│   └── log.md           # 执行日志
└── archives/             # 已完成变更的归档
    └── <change-name>/
        ├── spec.md
        ├── tasks.md
        ├── log.md
        └── final-commit-sha
```

## 变更生命周期

```
/propose 创建 → /apply 执行 → /review 审查 → /archive 归档
     ↓
<change-name>/
     ↓
archives/<change-name>/
```

## 命名规范

变更目录名使用 kebab-case：

- ✅ `feature-user-auth`
- ✅ `fix-order-calculation`
- ✅ `refactor-payment-service`
- ❌ `新功能`
- ❌ `fixBug`

## 状态流转

| 状态 | 说明 | 命令 |
|------|------|------|
| propose | 需求分析阶段 | `/propose` |
| apply | 编码执行阶段 | `/apply` |
| review | 审查阶段 | `/review` |
| done | 已完成 | `/archive` |

## 使用说明

### 创建新变更

```
/propose 实现用户登录功能
```

AI 会：
1. 创建 `changes/feature-user-auth/` 目录
2. 从 templates/ 复制模板
3. 填充 spec.md
4. 生成 tasks.md

### 查看进行中变更

```
查看当前变更状态
```

AI 会列出 `changes/` 下所有非模板目录。

### 归档已完成变更

```
/archive feature-user-auth
```

AI 会：
1. 展示 log.md 中的知识发现
2. 询问是否沉淀到 knowledge/
3. 将目录移动到 `archives/`
4. 记录 final-commit-sha

## 注意事项

1. **禁止直接修改 templates/**：模板是基础框架，变更请复制后使用
2. **及时更新 log.md**：每个 task 完成后记录发现和问题
3. **定期归档**：完成的变更及时归档，保持 changes/ 目录整洁
