# TradeHub 🛒

[![Java](https://img.shields.io/badge/Java-1.8-orange.svg)](https://www.oracle.com/java/)
[![MySQL](https://img.shields.io/badge/MySQL-8.0-blue.svg)](https://www.mysql.com/)
[![Tomcat](https://img.shields.io/badge/Tomcat-8.5-yellow.svg)](https://tomcat.apache.org/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

**TradeHub** 是一个基于 Java EE 技术栈开发的校园二手交易平台，旨在为在校大学生提供一个安全、便捷的闲置物品交易渠道。系统采用经典的 MVC 架构模式，实现了商品发布、浏览、搜索、购物车、订单管理等完整的电商核心功能。

---

## 📖 目录

- [项目概述](#项目概述)
- [核心功能](#核心功能)
- [技术架构](#技术架构)
- [环境要求](#环境要求)
- [安装与配置](#安装与配置)
- [项目结构](#项目结构)
- [数据库设计](#数据库设计)
- [使用指南](#使用指南)
- [API 文档](#api-文档)
- [贡献指南](#贡献指南)
- [许可证](#许可证)
- [联系方式](#联系方式)

---

## 项目概述

随着大学生消费观念的转变，校园内闲置物品的流转需求日益增长。传统的线下交易存在信息不对称、交易效率低下等问题。TradeHub 通过互联网技术，将买家与卖家有效连接，实现商品发布、浏览、购买、订单管理等一站式服务。

### 主要特点

- 🎯 **专注校园场景**：支持学号注册、校园认证，构建可信交易环境
- 🔄 **完整交易闭环**：从商品发布到订单完成，覆盖二手交易全流程
- 📱 **响应式设计**：基于 Tailwind CSS，适配 PC 端与移动端
- 🛡️ **权限控制**：前台用户与后台管理员分离，AdminFilter 拦截保护
- ⚡ **高性能**：C3P0 连接池 + DbUtils 简化数据库操作

---

## 核心功能

### 前台用户系统

| 模块 | 功能描述 |
|------|----------|
| **用户模块** | 用户注册、登录/登出、个人信息管理、密码修改 |
| **首页展示** | 轮播广告、分类导航、最新发布、热门推荐 |
| **商品浏览** | 商品列表（分页）、分类筛选、多维度排序、商品详情 |
| **搜索功能** | 关键词搜索、按分类/价格区间筛选、搜索结果分页 |
| **购物车** | 加入购物车、查看/修改/删除、批量结算 |
| **订单系统** | 提交订单、买家/卖家订单列表、付款/发货/收货、取消订单 |
| **个人中心** | 我的商品、发布商品、我的收藏、我的订单、个人设置 |

### 后台管理系统

| 模块 | 功能描述 |
|------|----------|
| **管理仪表盘** | 数据统计概览、各分类商品数量统计 |
| **用户管理** | 用户列表、封禁/解封用户、按用户名/学号搜索 |
| **商品管理** | 商品列表、下架违规商品、查看商品详情 |
| **分类管理** | 分类的增删改查 |
| **轮播图管理** | 首页轮播广告的增删改查、排序调整 |
| **权限控制** | AdminFilter 拦截、管理员身份校验 |

---

## 技术架构

### 技术栈

| 层次 | 技术 |
|------|------|
| **前端** | JSP + JSTL + Tailwind CSS + JavaScript/jQuery |
| **后端** | Java Servlet + 自定义 MVC 框架（BaseServlet 反射路由） |
| **数据库** | MySQL 8.0 |
| **连接池** | C3P0 |
| **ORM 工具** | Apache Commons DbUtils (QueryRunner) |
| **服务器** | Apache Tomcat 8.5 |
| **构建工具** | IntelliJ IDEA Artifact |

### 架构图

```
┌─────────────────────────────────────────────────────────────┐
│                        客户端 (浏览器)                         │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                      视图层 (JSP + JSTL)                      │
│            index.jsp / product_list.jsp / admin_*.jsp        │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                    控制器层 (Servlet)                         │
│     BaseServlet → UserServlet / ProductServlet / ...         │
│              (反射机制实现 method 参数路由)                    │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                    业务逻辑层 (Service)                       │
│         UserService / ProductService / OrderService / ...    │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                    数据访问层 (DAO)                           │
│            UserDao / ProductDao / OrderDao / ...             │
│                  Apache Commons DbUtils                      │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                    数据层 (MySQL + C3P0)                      │
│                      tradehub 数据库                          │
└─────────────────────────────────────────────────────────────┘
```

---

## 环境要求

### 开发环境

| 软件 | 版本要求 |
|------|----------|
| JDK | 1.8+ |
| MySQL | 8.0+ |
| Tomcat | 8.5+ |
| IDE | IntelliJ IDEA (推荐) / Eclipse |

### 运行环境

| 软件 | 版本要求 |
|------|----------|
| JRE | 1.8+ |
| MySQL | 8.0+ |
| Tomcat | 8.5+ |

---

## 安装与配置

### 1. 克隆项目

```bash
git clone https://github.com/your-username/TradeHub.git
cd TradeHub
```

### 2. 数据库配置

```bash
# 登录 MySQL
mysql -u root -p

# 创建数据库并导入数据
CREATE DATABASE tradehub DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE tradehub;
SOURCE tradehub.sql;
```

### 3. 修改数据库连接配置

编辑 `TradeHub/src/dbutils/C3P0Utils.java` 或 `c3p0-config.xml`，修改数据库连接参数：

```xml
<property name="driverClass">com.mysql.cj.jdbc.Driver</property>
<property name="jdbcUrl">jdbc:mysql://localhost:3306/tradehub?useSSL=false&amp;serverTimezone=Asia/Shanghai&amp;characterEncoding=utf8</property>
<property name="user">root</property>
<property name="password">your_password</property>
```

### 4. 配置 IDE (IntelliJ IDEA)

1. 打开项目：`File` → `Open` → 选择项目目录
2. 配置 Tomcat：`Run` → `Edit Configurations` → `+` → `Tomcat Server` → `Local`
3. 添加 Artifact：切换到 `Deployment` 标签 → `+` → `Artifact` → 选择 `TradeHub:war exploded`
4. 配置 Web Facet：确保 `Deployment Descriptor` 指向正确的 `web.xml`

### 5. 运行项目

1. 启动 Tomcat 服务器
2. 访问 `http://localhost:8080/TradeHub/`

### 默认管理员账号

| 用户名 | 密码 | 角色 |
|--------|------|------|
| admin | admin123 | 管理员 |

> ⚠️ 生产环境请务必修改默认密码！

---

## 项目结构

```
TradeHub/
├── TradeHub/                          # 主模块目录
│   ├── src/                           # 源代码
│   │   ├── servlet/                   # Servlet 控制器
│   │   │   ├── BaseServlet.java       # 基础 Servlet (反射路由)
│   │   │   ├── UserServlet.java       # 用户控制器
│   │   │   ├── ProductServlet.java    # 商品控制器
│   │   │   ├── OrderServlet.java      # 订单控制器
│   │   │   ├── CartServlet.java       # 购物车控制器
│   │   │   ├── AdminServlet.java      # 后台管理控制器
│   │   │   └── ...
│   │   ├── service/                   # 业务逻辑层
│   │   ├── dao/                       # 数据访问层
│   │   ├── model/                     # 实体类
│   │   ├── filter/                    # 过滤器
│   │   │   ├── EncodeFilter.java      # 编码过滤器
│   │   │   └── AdminFilter.java       # 管理员权限过滤器
│   │   ├── listener/                  # 监听器
│   │   └── dbutils/                   # 数据库工具类
│   ├── web/                           # Web 资源
│   │   ├── WEB-INF/
│   │   │   └── web.xml                # 部署描述符
│   │   ├── index.jsp                  # 首页
│   │   ├── header.jsp                 # 公共头部
│   │   ├── product_list.jsp           # 商品列表页
│   │   ├── product_detail.jsp         # 商品详情页
│   │   ├── cart.jsp                   # 购物车页
│   │   ├── order_*.jsp                # 订单相关页面
│   │   ├── user_*.jsp                 # 用户相关页面
│   │   ├── admin_*.jsp                # 后台管理页面
│   │   └── picture/                   # 上传图片目录
│   └── out/                           # 编译输出目录
├── tradehub.sql                       # 数据库脚本
├── TradeHub.iml                       # IntelliJ IDEA 模块配置
└── README.md                          # 项目说明文档
```

---

## 数据库设计

### ER 关系图

```
┌──────────────┐       ┌──────────────┐       ┌──────────────┐
│    user      │       │   product    │       │   category   │
├──────────────┤       ├──────────────┤       ├──────────────┤
│ id (PK)      │       │ id (PK)      │       │ id (PK)      │
│ username     │       │ name         │       │ name         │
│ student_id   │       │ price        │       │ description  │
│ email        │       │ description  │       └──────────────┘
│ password     │       │ image        │              │
│ isadmin      │       │ status       │              │ FK
│ status       │       │ user_id (FK) │──────────────┘
└──────────────┘       │ category_id  │
       │               └──────────────┘
       │                      │
       │ FK                   │ FK
       │                      │
       ▼                      ▼
┌──────────────┐       ┌──────────────┐
│    order     │       │    cart      │
├──────────────┤       ├──────────────┤
│ id (PK)      │       │ id (PK)      │
│ total        │       │ user_id (FK) │
│ status       │       │ product_id   │
│ buyer_id(FK) │       │ quantity     │
│ seller_id(FK)│       └──────────────┘
└──────────────┘
       │
       │ 1:N
       ▼
┌──────────────┐       ┌──────────────┐       ┌──────────────┐
│  orderitem   │       │   favorite   │       │   carousel   │
├──────────────┤       ├──────────────┤       ├──────────────┤
│ id (PK)      │       │ id (PK)      │       │ id (PK)      │
│ order_id(FK) │       │ user_id (FK) │       │ title        │
│ product_id   │       │ product_id   │       │ image        │
│ price        │       └──────────────┘       │ link         │
└──────────────┘                              │ sort_order   │
                                              │ status       │
                                              └──────────────┘
```

### 数据表清单

| 表名 | 说明 |
|------|------|
| `user` | 用户表，存储用户和管理员信息 |
| `product` | 商品表，存储二手商品信息 |
| `category` | 分类表，存储商品分类 |
| `order` | 订单表，存储交易订单 |
| `orderitem` | 订单项表，存储订单中的商品明细 |
| `cart` | 购物车表，存储购物车记录 |
| `favorite` | 收藏表，存储用户收藏的商品 |
| `carousel` | 轮播图表，存储首页轮播广告 |

---

## 使用指南

### 前台用户操作流程

1. **注册账号**：访问首页 → 点击"注册" → 填写学号、姓名、密码等信息
2. **浏览商品**：首页查看最新/热门商品，或通过分类导航、搜索功能查找
3. **购买商品**：
   - 方式一：商品详情页点击"立即购买" → 填写订单信息 → 提交订单
   - 方式二：加入购物车 → 购物车页面结算 → 提交订单
4. **订单管理**：个人中心 → 我的订单 → 付款/确认收货/取消订单
5. **发布商品**：个人中心 → 发布商品 → 填写信息并上传图片

### 后台管理员操作流程

1. **登录后台**：使用管理员账号登录 → 点击"后台管理"
2. **用户管理**：查看用户列表，对违规用户执行封禁/解封操作
3. **商品管理**：查看商品列表，对违规商品执行下架操作
4. **分类管理**：添加/编辑/删除商品分类
5. **轮播图管理**：管理首页轮播广告

---

## API 文档

### URL 路由规范

系统采用 `BaseServlet` 反射机制实现方法级路由，URL 格式为：

```
/{servletPath}?method={methodName}
```

示例：`/product?method=list` 调用 `ProductServlet.list()`

### 核心 API 列表

#### 用户模块 (`/user`)

| 方法 | URL | 说明 | 权限 |
|------|-----|------|------|
| GET/POST | `/user?method=login` | 用户登录页面/登录处理 | 游客 |
| POST | `/user?method=register` | 用户注册 | 游客 |
| GET | `/user?method=logout` | 退出登录 | 登录用户 |
| GET/POST | `/user?method=profile` | 个人信息页面/修改 | 登录用户 |

#### 商品模块 (`/product`)

| 方法 | URL | 说明 | 权限 |
|------|-----|------|------|
| GET | `/product?method=list` | 商品列表 | 所有人 |
| GET | `/product?method=detail&id={id}` | 商品详情 | 所有人 |
| GET | `/product?method=search&keyword={kw}` | 商品搜索 | 所有人 |
| GET/POST | `/product?method=publish` | 发布商品页面/处理 | 登录用户 |
| POST | `/product?method=edit` | 编辑商品 | 登录用户 |
| GET | `/product?method=delete&id={id}` | 删除商品 | 登录用户(本人) |

#### 订单模块 (`/order`)

| 方法 | URL | 说明 | 权限 |
|------|-----|------|------|
| GET/POST | `/order?method=submit` | 订单提交页面/处理 | 登录用户 |
| GET | `/order?method=myOrders` | 我的订单列表 | 登录用户 |
| GET | `/order?method=pay&id={id}` | 付款 | 登录用户(买家) |
| GET | `/order?method=ship&id={id}` | 发货 | 登录用户(卖家) |
| GET | `/order?method=confirm&id={id}` | 确认收货 | 登录用户(买家) |
| GET | `/order?method=cancel&id={id}` | 取消订单 | 登录用户 |

#### 购物车模块 (`/cart`)

| 方法 | URL | 说明 | 权限 |
|------|-----|------|------|
| GET | `/cart?method=list` | 购物车列表 | 登录用户 |
| POST | `/cart?method=add` | 加入购物车 | 登录用户 |
| POST | `/cart?method=update` | 修改数量 | 登录用户 |
| GET | `/cart?method=delete&id={id}` | 删除商品 | 登录用户 |

#### 后台管理模块 (`/admin`)

| 方法 | URL | 说明 | 权限 |
|------|-----|------|------|
| GET | `/admin?method=dashboard` | 管理仪表盘 | 管理员 |
| GET | `/admin?method=userList` | 用户列表 | 管理员 |
| GET | `/admin?method=banUser&id={id}` | 封禁用户 | 管理员 |
| GET | `/admin?method=productList` | 商品列表 | 管理员 |
| GET/POST | `/admin?method=categoryList` | 分类管理 | 管理员 |

---

## 贡献指南

欢迎参与 TradeHub 项目的开发与改进！

### 如何贡献

1. **Fork 项目**：点击右上角 Fork 按钮
2. **克隆仓库**：
   ```bash
   git clone https://github.com/your-username/TradeHub.git
   ```
3. **创建分支**：
   ```bash
   git checkout -b feature/your-feature-name
   ```
4. **提交更改**：
   ```bash
   git add .
   git commit -m "feat: 添加某某功能"
   ```
5. **推送分支**：
   ```bash
   git push origin feature/your-feature-name
   ```
6. **创建 Pull Request**：在 GitHub 上提交 PR

### 代码规范

- 遵循 Java 命名规范（类名大驼峰、方法名小驼峰）
- 添加必要的注释说明
- 保持代码风格一致

### 提交信息规范

- `feat`: 新功能
- `fix`: 修复 Bug
- `docs`: 文档更新
- `style`: 代码格式调整
- `refactor`: 代码重构
- `test`: 测试相关

---

## 许可证

本项目基于 [MIT License](LICENSE) 开源协议发布。

```
MIT License

Copyright (c) 2026 TradeHub

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
```

---

## 联系方式

如有问题或建议，欢迎通过以下方式联系：

- **Issues**: [GitHub Issues]((https://github.com/WangSuhang123/))
- **Email**: wangsuhang7984@foxmail.com

---

<p align="center">
  Made with ❤️ by TradeHub Team
</p>
