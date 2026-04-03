---
alwaysApply: true
---

# 工程上下文

> 首次使用时执行 `/init` 让 AI 分析工程并填充本文件。

## 1. 应用概况

- **应用名**: （待填充）
- **简介**: （一句话描述业务领域和核心功能）
- **技术栈**: Java 21 / Spring Boot 3.x / （根据项目实际填写）
- **构建工具**: Maven / Gradle

## 2. 目录结构与模块职责

> 执行 `tree -d -L 3` 后填充。

```
（待填充目录结构）
```

### 模块说明

| 模块 | 职责 | 备注 |
|------|------|------|
| （待填充） | | |

## 3. 分层架构

```
Controller (web/)
    ↓
Service (service/)
    ↓
Manager (manager/)
    ↓
DAO (dao/)
```

| 层级 | 目录 | 职责 | 规范 |
|------|------|------|------|
| 入口层 | web/ | 参数校验 + 协议转换 | 禁止业务逻辑 |
| 业务层 | service/ | 业务编排，事务边界 | 保持简洁，复杂逻辑下沉 |
| 领域层 | manager/ | 领域能力，单一职责 | 可复用，无状态 |
| 数据层 | dao/ | 纯数据访问 | 禁止业务逻辑 |

## 4. 关键依赖

| 中间件/框架 | 用途 | 版本 | 备注 |
|-------------|------|------|------|
| Spring Boot | 基础框架 | | |
| MyBatis / JPA | ORM | | |
| Redis | 缓存 | | |
| MySQL | 数据库 | | |
| RocketMQ / Kafka | 消息队列 | | |
| （待填充） | | | |

## 5. 工程约定

### 包结构

```
com.company.app/
├── web/           # Controller
├── service/       # Service
├── manager/       # Manager
├── dao/           # DAO / Repository
├── entity/        # 实体类
├── dto/           # 数据传输对象
├── vo/            # 视图对象
├── config/        # 配置类
├── util/          # 工具类
└── constant/      # 常量定义
```

### 配置文件

| 文件 | 用途 |
|------|------|
| application.yml | 主配置 |
| application-dev.yml | 开发环境 |
| application-test.yml | 测试环境 |
| application-prod.yml | 生产环境 |

## 6. 外部依赖

| 依赖 | 用途 | 接入方式 |
|------|------|----------|
| （待填充） | | |

## 7. 测试策略

| 类型 | 工具 | 位置 |
|------|------|------|
| 单元测试 | JUnit 5 / Mockito | src/test/java |
| 集成测试 | Spring Boot Test | src/test/java |

---

*本文件由 `/init` 命令初始化，后续可手动更新。*
