---
alwaysApply: true
---

# 编码规范

## 1. 命名规范

### 通用

| 类型 | 规范 | 示例 |
|------|------|------|
| 类名 | 大驼峰，见名知意 | `OrderService`, `UserManager` |
| 方法名 | 小驼峰，动词开头 | `createOrder()`, `getUserById()` |
| 变量名 | 小驼峰 | `orderId`, `userName` |
| 常量 | 全大写下划线分隔 | `MAX_RETRY_TIMES`, `DEFAULT_TIMEOUT` |
| 包名 | 全小写 | `com.company.module` |
| 抽象类 | 以 Abstract 或 Base 开头 | `AbstractService`, `BaseDAO` |
| 测试类 | 被测类名 + Test 结尾 | `OrderServiceTest` |

### 禁止

- ❌ 拼音命名
- ❌ 中英混拼
- ❌ 无意义命名（如 `a`, `b`, `xxx`）
- ❌ 单个字母（循环变量除外）

## 2. 代码格式

### 基本

- 缩进：4 个空格
- 行长：不超过 120 字符
- 括号：K&R 风格
- 空行：方法之间空一行

### 示例

```java
public class OrderService {

    private static final int MAX_RETRY = 3;

    public OrderDTO createOrder(CreateOrderRequest request) {
        // 参数校验
        if (request == null) {
            throw new BizException(ErrorCode.PARAM_INVALID);
        }

        // 业务逻辑
        Order order = doCreate(request);

        return convertToDTO(order);
    }
}
```

## 3. 异常处理

### 原则

- 业务异常使用自定义 `BizException`，携带错误码
- 系统异常向上抛出，由统一异常处理器兜底
- **禁止吞掉异常**（空 catch 或仅打印）
- catch 中必须记录日志

### 规范

```java
// ✅ 正确示例
try {
    result = externalService.call();
} catch (ExternalException e) {
    log.error("调用外部服务失败, param={}", param, e);
    throw new BizException(ErrorCode.EXTERNAL_ERROR, "调用失败");
}

// ❌ 错误示例
try {
    result = externalService.call();
} catch (Exception e) {
    // 什么都不做 - 吞掉了异常！
}
```

### 异常分类

| 异常类型 | 处理方式 | 示例 |
|----------|----------|------|
| 参数校验异常 | 抛出 BizException | 参数为空、格式错误 |
| 业务规则异常 | 抛出 BizException | 库存不足、余额不足 |
| 系统异常 | 向上抛出 | 数据库连接失败 |
| 外部服务异常 | 捕获后转抛或降级 | RPC 超时 |

## 4. 日志规范

### 级别使用

| 级别 | 场景 |
|------|------|
| ERROR | 系统错误、需要人工介入 |
| WARN | 业务异常、可自动恢复的问题 |
| INFO | 关键业务流程节点 |
| DEBUG | 详细调试信息（生产关闭） |

### 规范

- Controller 入口打 INFO，含请求关键参数（脱敏后）
- 异常打 ERROR，含完整堆栈
- **禁止在日志中打印用户敏感信息**（手机号、身份证、银行卡等）

```java
// ✅ 正确示例
log.info("创建订单, userId={}, orderNo={}", userId, orderNo);
log.error("创建订单失败, request={}", request, e);

// ❌ 错误示例
log.info("用户手机号: {}", phone); // 敏感信息！
```

## 5. 注释规范

### 原则

- 代码本身应该自解释
- 注释解释 "为什么"，而非 "做什么"
- 复杂算法、业务规则必须注释

### 格式

```java
/**
 * 订单服务
 * 处理订单的创建、查询、取消等操作
 */
public class OrderService {

    /**
     * 创建订单
     * 包含库存检查、价格计算、订单持久化
     *
     * @param request 创建订单请求
     * @return 订单信息
     * @throws BizException 参数校验失败或业务规则冲突
     */
    public OrderDTO createOrder(CreateOrderRequest request) {
        // ...
    }
}
```

## 6. 其他规范

### 接口设计

- 写接口必须考虑幂等
- 接口版本管理：`/v1/`, `/v2/`
- 返回统一包装：`Result<T>`

### 并发

- 涉及并发场景必须说明同步策略
- 共享变量必须考虑线程安全

### 魔法值

- 魔法值必须定义为常量
- 布尔值参数必须说明含义

```java
// ✅ 正确示例
private static final int STATUS_ENABLED = 1;

public void enableUser(Long userId) {
    updateStatus(userId, STATUS_ENABLED);
}

// ❌ 错误示例
updateStatus(userId, 1); // 1 是什么？
```

### 空值处理

- 返回集合禁止返回 null，应返回空集合
- 使用 Optional 处理可能为空的值

```java
// ✅ 正确示例
public List<Order> getOrders(Long userId) {
    List<Order> orders = orderDAO.queryByUserId(userId);
    return orders == null ? Collections.emptyList() : orders;
}

// ❌ 错误示例
return orderDAO.queryByUserId(userId); // 可能返回 null
```
