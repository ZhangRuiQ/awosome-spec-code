# 单测 Spec — 需求名称

> status: propose | apply | done
> created: YYYY-MM-DD
> related-spec: spec.md

## 0. 测试原则

- **Red/Green TDD**：测试必须先 Red 再 Green，跳过 Red 的测试无法证明有效
- **First Run the Tests**：开始前先跑已有测试套件，了解框架和基线
- **展示工作**：必须展示 `mvn test` 实际输出，禁止"测试通过"等无证据声明

## 1. 测试框架

| 项目 | 值 |
|------|-----|
| JUnit 版本 | JUnit 5 |
| Mock 框架 | Mockito |
| 已有测试数量 | （待统计） |
| 已有测试风格 | （观察现有测试） |

## 2. 覆盖范围

### P0 — 核心业务逻辑（必须覆盖）

| 类名 | 方法 | 场景 | 说明 |
|------|------|------|------|
| `XxxServiceImpl` | `createOrder()` | 正常创建 | 核心流程 |
| | | 参数非法 | 边界校验 |
| | `cancelOrder()` | 正常取消 | 状态流转 |
| | | 重复取消 | 幂等性 |

### P1 — 数据访问层

| 类名 | 方法 | 场景 | 说明 |
|------|------|------|------|
| `XxxDAO` | `insert()` | 正常插入 | |
| | | 唯一键冲突 | 异常处理 |

### P2 — 入口层/服务层

| 类名 | 方法 | 场景 | 说明 |
|------|------|------|------|
| `XxxController` | `createOrder()` | 正常请求 | |
| | | 参数校验失败 | |

### 不测试（明确列出原因）

| 类/方法 | 原因 |
|---------|------|
| `XxxUtil` | 纯数据转换，无逻辑 |

## 3. 测试设计

### 3.1 核心类测试

#### 类: `XxxServiceImpl`

**方法**: `createOrder(CreateOrderRequest request)`

| 场景 | 输入 | Mock 行为 | 预期结果 |
|------|------|-----------|----------|
| 正常创建 | 合法参数 | `userService.getById()` 返回用户 | 返回订单DTO |
| 用户不存在 | 不存在 userId | `userService.getById()` 返回 null | 抛出 BizException |
| 库存不足 | 合法参数 | `stockService.deduct()` 返回 false | 抛出 BizException |

**方法**: `cancelOrder(Long orderId)`

| 场景 | 输入 | Mock 行为 | 预期结果 |
|------|------|-----------|----------|
| 正常取消 | 已支付订单 | `orderDAO.updateStatus()` 返回 1 | 返回成功 |
| 重复取消 | 已取消订单 | - | 幂等，返回成功 |
| 非法状态 | 未支付订单 | - | 抛出 BizException |

### 3.2 测试数据

```java
// 正常请求
CreateOrderRequest normalRequest = CreateOrderRequest.builder()
    .userId(12345L)
    .itemId(67890L)
    .quantity(1)
    .build();

// 非法参数
CreateOrderRequest invalidRequest = CreateOrderRequest.builder()
    .userId(null)  // 空用户
    .itemId(67890L)
    .quantity(0)   // 非法数量
    .build();
```

### 3.3 Mock 策略

| 依赖 | Mock 方式 | 返回值 |
|------|-----------|--------|
| `UserService` | `@MockBean` | 根据场景返回用户/Null |
| `StockService` | `@MockBean` | true/false |
| `OrderDAO` | `@MockBean` | 1/0 |

## 4. 执行计划

- [ ] Step 1: 运行已有测试套件，确认基线
- [ ] Step 2: 生成 P0 测试 → 确认 Red → 确认 Green
- [ ] Step 3: 生成 P1/P2 测试
- [ ] Step 4: 运行完整测试套件，确认覆盖率

## 5. 覆盖率报告

> 执行完成后填写

| 指标 | 目标 | 实际 |
|------|------|------|
| 行覆盖率 | 80% | （待填写） |
| 分支覆盖率 | 70% | （待填写） |
| 核心类覆盖率 | 100% | （待填写） |

## 6. 问题记录

| 问题 | 原因 | 解决方案 |
|------|------|----------|
| | | |

---

*本文件由 /test 命令使用，指导单测生成。*
