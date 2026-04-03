---
alwaysApply: false
description: "当涉及业务领域特定逻辑时应用本规则"
---

# 业务领域约束

## 1. 通用领域规则

### 金额处理

- 所有金额使用 `long` 类型，单位为分
- 禁止浮点数计算金额
- 金额显示时转换为元（除以 100）

```java
// ✅ 正确
long amountInCent = 10000L; // 100元

// ❌ 错误
double amount = 100.00; // 精度问题！
```

### 时间处理

- 时间字段统一使用 `Date` 或 `LocalDateTime` 类型
- 禁止使用时间戳字符串
- 时区统一使用 UTC 或东八区

### 外部接口

- 外部接口调用必须设置超时（默认 3s）
- 必须做降级处理
- 返回值必须校验

```java
// ✅ 正确
@Retryable(maxAttempts = 3)
@CircuitBreaker(name = "externalService")
public Result callExternal(Param param) {
    // 3秒超时
    // 失败降级
}
```

### 状态变更

- 状态变更必须通过状态机
- 禁止直接 set 状态字段
- 必须记录状态变更日志

## 2. 项目特定规则

> 根据实际项目业务补充以下规则

### 订单领域

| 规则 | 说明 |
|------|------|
| 订单状态机 | （待补充） |
| 订单号生成 | （待补充） |
| 库存扣减 | （待补充） |

### 支付领域

| 规则 | 说明 |
|------|------|
| 幂等控制 | （待补充） |
| 对账逻辑 | （待补充） |

### 用户领域

| 规则 | 说明 |
|------|------|
| 用户状态 | （待补充） |
| 权限校验 | （待补充） |

## 3. 业务术语表

| 术语 | 英文 | 含义 |
|------|------|------|
| （待补充） | | |

## 4. 业务规则实现示例

```java
// 状态机示例
public enum OrderStatus {
    CREATED(1, "已创建") {
        @Override
        public boolean canTransitionTo(OrderStatus target) {
            return target == PAID || target == CANCELLED;
        }
    },
    PAID(2, "已支付") {
        @Override
        public boolean canTransitionTo(OrderStatus target) {
            return target == SHIPPED || target == REFUNDED;
        }
    },
    // ...
    ;

    public abstract boolean canTransitionTo(OrderStatus target);
}

// 状态变更方法
public void transition(Order order, OrderStatus target) {
    OrderStatus current = order.getStatus();
    if (!current.canTransitionTo(target)) {
        throw new BizException(ErrorCode.STATUS_INVALID,
            String.format("不能从 %s 变更为 %s", current, target));
    }
    order.setStatus(target);
    order.setStatusUpdateTime(new Date());
}
```

---

*本文件随实践积累逐步完善。*
