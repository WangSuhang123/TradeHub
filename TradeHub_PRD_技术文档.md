# TradeHub 校园二手交易平台 - 产品需求文档（PRD）

---

## 文档信息

| 项目 | 说明 |
|------|------|
| 产品名称 | TradeHub（校园二手交易平台） |
| 文档版本 | v1.0 |
| 编写日期 | 2026-06-02 |
| 文档类型 | 产品需求文档（PRD）+ 技术架构文档 |
| 技术栈 | Java 8+ / JSP + Servlet / MySQL / C3P0 / Tailwind CSS |
| 运行环境 | Apache Tomcat 8.5+ / MySQL 5.7+ |

---

## 目录

1. [产品定位与核心价值主张](#一产品定位与核心价值主张)
2. [产品核心目标与KPI](#二产品核心目标与kpi)
3. [目标用户群体画像与用户场景](#三目标用户群体画像与用户场景)
4. [完整页面架构与信息层级](#四完整页面架构与信息层级)
5. [详细功能模块清单与说明](#五详细功能模块清单与说明)
6. [核心业务流程图与状态转换图](#六核心业务流程图与状态转换图)
7. [交互规则与反馈机制说明](#七交互规则与反馈机制说明)
8. [设计规范与视觉要求](#八设计规范与视觉要求)
9. [需求优先级划分与排期建议](#九需求优先级划分与排期建议)
10. [技术架构详解](#十技术架构详解)
11. [数据库设计](#十一数据库设计)
12. [API接口文档](#十二api接口文档)
13. [项目启动与部署教程](#十三项目启动与部署教程)
14. [附录：功能状态矩阵](#十四附录功能状态矩阵)

---

## 一、产品定位与核心价值主张

### 1.1 产品定位

TradeHub 是一款面向高校在校学生的**校园二手闲置物品交易平台**。产品聚焦于校园场景，为大学生提供一个安全、便捷、高效的闲置物品买卖渠道。

### 1.2 核心价值主张

| 维度 | 价值描述 |
|------|----------|
| **买家价值** | 以远低于市场价的价格购买所需物品，支持分类浏览、关键词搜索、价格筛选 |
| **卖家价值** | 快速发布闲置物品，变现闲置资产，操作简单（三步完成发布） |
| **平台价值** | 构建校园信任交易生态，降低二手交易的信息不对称和信任成本 |
| **社会价值** | 促进闲置物品循环利用，践行绿色环保理念 |

### 1.3 产品差异化优势

1. **校园身份认证**：以学号为唯一标识，天然绑定校园身份，降低交易风险
2. **轻量级交易流程**：不涉及在线支付，买家下单后买卖双方线下交易，卖家确认完成
3. **管理员后台管控**：支持用户封禁、商品下架、分类管理等运营功能
4. **现代化UI设计**：采用Tailwind CSS框架，响应式设计，移动端友好

---

## 二、产品核心目标与KPI

### 2.1 核心目标

| 目标 | 描述 | 衡量指标 |
|------|------|----------|
| 用户增长 | 吸引校园用户注册使用 | 注册用户数、日活用户数 |
| 商品流通 | 促进闲置物品发布与交易 | 发布商品数、成交订单数 |
| 用户体验 | 提供流畅的交易体验 | 交易完成率、用户留存率 |
| 平台健康 | 维护平台内容质量 | 违规商品下架率、用户封禁率 |

### 2.2 关键绩效指标（KPI）

| KPI指标 | 目标值 | 统计周期 |
|---------|--------|----------|
| 注册用户数 | ≥500人 | 月度 |
| 商品发布数 | ≥200件 | 月度 |
| 订单成交量 | ≥100单 | 月度 |
| 交易完成率 | ≥60% | 月度 |
| 用户7日留存率 | ≥30% | 周度 |
| 违规商品处理时效 | ≤24小时 | 实时 |

---

## 三、目标用户群体画像与用户场景

### 3.1 用户画像

#### 买方用户画像

| 属性 | 描述 |
|------|------|
| 身份 | 在校大学生（本科/研究生） |
| 年龄 | 18-26岁 |
| 需求 | 以较低价格购买教材、数码产品、生活用品等 |
| 行为特征 | 价格敏感，倾向于浏览分类和搜索，关注商品成色 |
| 使用场景 | 开学季购教材、换季购衣物、毕业季淘二手 |

#### 卖方用户画像

| 属性 | 描述 |
|------|------|
| 身份 | 在校大学生（本科/研究生） |
| 年龄 | 18-26岁 |
| 需求 | 出售闲置物品，回笼资金 |
| 行为特征 | 希望快速发布，关注商品曝光量 |
| 使用场景 | 毕业季清理闲置、升级设备后出售旧设备 |

#### 管理员用户画像

| 属性 | 描述 |
|------|------|
| 身份 | 平台运营人员/学生组织成员 |
| 年龄 | 20-30岁 |
| 需求 | 管理用户、审核商品、管理分类 |
| 行为特征 | 周期性检查平台内容，处理违规行为 |

### 3.2 核心用户场景

| 场景编号 | 场景名称 | 用户角色 | 场景描述 |
|----------|----------|----------|----------|
| S-01 | 快速注册 | 新用户 | 用户通过学号、用户名、密码等信息完成注册 |
| S-02 | 浏览商品 | 买方 | 用户浏览首页最新/热门商品，按分类筛选，按关键词搜索 |
| S-03 | 发布闲置 | 卖方 | 用户上传商品信息（名称、图片、价格、成色等）发布商品 |
| S-04 | 下单购买 | 买方 | 用户查看商品详情，填写联系方式和交易地点后下单 |
| S-05 | 确认交易 | 卖方 | 卖家查看订单，联系买家完成线下交易，确认订单完成 |
| S-06 | 收藏商品 | 买方 | 用户收藏感兴趣的商品，稍后从收藏列表查看 |
| S-07 | 管理个人中心 | 通用 | 用户修改个人信息、密码，查看已发布商品和订单 |
| S-08 | 后台管理 | 管理员 | 管理员管理用户（封禁/解封）、商品（下架）、分类（增删改） |

---

## 四、完整页面架构与信息层级

### 4.1 页面架构总览

```
TradeHub 页面架构
├── 前台页面（通用用户）
│   ├── 首页 (index.jsp)
│   │   ├── 全局导航栏 (header.jsp)
│   │   │   ├── Logo + 品牌名 "TradeHub"
│   │   │   ├── 主导航：首页、全部商品、分类标签（前5个）
│   │   │   └── 用户区：登录/注册（未登录）| 发布商品/用户名/后台/退出（已登录）
│   │   ├── 搜索区域
│   │   │   ├── 关键词搜索框
│   │   │   └── 搜索按钮
│   │   ├── 分类标签栏（全部 + 6个分类）
│   │   ├── 最新发布商品网格（12个商品卡片）
│   │   └── 热门推荐榜单（10个热门商品）
│   ├── 登录页 (user_login.jsp)
│   │   ├── 标题 "登录 TradeHub"
│   │   ├── 错误/成功消息区
│   │   ├── 登录表单（学号 + 密码）
│   │   └── 注册引导链接
│   ├── 注册页 (user_register.jsp)
│   │   ├── 标题 "注册 TradeHub"
│   │   ├── 消息区
│   │   ├── 注册表单（学号/用户名/密码/确认密码/姓名/手机号/学校/邮箱/QQ号）
│   │   └── 登录引导链接
│   ├── 个人中心 (user_center.jsp)
│   │   ├── 用户信息卡片（头像占位 + 姓名 + 学号 + 学校 + 管理员标识）
│   │   ├── 功能Tabs（个人信息/我发布的/我收藏的/我的订单）
│   │   ├── 修改个人信息表单（姓名/手机号/地址/学校/QQ号）
│   │   └── 修改密码表单（原密码/新密码）
│   ├── 我发布的商品 (user_products.jsp)
│   │   ├── 标题 + 发布新商品按钮
│   │   ├── 功能Tabs
│   │   ├── 商品卡片网格（含编辑/删除按钮、状态标签）
│   │   └── 分页导航
│   ├── 我收藏的商品 (user_favorites.jsp)
│   │   ├── 标题
│   │   ├── 功能Tabs
│   │   ├── 商品卡片网格（含立即购买/取消收藏按钮）
│   │   └── 分页导航
│   ├── 商品列表 (product_list.jsp)
│   │   ├── 标题（分类名称/全部商品）
│   │   ├── 排序Tabs（最新/最热/价格↑/价格↓）
│   │   ├── 分类标签栏
│   │   ├── 商品卡片网格
│   │   └── 分页导航
│   ├── 商品详情 (product_detail.jsp)
│   │   ├── 商品图片（大图）
│   │   ├── 商品信息（名称/成色/分类/价格/原价/浏览量/发布时间）
│   │   ├── 卖家信息卡片（头像占位/卖家名/学校）
│   │   ├── 操作按钮（立即购买/收藏/已售/已下架状态）
│   │   └── 商品描述（详细描述文本）
│   ├── 商品搜索 (product_search.jsp)
│   │   ├── 搜索表单（关键词/分类/价格区间/搜索按钮）
│   │   ├── 排序Tabs
│   │   ├── 搜索结果计数
│   │   ├── 商品卡片网格
│   │   └── 分页导航
│   ├── 发布商品 (product_publish.jsp)
│   │   ├── 标题 "发布商品"
│   │   ├── 表单（商品名称/分类/成色/售价/原价/描述/图片上传）
│   │   └── 操作按钮（发布/取消）
│   ├── 编辑商品 (product_edit.jsp)
│   │   ├── 标题 "编辑商品"
│   │   ├── 表单（预填已有数据）
│   │   ├── 当前图片预览
│   │   └── 操作按钮（保存修改/取消）
│   ├── 确认订单 (order_submit.jsp)
│   │   ├── 标题 "确认订单信息"
│   │   ├── 商品信息区域（图片/名称/成色/分类/价格）
│   │   ├── 联系方式表单（联系人/联系电话/交易地点/给卖家留言）
│   │   └── 操作按钮（确认下单/取消）
│   ├── 我的订单 (order_list.jsp)
│   │   ├── 标题 "我的订单"
│   │   ├── 功能Tabs
│   │   ├── 买/卖Tab切换（我买到的/我卖出的）
│   │   ├── 订单卡片列表
│   │   │   ├── 订单编号 + 状态标签
│   │   │   ├── 商品项列表
│   │   │   ├── 买家/卖家信息 + 联系方式
│   │   │   ├── 交易金额
│   │   │   └── 操作按钮（确认交易/取消订单，仅卖家且待确认状态）
│   │   └── 空状态提示
│   └── 全局页脚 (footer.jsp)
│       ├── 品牌信息
│       ├── 快速链接
│       └── 版权信息
├── 后台管理页面（管理员用户）
│   ├── 后台首页 (admin/index.jsp)
│   │   ├── 统计卡片（用户总数/分类数量/快捷操作）
│   │   └── 功能入口卡片（用户管理/商品管理/分类管理）
│   ├── 用户管理 (admin/user_list.jsp)
│   │   ├── 用户表格（ID/用户名/学号/姓名/手机号/学校/状态/操作）
│   │   ├── 封禁/解封操作
│   │   └── 分页导航
│   ├── 商品管理 (admin/product_list.jsp)
│   │   ├── 商品表格（ID/名称/价格/分类/发布者/状态/操作）
│   │   ├── 下架操作
│   │   └── 分页导航
│   └── 分类管理 (admin/category_list.jsp)
│       ├── 添加分类按钮 → 展开表单
│       ├── 分类表格（ID/名称/描述/操作）
│       ├── 编辑按钮 → 弹窗编辑
│       └── 删除按钮
└── 全局组件
    ├── Tailwind CSS CDN
    ├── SweetAlert2 CDN
    └── 自定义颜色配置（primary/accent）
```

### 4.2 信息层级关系

```
L1: 全局导航（所有页面）
  └── L2: 页面标题
      └── L3: 功能区域
          ├── L4: 表单/列表/卡片
          └── L5: 操作按钮/链接
```

---

## 五、详细功能模块清单与说明

### 5.1 用户认证模块

#### 5.1.1 用户登录

| 属性 | 说明 |
|------|------|
| 功能ID | F-USER-01 |
| 页面路径 | `/user?method=login` → `user_login.jsp` |
| 触发方式 | 点击导航栏"登录"链接（未登录状态） |
| 前置条件 | 用户未登录 |
| 输入字段 | 学号（必填）、密码（必填） |
| 处理逻辑 | 验证学号+密码 → 检查账号状态（封禁则拒绝） → 写入Session |
| 成功反馈 | 跳转至首页 `/index` |
| 失败反馈 | 显示错误消息："学号或密码错误，请重新登录！" 或 "您的账号已被封禁，请联系管理员！" |
| 实现状态 | ✅ 已实现 |

#### 5.1.2 用户注册

| 属性 | 说明 |
|------|------|
| 功能ID | F-USER-02 |
| 页面路径 | `/user?method=register` → `user_register.jsp` |
| 触发方式 | 点击导航栏"注册"链接（未登录状态） |
| 前置条件 | 用户未登录 |
| 输入字段 | 学号（必填）、用户名（必填）、密码（必填）、确认密码（必填）、姓名（必填）、手机号（选填）、学校（选填）、邮箱（选填）、QQ号（选填） |
| 处理逻辑 | 验证两次密码一致 → 检查学号/用户名唯一性 → 写入数据库 |
| 成功反馈 | 显示"注册成功，请登录！" |
| 失败反馈 | 显示"学号或用户名已被注册！"或"两次密码不一致！" |
| 实现状态 | ✅ 已实现 |

#### 5.1.3 用户登出

| 属性 | 说明 |
|------|------|
| 功能ID | F-USER-03 |
| 触发方式 | 点击导航栏"退出"链接（已登录状态） |
| 处理逻辑 | 销毁Session → 重定向至首页 |
| 实现状态 | ✅ 已实现 |

### 5.2 个人中心模块

#### 5.2.1 个人中心首页

| 属性 | 说明 |
|------|------|
| 功能ID | F-USER-04 |
| 页面路径 | `/user?method=center` → `user_center.jsp` |
| 前置条件 | 用户已登录 |
| 页面内容 | 用户信息卡片（头像占位、姓名、学号、学校）、管理员标识（如有）、功能Tabs（个人信息/我发布的/我收藏的/我的订单）、修改个人信息表单、修改密码表单 |
| 实现状态 | ✅ 已实现 |

#### 5.2.2 修改个人信息

| 属性 | 说明 |
|------|------|
| 功能ID | F-USER-05 |
| 触发方式 | 在个人中心修改个人信息表单提交 |
| 输入字段 | 姓名、手机号、地址、学校、QQ号 |
| 处理逻辑 | 更新数据库 → 刷新Session |
| 成功反馈 | 显示"信息修改成功！" |
| 实现状态 | ✅ 已实现 |

#### 5.2.3 修改密码

| 属性 | 说明 |
|------|------|
| 功能ID | F-USER-06 |
| 触发方式 | 在个人中心修改密码表单提交 |
| 输入字段 | 原密码、新密码 |
| 处理逻辑 | 验证原密码正确 → 更新密码 → 刷新Session |
| 成功反馈 | 显示"密码修改成功！" |
| 失败反馈 | 显示"原密码错误！" |
| 实现状态 | ✅ 已实现 |

#### 5.2.4 我发布的商品

| 属性 | 说明 |
|------|------|
| 功能ID | F-USER-07 |
| 页面路径 | `/user?method=myProducts` → `user_products.jsp` |
| 前置条件 | 用户已登录 |
| 页面内容 | 商品卡片网格（含编辑/删除按钮、状态标签）、分页导航、空状态提示 |
| 实现状态 | ✅ 已实现 |

#### 5.2.5 我收藏的商品

| 属性 | 说明 |
|------|------|
| 功能ID | F-USER-08 |
| 页面路径 | `/user?method=myFavorites` → `user_favorites.jsp` |
| 前置条件 | 用户已登录 |
| 页面内容 | 商品卡片网格（含立即购买/取消收藏按钮）、分页导航、空状态提示 |
| 实现状态 | ✅ 已实现 |

### 5.3 商品浏览模块

#### 5.3.1 首页

| 属性 | 说明 |
|------|------|
| 功能ID | F-PROD-01 |
| 页面路径 | `/index` → `index.jsp` |
| 触发方式 | 访问网站根路径/点击导航栏"首页" |
| 页面内容 | 标题"TradeHub"/"校园二手交易平台"、搜索框、分类标签栏、最新发布商品网格（12个）、热门推荐榜单（10个）、空状态提示 |
| 数据来源 | IndexServlet → latestList（最新12个）、hotList（热门10个）、categoryList（全局分类） |
| 实现状态 | ✅ 已实现 |

#### 5.3.2 商品列表（分类浏览）

| 属性 | 说明 |
|------|------|
| 功能ID | F-PROD-02 |
| 页面路径 | `/product?method=list&categoryId={id}&sort={sort}` → `product_list.jsp` |
| 触发方式 | 点击分类标签/导航栏"全部商品" |
| 页面内容 | 分类标题、排序Tabs（最新/最热/价格↑/价格↓）、分类标签栏、商品卡片网格、分页导航、空状态提示 |
| 排序方式 | newest（默认，按发布时间）、hot（按浏览量）、price_asc（价格升序）、price_desc（价格降序） |
| 每页数量 | 12个商品 |
| 实现状态 | ✅ 已实现 |

#### 5.3.3 商品搜索

| 属性 | 说明 |
|------|------|
| 功能ID | F-PROD-03 |
| 页面路径 | `/product?method=search&keyword={kw}&categoryId={id}&priceMin={min}&priceMax={max}&sort={sort}` → `product_search.jsp` |
| 触发方式 | 首页搜索框/商品列表搜索框 |
| 搜索条件 | 关键词（模糊匹配商品名称）、分类、价格区间（最低价-最高价）、排序 |
| 页面内容 | 搜索表单、排序Tabs、搜索结果计数、商品卡片网格、分页导航、空状态提示 |
| 实现状态 | ✅ 已实现 |

#### 5.3.4 商品详情

| 属性 | 说明 |
|------|------|
| 功能ID | F-PROD-04 |
| 页面路径 | `/product?method=detail&id={id}` → `product_detail.jsp` |
| 触发方式 | 点击商品卡片/商品链接 |
| 页面内容 | 商品大图、商品名称、成色标签、分类标签、售价、原价（如有）、浏览量、发布时间、卖家信息（头像占位/名称/学校）、操作按钮（立即购买/收藏/状态标签）、商品描述 |
| 特殊逻辑 | 每次访问详情页浏览量+1 |
| 实现状态 | ✅ 已实现 |

### 5.4 商品发布模块

#### 5.4.1 发布商品

| 属性 | 说明 |
|------|------|
| 功能ID | F-PROD-05 |
| 页面路径 | `/product?method=publish` → `product_publish.jsp` |
| 触发方式 | 点击导航栏"发布商品"按钮（已登录） |
| 前置条件 | 用户已登录 |
| 输入字段 | 商品名称（必填）、分类（必填，下拉选择）、成色（必填，下拉选择：全新/几乎全新/有使用痕迹/老旧）、售价（必填）、原价（选填）、商品描述（选填）、商品图片（选填，文件上传） |
| 处理逻辑 | GET请求：加载分类列表展示表单；POST请求：接收multipart表单数据，处理文件上传（UUID重命名），写入数据库 |
| 成功反馈 | 跳转至商品列表页 |
| 实现状态 | ✅ 已实现 |

#### 5.4.2 编辑商品

| 属性 | 说明 |
|------|------|
| 功能ID | F-PROD-06 |
| 页面路径 | `/product?method=edit&id={id}` → `product_edit.jsp` |
| 触发方式 | 在"我发布的"页面点击"编辑"按钮 |
| 前置条件 | 用户已登录、商品属于当前用户 |
| 输入字段 | 同发布商品，预填已有数据，图片可留空（不修改） |
| 处理逻辑 | GET请求：加载商品数据和分类列表；POST请求：更新数据，图片留空则保留原图 |
| 成功反馈 | 跳转至商品详情页 |
| 实现状态 | ✅ 已实现 |

#### 5.4.3 删除商品

| 属性 | 说明 |
|------|------|
| 功能ID | F-PROD-07 |
| 触发方式 | 在"我发布的"页面点击"删除"按钮（需确认） |
| 前置条件 | 用户已登录、商品属于当前用户 |
| 处理逻辑 | 从数据库删除商品记录 |
| 成功反馈 | 刷新"我发布的"页面 |
| 实现状态 | ✅ 已实现 |

### 5.5 交易流程模块

#### 5.5.1 下单（提交订单）

| 属性 | 说明 |
|------|------|
| 功能ID | F-ORDER-01 |
| 页面路径 | `/order?method=submit&productId={id}` → `order_submit.jsp` |
| 触发方式 | 点击商品详情页"立即购买"按钮 |
| 前置条件 | 用户已登录、商品状态为"在售" |
| 页面内容 | 商品信息展示（图片/名称/成色/分类/价格）、联系方式表单（联系人/联系电话/交易地点/给卖家留言） |
| 实现状态 | ✅ 已实现 |

#### 5.5.2 确认下单

| 属性 | 说明 |
|------|------|
| 功能ID | F-ORDER-02 |
| 触发方式 | 在订单确认页提交表单 |
| 处理逻辑 | 创建订单 + 订单项 → 商品状态改为"已售"（status=1）→ 事务提交 |
| 成功反馈 | 跳转至"我的订单"页面 |
| 实现状态 | ✅ 已实现 |

#### 5.5.3 我的订单

| 属性 | 说明 |
|------|------|
| 功能ID | F-ORDER-03 |
| 页面路径 | `/order?method=myOrders&tab={buyer/seller}` → `order_list.jsp` |
| 触发方式 | 点击个人中心"我的订单"Tab |
| 前置条件 | 用户已登录 |
| 页面内容 | 买家/卖家Tab切换、订单卡片列表（订单编号、状态标签、商品项、交易信息、金额）、空状态提示 |
| 实现状态 | ✅ 已实现 |

#### 5.5.4 确认交易（卖家）

| 属性 | 说明 |
|------|------|
| 功能ID | F-ORDER-04 |
| 触发方式 | 在"我卖出的"订单列表中点击"确认交易"按钮 |
| 前置条件 | 用户已登录、订单状态为"待确认"、当前用户为卖家 |
| 处理逻辑 | 订单状态改为"交易完成"（status=1） |
| 成功反馈 | 刷新订单列表 |
| 实现状态 | ✅ 已实现 |

#### 5.5.5 取消订单（卖家）

| 属性 | 说明 |
|------|------|
| 功能ID | F-ORDER-05 |
| 触发方式 | 在"我卖出的"订单列表中点击"取消订单"按钮（需确认） |
| 前置条件 | 用户已登录、订单状态为"待确认"、当前用户为卖家 |
| 处理逻辑 | 订单状态改为"已取消"（status=2）→ 商品状态恢复为"在售"（status=0）→ 事务提交 |
| 成功反馈 | 刷新订单列表 |
| 实现状态 | ✅ 已实现 |

### 5.6 收藏模块

#### 5.6.1 添加收藏

| 属性 | 说明 |
|------|------|
| 功能ID | F-FAV-01 |
| 触发方式 | 在商品详情页点击"☆ 收藏"按钮 |
| 前置条件 | 用户已登录 |
| 处理逻辑 | AJAX异步请求，INSERT IGNORE（防重复） |
| 成功反馈 | 按钮变为"★ 已收藏"（黄色样式） |
| 失败反馈 | 未登录提示 |
| 实现状态 | ✅ 已实现 |

#### 5.6.2 取消收藏

| 属性 | 说明 |
|------|------|
| 功能ID | F-FAV-02 |
| 触发方式 | 在商品详情页点击"★ 已收藏"按钮 / 在收藏列表点击"取消收藏" |
| 前置条件 | 用户已登录 |
| 处理逻辑 | AJAX异步请求，DELETE |
| 成功反馈 | 按钮变为"☆ 收藏" / 刷新收藏列表 |
| 实现状态 | ✅ 已实现 |

### 5.7 后台管理模块

#### 5.7.1 后台首页

| 属性 | 说明 |
|------|------|
| 功能ID | F-ADMIN-01 |
| 页面路径 | `/admin` → `admin/index.jsp` |
| 前置条件 | 用户已登录、isadmin=true |
| 页面内容 | 统计卡片（用户总数、分类数量）、功能入口卡片（用户管理/商品管理/分类管理） |
| 实现状态 | ✅ 已实现 |

#### 5.7.2 用户管理

| 属性 | 说明 |
|------|------|
| 功能ID | F-ADMIN-02 |
| 页面路径 | `/admin?method=userList` → `admin/user_list.jsp` |
| 前置条件 | 管理员已登录 |
| 页面内容 | 用户表格（ID/用户名/学号/姓名/手机号/学校/状态/操作）、分页导航 |
| 操作 | 封禁（正常→封禁）、解封（封禁→正常），管理员不可被封禁 |
| 实现状态 | ✅ 已实现 |

#### 5.7.3 商品管理

| 属性 | 说明 |
|------|------|
| 功能ID | F-ADMIN-03 |
| 页面路径 | `/admin?method=productList` → `admin/product_list.jsp` |
| 前置条件 | 管理员已登录 |
| 页面内容 | 商品表格（ID/名称/价格/分类/发布者/状态/操作）、分页导航 |
| 操作 | 下架（在售/已售→已下架），已下架商品不可重复操作 |
| 实现状态 | ✅ 已实现 |

#### 5.7.4 分类管理

| 属性 | 说明 |
|------|------|
| 功能ID | F-ADMIN-04 |
| 页面路径 | `/admin?method=categoryList` → `admin/category_list.jsp` |
| 前置条件 | 管理员已登录 |
| 页面内容 | 分类表格（ID/名称/描述/操作）、添加分类表单（展开/收起）、编辑分类弹窗 |
| 操作 | 添加（名称+描述）、编辑（弹窗表单）、删除（需确认） |
| 实现状态 | ✅ 已实现 |

---

## 六、核心业务流程图与状态转换图

### 6.1 用户注册登录流程

```
[用户访问网站]
      │
      ▼
[首页] ──── 未登录 ────→ [导航栏显示：登录/注册]
      │                          │
      │                    ┌─────┴─────┐
      │                    ▼           ▼
      │              [登录页]      [注册页]
      │                    │           │
      │              输入学号+密码   填写注册信息
      │                    │           │
      │              ┌─────┴─────┐     │
      │              ▼           ▼     ▼
      │         [验证通过]  [验证失败] [注册成功]
      │              │           │     │
      │              ▼           ▼     ▼
      │         [写入Session] [显示错误] [跳转登录]
      │              │
      │              ▼
      └─── 已登录 ──→ [导航栏显示：发布商品/用户名/退出]
```

### 6.2 商品发布流程

```
[卖家已登录]
      │
      ▼
[点击"发布商品"]
      │
      ▼
[填写商品信息表单]
  ├── 商品名称（必填）
  ├── 分类（必填，下拉选择）
  ├── 成色（必填，下拉选择）
  ├── 售价（必填）
  ├── 原价（选填）
  ├── 商品描述（选填）
  └── 图片上传（选填）
      │
      ▼
[提交表单]
      │
      ▼
[文件上传处理]
  ├── 有图片 → UUID重命名 → 保存到 picture/ 目录
  └── 无图片 → 跳过
      │
      ▼
[写入数据库] → status=0（在售）
      │
      ▼
[跳转商品列表]
```

### 6.3 交易流程

```
[买家查看商品详情]
      │
      ▼
[点击"立即购买"]
      │
      ▼
[填写联系方式]
  ├── 联系人（必填）
  ├── 联系电话（必填）
  ├── 交易地点（必填）
  └── 给卖家留言（选填）
      │
      ▼
[确认下单]
      │
      ▼
┌─────────────────────────┐
│ 事务：                   │
│ 1. 创建订单（status=0）  │
│ 2. 创建订单项            │
│ 3. 商品状态→已售（status=1）│
└─────────────────────────┘
      │
      ▼
[卖家查看订单]
      │
      ├──→ [确认交易] → 订单status=1（交易完成）
      │
      └──→ [取消订单]
                │
                ▼
            ┌─────────────────────────┐
            │ 事务：                   │
            │ 1. 订单status=2（已取消） │
            │ 2. 商品status=0（在售）   │
            └─────────────────────────┘
```

### 6.4 商品状态转换图

```
                  ┌──────────┐
                  │   在售    │
                  │ status=0  │
                  └─────┬────┘
                        │
          ┌─────────────┼─────────────┐
          │             │             │
    买家下单         管理员下架       （无操作）
          │             │             │
          ▼             ▼             ▼
    ┌──────────┐  ┌──────────┐  ┌──────────┐
    │   已售    │  │  已下架   │  │   在售    │
    │ status=1  │  │ status=2  │  │ status=0  │
    └──────────┘  └──────────┘  └──────────┘
          │
    卖家取消订单
          │
          ▼
    ┌──────────┐
    │   在售    │
    │ status=0  │
    └──────────┘
```

### 6.5 订单状态转换图

```
    ┌──────────┐
    │  待确认   │
    │ status=0  │
    └─────┬────┘
          │
    ┌─────┴─────┐
    │           │
卖家确认交易   卖家取消订单
    │           │
    ▼           ▼
┌──────────┐ ┌──────────┐
│ 交易完成  │ │  已取消   │
│ status=1  │ │ status=2  │
└──────────┘ └──────────┘
```

---

## 七、交互规则与反馈机制说明

### 7.1 表单验证规则

| 页面 | 字段 | 验证规则 | 反馈方式 |
|------|------|----------|----------|
| 登录 | 学号 | 必填 | 浏览器原生required |
| 登录 | 密码 | 必填 | 浏览器原生required |
| 注册 | 学号 | 必填、唯一 | 服务端校验失败显示错误消息 |
| 注册 | 密码/确认密码 | 必填、两次一致 | 服务端校验失败显示错误消息 |
| 发布商品 | 商品名称 | 必填 | 浏览器原生required |
| 发布商品 | 分类 | 必选 | 浏览器原生required |
| 发布商品 | 售价 | 必填、数字 | 浏览器原生required + type=number |
| 下单 | 联系人/电话/地点 | 必填 | 浏览器原生required |

### 7.2 权限控制规则

| 场景 | 规则 | 处理方式 |
|------|------|----------|
| 未登录访问需要登录的页面 | 拒绝访问 | 重定向至登录页 |
| 非管理员访问后台 | 拒绝访问 | AdminFilter拦截，重定向至首页 |
| 编辑他人商品 | 拒绝操作 | 权限检查失败，重定向至"我发布的" |
| 操作他人订单 | 拒绝操作 | 权限检查失败，忽略操作 |

### 7.3 消息反馈机制

| 消息类型 | 显示样式 | 应用场景 |
|----------|----------|----------|
| 成功消息 | 绿色背景 + 绿色边框 | 注册成功、修改信息成功、修改密码成功 |
| 失败消息 | 红色背景 + 红色边框 | 登录失败、密码错误、账号被封禁 |
| 确认对话框 | 浏览器confirm() | 删除商品、取消订单、删除分类 |
| AJAX反馈 | 按钮状态切换 | 收藏/取消收藏 |

### 7.4 空状态处理

| 场景 | 空状态展示 |
|------|------------|
| 无商品（首页最新发布） | 📦图标 + "暂无商品，快去发布第一个吧！" |
| 无商品（分类列表） | 📦图标 + "该分类暂无商品" |
| 无搜索结果 | 🔍图标 + "没有找到相关商品" |
| 无收藏商品 | ⭐图标 + "还没有收藏任何商品" + "去逛逛"按钮 |
| 无发布商品 | 📦图标 + "还没有发布任何商品" + "发布第一个商品"按钮 |
| 无购买订单 | 🛒图标 + "还没有买过任何商品" + "去逛逛"按钮 |
| 无卖出订单 | 📦图标 + "还没有卖出的订单" |

---

## 八、设计规范与视觉要求

### 8.1 设计系统

| 设计元素 | 规范 |
|----------|------|
| CSS框架 | Tailwind CSS（CDN引入） |
| 主色调 | blue-600 (#2563EB) |
| 辅助色 | pink-500 (#DB2777) - 发布商品按钮 |
| 背景色 | gray-100 (#F3F4F6) - 页面背景 |
| 卡片背景 | white (#FFFFFF) |
| 成功色 | green-600 / green-100 |
| 警告色 | yellow-600 / yellow-100 |
| 错误色 | red-500 / red-50 |
| 文字主色 | gray-800 (#1F2937) |
| 文字辅助色 | gray-500 (#6B7280) |
| 圆角 | rounded-lg (8px) / rounded-xl (12px) / rounded-2xl (16px) |
| 阴影 | shadow-md / shadow-lg / shadow-xl |
| 字体 | 系统默认字体栈 |
| 响应式断点 | sm:640px / md:768px / lg:1024px / xl:1280px |

### 8.2 组件规范

| 组件 | 样式规范 |
|------|----------|
| 主按钮 | bg-blue-600 text-white py-3 rounded-lg font-semibold hover:bg-blue-700 |
| 次按钮 | border border-gray-300 rounded-lg text-gray-700 hover:bg-gray-50 |
| 输入框 | w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 |
| 商品卡片 | bg-white rounded-xl shadow-md overflow-hidden hover:shadow-xl |
| 商品图片 | w-full h-48 object-cover |
| 导航栏 | bg-blue-600 text-white shadow-lg h-16 |
| 页脚 | bg-gray-800 text-white |
| 状态标签-在售 | bg-green-100 text-green-700 |
| 状态标签-已售 | bg-red-100 text-red-700 |
| 状态标签-已下架 | bg-gray-100 text-gray-700 |
| 状态标签-待确认 | bg-yellow-100 text-yellow-700 |
| 状态标签-交易完成 | bg-green-100 text-green-700 |

### 8.3 页面布局规范

| 页面类型 | 布局方式 |
|----------|----------|
| 首页 | 单列居中（max-w-7xl），响应式网格 |
| 登录/注册 | 居中卡片（max-w-md/max-w-lg），垂直居中 |
| 列表页 | 单列居中（max-w-7xl），响应式网格 |
| 详情页 | 两栏布局（md:grid-cols-2） |
| 表单页 | 居中卡片（max-w-2xl） |
| 后台页 | 全宽布局，暗色导航栏 |
| 订单页 | 单列居中（max-w-7xl），订单卡片列表 |

---

## 九、需求优先级划分与排期建议

### 9.1 需求优先级

| 优先级 | 标识 | 定义 | 包含功能 |
|--------|------|------|----------|
| P0 | 核心 | 产品MVP必须功能 | 用户注册/登录、商品发布/浏览/搜索、下单购买 |
| P1 | 重要 | 提升用户体验的关键功能 | 收藏功能、个人中心、订单管理、管理员后台 |
| P2 | 增强 | 增强产品竞争力的功能 | 消息通知、评价系统、商品推荐算法 |
| P3 | 远期 | 产品长期发展方向 | 在线支付、IM聊天、小程序端 |

### 9.2 当前项目实现状态

| 优先级 | 功能模块 | 实现状态 |
|--------|----------|----------|
| P0 | 用户注册/登录 | ✅ 已实现 |
| P0 | 商品发布（含图片上传） | ✅ 已实现 |
| P0 | 商品浏览（分类/搜索/排序） | ✅ 已实现 |
| P0 | 商品详情 | ✅ 已实现 |
| P0 | 下单购买 | ✅ 已实现 |
| P1 | 收藏功能 | ✅ 已实现 |
| P1 | 个人中心（信息修改/密码修改） | ✅ 已实现 |
| P1 | 订单管理（买家/卖家视角） | ✅ 已实现 |
| P1 | 管理员后台（用户/商品/分类管理） | ✅ 已实现 |
| P2 | 消息通知系统 | ❌ 未实现 |
| P2 | 用户评价/信誉系统 | ❌ 未实现 |
| P2 | 商品推荐算法 | ❌ 未实现（当前仅按浏览量排序） |
| P2 | 用户头像上传 | ❌ 未实现（仅有占位圆） |
| P2 | 移动端原生适配 | ❌ 未实现（仅响应式） |
| P3 | 在线支付集成 | ❌ 未实现 |
| P3 | 站内即时通讯 | ❌ 未实现 |
| P3 | 微信小程序 | ❌ 未实现 |

### 9.3 下一阶段建议

#### P2-01：消息通知系统
- **功能描述**：当用户收藏的商品降价、订单状态变更时，向用户发送站内通知
- **必要性分析**：提升用户活跃度和交易效率，减少用户反复查看订单状态的时间成本
- **预期用户价值**：高 - 用户可及时获知交易进展
- **实现建议**：新增notification表，在订单状态变更和商品编辑时触发通知创建

#### P2-02：用户评价系统
- **功能描述**：交易完成后，买卖双方互评（好评/中评/差评 + 文字评价）
- **必要性分析**：建立用户信誉体系，降低交易风险，提升平台信任度
- **预期用户价值**：高 - 帮助用户选择更可靠的交易对象
- **实现建议**：新增review表，关联订单，在交易完成后展示评价入口

#### P2-03：用户头像上传
- **功能描述**：用户可在个人中心上传头像图片
- **必要性分析**：增强用户身份认同感，提升社区氛围
- **预期用户价值**：中 - 提升用户体验，但不影响核心交易流程
- **实现建议**：复用现有文件上传逻辑，在User表avatar字段存储路径

#### P2-04：商品状态变更通知
- **功能描述**：商品被管理员下架时通知卖家原因
- **必要性分析**：增加平台运营透明度，减少用户困惑
- **预期用户价值**：中 - 提升用户体验
- **实现建议**：在offShelf方法中增加reason参数，通过通知系统发送

---

## 十、技术架构详解

### 10.1 项目结构

```
CookieShop/
├── src/
│   ├── servlet/                    # Servlet层（控制器）
│   │   ├── BaseServlet.java        # 基础Servlet（反射分发）
│   │   ├── IndexServlet.java       # 首页
│   │   ├── UserServlet.java        # 用户相关
│   │   ├── ProductServlet.java     # 商品相关
│   │   ├── OrderServlet.java       # 订单相关
│   │   ├── FavoriteServlet.java    # 收藏相关
│   │   ├── CategoryServlet.java    # 分类相关
│   │   └── AdminServlet.java       # 后台管理
│   ├── model/                      # 数据模型层
│   │   ├── User.java
│   │   ├── Product.java
│   │   ├── Order.java
│   │   ├── OrderItem.java
│   │   ├── Category.java
│   │   ├── Favorite.java
│   │   └── Page.java               # 分页模型
│   ├── dao/                        # 数据访问层
│   │   ├── UserDao.java
│   │   ├── ProductDao.java
│   │   ├── OrderDao.java
│   │   ├── CategoryDao.java
│   │   └── FavoriteDao.java
│   ├── service/                    # 业务逻辑层
│   │   ├── UserService.java
│   │   ├── ProductService.java
│   │   ├── OrderService.java
│   │   ├── CategoryService.java
│   │   └── FavoriteService.java
│   ├── filter/
│   │   └── AdminFilter.java        # 管理员权限过滤器
│   ├── listener/
│   │   └── ApplicationListener.java # 应用启动监听器
│   └── utils/
│       └── DataSourceUtils.java    # 数据库连接工具
├── web/
│   ├── WEB-INF/
│   │   ├── web.xml                 # 部署描述符
│   │   └── lib/                    # 依赖JAR包
│   ├── *.jsp                       # 前端页面（15个）
│   ├── admin/                      # 后台页面（5个）
│   └── picture/                    # 商品图片目录
└── tradehub.sql                    # 数据库初始化脚本
```

### 10.2 架构模式

项目采用 **MVC（Model-View-Controller）** 架构模式：

| 层级 | 技术 | 职责 |
|------|------|------|
| Controller | Servlet + BaseServlet（反射） | 接收请求、参数解析、调用Service、返回视图 |
| Model | Java POJO + DAO | 数据模型、数据库操作 |
| View | JSP + JSTL + Tailwind CSS | 页面渲染、数据展示 |
| Service | Java Service类 | 业务逻辑封装、事务管理 |

### 10.3 BaseServlet反射分发机制

BaseServlet是所有业务Servlet的父类，通过Java反射机制实现统一的请求分发：

```java
// 请求URL: /user?method=login
// BaseServlet解析method参数 → 调用UserServlet.login()方法
// 方法返回String:
//   - "redirect:/index" → 重定向
//   - "json:{\"ok\":true}" → 返回JSON
//   - "/user_login.jsp" → 转发到JSP
```

### 10.4 数据库连接池

使用C3P0连接池管理数据库连接，配置文件为 `src/c3p0-config.xml`：

| 配置项 | 值 |
|--------|-----|
| 数据库驱动 | com.mysql.cj.jdbc.Driver |
| 连接URL | jdbc:mysql://localhost:3306/tradehub |
| 字符集 | utf-8 |
| 用户名 | root |
| 密码 | root |

---

## 十一、数据库设计

### 11.1 ER图（文字描述）

```
user (用户表) ──1:N──→ product (商品表)
user (用户表) ──1:N──→ order (订单表，买家/卖家)
user (用户表) ──1:N──→ favorite (收藏表)
category (分类表) ──1:N──→ product (商品表)
order (订单表) ──1:N──→ orderitem (订单项表)
product (商品表) ──1:N──→ orderitem (订单项表)
product (商品表) ──1:N──→ favorite (收藏表)
```

### 11.2 数据表结构

#### user 表

| 字段 | 类型 | 约束 | 说明 |
|------|------|------|------|
| id | INT(11) | PK, AUTO_INCREMENT | 用户ID |
| username | VARCHAR(45) | NOT NULL, UNIQUE | 用户名 |
| student_id | VARCHAR(45) | UNIQUE | 学号 |
| email | VARCHAR(45) | UNIQUE | 邮箱 |
| password | VARCHAR(45) | NOT NULL | 密码 |
| name | VARCHAR(45) | | 姓名 |
| phone | VARCHAR(45) | | 手机号 |
| address | VARCHAR(100) | | 地址 |
| avatar | VARCHAR(200) | | 头像URL |
| school | VARCHAR(100) | | 学校 |
| qq | VARCHAR(45) | | QQ号 |
| isadmin | BIT(1) | DEFAULT 0 | 是否管理员 |
| status | TINYINT(1) | DEFAULT 1 | 1正常/0封禁 |

#### category 表

| 字段 | 类型 | 约束 | 说明 |
|------|------|------|------|
| id | INT(11) | PK, AUTO_INCREMENT | 分类ID |
| name | VARCHAR(45) | NOT NULL | 分类名称 |
| description | VARCHAR(200) | | 分类描述 |

#### product 表

| 字段 | 类型 | 约束 | 说明 |
|------|------|------|------|
| id | INT(11) | PK, AUTO_INCREMENT | 商品ID |
| name | VARCHAR(100) | NOT NULL | 商品名称 |
| price | FLOAT | NOT NULL | 售价 |
| price_original | FLOAT | | 原价 |
| description | TEXT | | 商品描述 |
| image | VARCHAR(200) | | 图片路径 |
| condition_level | TINYINT(1) | DEFAULT 1 | 成色：1全新/2几乎全新/3有使用痕迹/4老旧 |
| status | TINYINT(1) | DEFAULT 0 | 状态：0在售/1已售/2下架 |
| views | INT(11) | DEFAULT 0 | 浏览量 |
| created_time | DATETIME | DEFAULT CURRENT_TIMESTAMP | 发布时间 |
| user_id | INT(11) | NOT NULL, FK | 发布者ID |
| category_id | INT(11) | FK | 分类ID |

#### order 表

| 字段 | 类型 | 约束 | 说明 |
|------|------|------|------|
| id | INT(11) | PK, AUTO_INCREMENT | 订单ID |
| total | FLOAT | NOT NULL | 交易金额 |
| status | TINYINT(1) | DEFAULT 0 | 0待确认/1交易完成/2已取消 |
| name | VARCHAR(45) | | 联系人 |
| phone | VARCHAR(45) | | 联系电话 |
| address | VARCHAR(200) | | 交易地点 |
| seller_msg | VARCHAR(500) | | 买家留言 |
| datetime | DATETIME | DEFAULT CURRENT_TIMESTAMP | 下单时间 |
| buyer_id | INT(11) | NOT NULL, FK | 买家ID |
| seller_id | INT(11) | NOT NULL, FK | 卖家ID |

#### orderitem 表

| 字段 | 类型 | 约束 | 说明 |
|------|------|------|------|
| id | INT(11) | PK, AUTO_INCREMENT | 订单项ID |
| price | FLOAT | NOT NULL | 成交价 |
| product_id | INT(11) | NOT NULL, FK | 商品ID |
| order_id | INT(11) | NOT NULL, FK | 订单ID |

#### favorite 表

| 字段 | 类型 | 约束 | 说明 |
|------|------|------|------|
| id | INT(11) | PK, AUTO_INCREMENT | 收藏ID |
| user_id | INT(11) | NOT NULL, FK | 用户ID |
| product_id | INT(11) | NOT NULL, FK | 商品ID |
| created_time | DATETIME | DEFAULT CURRENT_TIMESTAMP | 收藏时间 |
| 联合唯一约束 | (user_id, product_id) | UNIQUE | 同一用户不能重复收藏同一商品 |

---

## 十二、API接口文档

### 12.1 URL映射总览

| URL Pattern | Servlet | 主要方法 |
|-------------|---------|----------|
| `/index` | IndexServlet | index() |
| `/user` | UserServlet | login, register, logout, center, changeAddress, changePwd, myProducts, myFavorites |
| `/product` | ProductServlet | list, detail, search, publish, edit, delete |
| `/order` | OrderServlet | submit, confirm, myOrders, confirmDeal, cancel |
| `/favorite` | FavoriteServlet | add, remove, list |
| `/category` | CategoryServlet | (预留) |
| `/admin` | AdminServlet | index, userList, banUser, productList, offShelf, categoryList, categoryAdd, categoryEdit, categoryDelete |

### 12.2 接口详细说明

#### UserServlet

| method | HTTP方法 | URL示例 | 参数 | 返回 |
|--------|----------|---------|------|------|
| login | POST | /user?method=login | student_id, password | redirect:/index 或 /user_login.jsp |
| register | POST | /user?method=register | student_id, username, password, confirm_password, name, phone, school, email, qq | /user_register.jsp |
| logout | GET | /user?method=logout | - | redirect:/index |
| center | GET | /user?method=center | - | /user_center.jsp |
| changeAddress | POST | /user?method=changeAddress | name, phone, address, school, qq | /user_center.jsp |
| changePwd | POST | /user?method=changePwd | password, newPassword | /user_center.jsp |
| myProducts | GET | /user?method=myProducts | pageNumber(可选) | /user_products.jsp |
| myFavorites | GET | /user?method=myFavorites | - | redirect:/favorite?method=list |

#### ProductServlet

| method | HTTP方法 | URL示例 | 参数 | 返回 |
|--------|----------|---------|------|------|
| list | GET | /product?method=list&categoryId={id}&sort={sort}&pageNumber={n} | categoryId, sort, pageNumber | /product_list.jsp |
| detail | GET | /product?method=detail&id={id} | id | /product_detail.jsp |
| search | GET | /product?method=search&keyword={kw}&categoryId={id}&priceMin={min}&priceMax={max}&sort={sort} | keyword, categoryId, priceMin, priceMax, sort | /product_search.jsp |
| publish | GET/POST | /product?method=publish | multipart: name, price, price_original, description, condition_level, category_id, image | GET: /product_publish.jsp; POST: redirect:/product?method=list |
| edit | GET/POST | /product?method=edit&id={id} | multipart: id, name, price, price_original, description, condition_level, category_id, image | GET: /product_edit.jsp; POST: redirect:/product?method=detail&id={id} |
| delete | GET | /product?method=delete&id={id} | id | redirect:/user?method=myProducts |

#### OrderServlet

| method | HTTP方法 | URL示例 | 参数 | 返回 |
|--------|----------|---------|------|------|
| submit | GET | /order?method=submit&productId={id} | productId | /order_submit.jsp |
| confirm | POST | /order?method=confirm | productId, name, phone, address, seller_msg | redirect:/order?method=myOrders |
| myOrders | GET | /order?method=myOrders&tab={buyer/seller} | tab | /order_list.jsp |
| confirmDeal | GET | /order?method=confirmDeal&orderId={id} | orderId | redirect:/order?method=myOrders |
| cancel | GET | /order?method=cancel&orderId={id} | orderId | redirect:/order?method=myOrders |

#### FavoriteServlet

| method | HTTP方法 | URL示例 | 参数 | 返回 |
|--------|----------|---------|------|------|
| add | POST | /favorite?method=add&productId={id} | productId | JSON: {"ok":true} |
| remove | POST | /favorite?method=remove&productId={id} | productId | JSON: {"ok":true} |
| list | GET | /favorite?method=list&pageNumber={n} | pageNumber | /user_favorites.jsp |

#### AdminServlet

| method | HTTP方法 | URL示例 | 参数 | 返回 |
|--------|----------|---------|------|------|
| index | GET | /admin | - | /admin/index.jsp |
| userList | GET | /admin?method=userList&pageNumber={n} | pageNumber | /admin/user_list.jsp |
| banUser | GET | /admin?method=banUser&id={id}&status={0/1} | id, status | redirect:/admin?method=userList |
| productList | GET | /admin?method=productList&pageNumber={n} | pageNumber | /admin/product_list.jsp |
| offShelf | GET | /admin?method=offShelf&id={id} | id | redirect:/admin?method=productList |
| categoryList | GET | /admin?method=categoryList | - | /admin/category_list.jsp |
| categoryAdd | POST | /admin?method=categoryAdd | name, description | redirect:/admin?method=categoryList |
| categoryEdit | POST | /admin?method=categoryEdit | id, name, description | redirect:/admin?method=categoryList |
| categoryDelete | GET | /admin?method=categoryDelete&id={id} | id | redirect:/admin?method=categoryList |

---

## 十三、项目启动与部署教程

### 13.1 环境要求

| 软件 | 版本要求 | 说明 |
|------|----------|------|
| JDK | 8 或更高 | Java开发环境 |
| MySQL | 5.7 或更高 | 数据库 |
| Apache Tomcat | 8.5 或更高 | Web服务器 |
| IntelliJ IDEA | 任意版本 | 推荐开发工具 |
| Maven/Gradle | 无需 | 项目使用传统lib管理依赖 |

### 13.2 启动步骤

#### 步骤1：安装环境

1. 安装 JDK 8+，配置 `JAVA_HOME` 环境变量
2. 安装 MySQL 5.7+，确保 MySQL 服务正在运行
3. 安装 Apache Tomcat 8.5+，解压到任意目录
4. 安装 IntelliJ IDEA（推荐 Ultimate 版本）

#### 步骤2：初始化数据库

1. 启动 MySQL 服务
2. 使用 MySQL 客户端（如 Navicat、MySQL Workbench 或命令行）连接数据库
3. 执行项目根目录下的 `tradehub.sql` 脚本：

```sql
-- 方式一：命令行
mysql -u root -p < c:\Users\wsh\Desktop\CookieShop\tradehub.sql

-- 方式二：在MySQL客户端中
source c:\Users\wsh\Desktop\CookieShop\tradehub.sql;
```

4. 验证数据库创建成功：
```sql
USE tradehub;
SHOW TABLES;
-- 应显示：category, favorite, order, orderitem, product, user
```

#### 步骤3：配置数据库连接

1. 打开 `src/c3p0-config.xml`
2. 确认数据库连接参数与本地环境一致：
   - `jdbcUrl`：默认 `jdbc:mysql://localhost:3306/tradehub`
   - `user`：默认 `root`
   - `password`：默认 `root`

> 如果MySQL密码不是 `root`，请修改 `password` 为实际密码

#### 步骤4：配置Tomcat（IntelliJ IDEA）

1. 打开 IntelliJ IDEA
2. 选择 `File → Open`，选择项目目录 `c:\Users\wsh\Desktop\CookieShop\CookieShop`
3. 配置 Tomcat：
   - `Run → Edit Configurations`
   - 点击 `+` → `Tomcat Server → Local`
   - 在 `Application Server` 中选择 Tomcat 安装目录
   - 在 `Deployment` Tab 中添加 `CookieShop:war exploded`
   - 设置 `Application context` 为 `/CookieShop`
4. 点击 `OK` 保存

#### 步骤5：启动项目

1. 点击 IntelliJ IDEA 工具栏的绿色运行按钮（或按 Shift+F10）
2. 等待控制台输出 `Server startup in XXXX ms`
3. 浏览器自动打开 `http://localhost:8080/CookieShop/`

#### 步骤6：验证功能

| 验证项 | 操作 | 预期结果 |
|--------|------|----------|
| 首页访问 | 访问 `http://localhost:8080/CookieShop/index` | 显示首页，包含最新商品和热门推荐 |
| 用户登录 | 点击"登录"，使用 admin/admin 登录 | 登录成功，导航栏显示管理员信息 |
| 商品浏览 | 点击"全部商品" | 显示商品列表，支持分类筛选和排序 |
| 商品发布 | 点击"发布商品" | 填写表单后可发布新商品 |
| 后台管理 | 使用admin账号登录后，点击"后台" | 进入后台管理页面 |

### 13.3 测试账号

| 角色 | 学号 | 密码 | 说明 |
|------|------|------|------|
| 管理员 | 20240001 | admin | 拥有后台管理权限 |
| 普通用户 | 20240002 | 123456 | 张三，可发布/购买商品 |
| 普通用户 | 20240003 | 123456 | 李四，可发布/购买商品 |

### 13.4 常见问题排查

| 问题 | 可能原因 | 解决方案 |
|------|----------|----------|
| 404错误 | Tomcat配置错误 | 检查Deployment和Application context设置 |
| 500错误 | 数据库连接失败 | 检查MySQL是否启动、c3p0-config.xml密码是否正确 |
| 商品图片不显示 | picture目录权限问题 | 确保picture目录存在且有读写权限 |
| 登录失败 | 数据库未初始化 | 执行tradehub.sql初始化脚本 |
| 中文乱码 | 编码问题 | 确认c3p0-config.xml中characterEncoding=utf-8 |
| 后台无法访问 | 非管理员账号 | 使用admin/admin账号登录 |

---

## 十四、附录：功能状态矩阵

### 14.1 页面-功能全覆盖矩阵

| 页面 | 功能项 | 实现状态 | 备注 |
|------|--------|----------|------|
| 全局导航栏 | TradeHub Logo/品牌链接 | ✅ | 点击跳转首页 |
| 全局导航栏 | 首页链接 | ✅ | |
| 全局导航栏 | 全部商品链接 | ✅ | |
| 全局导航栏 | 分类标签（前5个） | ✅ | 仅md+屏幕显示 |
| 全局导航栏 | 登录链接（未登录） | ✅ | |
| 全局导航栏 | 注册按钮（未登录） | ✅ | 白色填充按钮 |
| 全局导航栏 | 发布商品按钮（已登录） | ✅ | 粉色按钮 |
| 全局导航栏 | 用户名链接（已登录） | ✅ | 跳转个人中心 |
| 全局导航栏 | 后台链接（管理员） | ✅ | 条件显示 |
| 全局导航栏 | 退出链接（已登录） | ✅ | |
| 全局导航栏 | 移动端响应式菜单 | ❌ | 未实现汉堡菜单 |
| 全局页脚 | 品牌信息 | ✅ | |
| 全局页脚 | 快速链接 | ✅ | 全部商品/发布商品/我的订单 |
| 全局页脚 | 联系方式 | ✅ | 邮箱 |
| 全局页脚 | 版权信息 | ✅ | |
| 首页 | 搜索框 | ✅ | 关键词搜索 |
| 首页 | 分类标签栏 | ✅ | 全部 + 6个分类 |
| 首页 | 最新发布商品网格 | ✅ | 12个商品，含空状态 |
| 首页 | 热门推荐榜单 | ✅ | 10个商品，含排名 |
| 首页 | 商品卡片点击跳转详情 | ✅ | |
| 登录页 | 学号输入框 | ✅ | |
| 登录页 | 密码输入框 | ✅ | |
| 登录页 | 登录按钮 | ✅ | |
| 登录页 | 错误消息显示 | ✅ | 红色提示 |
| 登录页 | 成功消息显示 | ✅ | 绿色提示 |
| 登录页 | 注册引导链接 | ✅ | |
| 登录页 | 记住密码 | ❌ | 未实现 |
| 登录页 | 忘记密码 | ❌ | 未实现 |
| 注册页 | 学号输入框 | ✅ | |
| 注册页 | 用户名输入框 | ✅ | |
| 注册页 | 密码/确认密码 | ✅ | 前后端双重验证 |
| 注册页 | 姓名/手机号/学校/邮箱/QQ号 | ✅ | |
| 注册页 | 注册按钮 | ✅ | |
| 注册页 | 登录引导链接 | ✅ | |
| 注册页 | 邮箱验证 | ❌ | 未实现 |
| 注册页 | 学号真实性验证 | ❌ | 未实现 |
| 个人中心 | 用户信息卡片 | ✅ | 头像占位/姓名/学号/学校 |
| 个人中心 | 管理员标识 | ✅ | 条件显示 |
| 个人中心 | 功能Tabs | ✅ | 个人信息/我发布的/我收藏的/我的订单 |
| 个人中心 | 修改个人信息表单 | ✅ | 姓名/手机号/地址/学校/QQ号 |
| 个人中心 | 修改密码表单 | ✅ | 原密码/新密码 |
| 个人中心 | 头像上传 | ❌ | 仅有占位圆 |
| 我发布的 | 商品卡片网格 | ✅ | 含编辑/删除按钮 |
| 我发布的 | 商品状态标签 | ✅ | 在售/已售/已下架 |
| 我发布的 | 分页导航 | ✅ | |
| 我发布的 | 空状态提示 | ✅ | |
| 我发布的 | 发布新商品按钮 | ✅ | |
| 我收藏的 | 商品卡片网格 | ✅ | 含立即购买/取消收藏 |
| 我收藏的 | 分页导航 | ✅ | |
| 我收藏的 | 空状态提示 | ✅ | |
| 商品列表 | 分类标题 | ✅ | |
| 商品列表 | 排序Tabs | ✅ | 最新/最热/价格↑/价格↓ |
| 商品列表 | 分类标签栏 | ✅ | |
| 商品列表 | 商品卡片网格 | ✅ | |
| 商品列表 | 分页导航 | ✅ | |
| 商品搜索 | 搜索表单 | ✅ | 关键词/分类/价格区间 |
| 商品搜索 | 排序Tabs | ✅ | |
| 商品搜索 | 搜索结果计数 | ✅ | |
| 商品搜索 | 商品卡片网格 | ✅ | |
| 商品搜索 | 分页导航 | ✅ | |
| 商品详情 | 商品大图 | ✅ | |
| 商品详情 | 商品信息展示 | ✅ | 名称/成色/分类/价格/原价/浏览量/时间 |
| 商品详情 | 卖家信息卡片 | ✅ | 头像占位/卖家名 |
| 商品详情 | 立即购买按钮 | ✅ | 仅商品在售时显示 |
| 商品详情 | 收藏按钮 | ✅ | AJAX切换 |
| 商品详情 | 商品描述 | ✅ | |
| 商品详情 | 商品图片轮播 | ❌ | 仅展示单张图片 |
| 商品详情 | 相关商品推荐 | ❌ | 未实现 |
| 商品详情 | 卖家其他商品 | ❌ | 未实现 |
| 发布商品 | 商品名称输入 | ✅ | |
| 发布商品 | 分类下拉选择 | ✅ | 动态加载 |
| 发布商品 | 成色下拉选择 | ✅ | 4档 |
| 发布商品 | 售价输入 | ✅ | |
| 发布商品 | 原价输入 | ✅ | 选填 |
| 发布商品 | 描述文本框 | ✅ | 选填 |
| 发布商品 | 图片上传 | ✅ | 单张 |
| 发布商品 | 多图上传 | ❌ | 仅支持单张 |
| 发布商品 | 图片预览 | ❌ | 上传前无预览 |
| 编辑商品 | 表单预填 | ✅ | |
| 编辑商品 | 当前图片预览 | ✅ | |
| 编辑商品 | 图片更新 | ✅ | 留空保留原图 |
| 确认订单 | 商品信息展示 | ✅ | |
| 确认订单 | 联系方式表单 | ✅ | 联系人/电话/地点/留言 |
| 确认订单 | 确认下单按钮 | ✅ | |
| 确认订单 | 数量选择 | ❌ | 固定为1 |
| 我的订单 | 买家/卖家Tab切换 | ✅ | |
| 我的订单 | 订单卡片列表 | ✅ | |
| 我的订单 | 订单状态标签 | ✅ | 待确认/交易完成/已取消 |
| 我的订单 | 确认交易按钮 | ✅ | 卖家+待确认状态 |
| 我的订单 | 取消订单按钮 | ✅ | 卖家+待确认状态 |
| 我的订单 | 空状态提示 | ✅ | |
| 我的订单 | 订单搜索/筛选 | ❌ | 未实现 |
| 后台首页 | 统计卡片 | ✅ | 用户总数/分类数量 |
| 后台首页 | 功能入口卡片 | ✅ | |
| 用户管理 | 用户表格 | ✅ | |
| 用户管理 | 封禁/解封操作 | ✅ | |
| 用户管理 | 分页导航 | ✅ | |
| 用户管理 | 用户搜索 | ❌ | 未实现 |
| 商品管理 | 商品表格 | ✅ | |
| 商品管理 | 下架操作 | ✅ | |
| 商品管理 | 分页导航 | ✅ | |
| 分类管理 | 添加分类表单 | ✅ | 展开/收起 |
| 分类管理 | 编辑分类弹窗 | ✅ | |
| 分类管理 | 删除分类 | ✅ | 需确认 |
| 分类管理 | 分类商品数统计 | ❌ | 未实现 |

### 14.2 全局功能-技术状态矩阵

| 功能类别 | 功能项 | 实现状态 | 实现方式 |
|----------|--------|----------|----------|
| 安全性 | Session认证 | ✅ | Session.getAttribute("user") |
| 安全性 | 管理员权限过滤 | ✅ | AdminFilter @WebFilter |
| 安全性 | 密码加密存储 | ❌ | 当前明文存储 |
| 安全性 | CSRF防护 | ❌ | 未实现 |
| 安全性 | XSS防护 | ❌ | 未实现 |
| 安全性 | SQL注入防护 | ✅ | 使用PreparedStatement（QueryRunner） |
| 用户体验 | 响应式设计 | ✅ | Tailwind CSS响应式断点 |
| 用户体验 | 表单验证 | ✅ | 前端HTML5 + 后端校验 |
| 用户体验 | 确认对话框 | ✅ | 浏览器confirm() |
| 用户体验 | 空状态处理 | ✅ | 各页面均有空状态提示 |
| 用户体验 | 分页 | ✅ | Page模型 + JSP分页导航 |
| 用户体验 | AJAX异步操作 | ✅ | 收藏功能使用Fetch API |
| 用户体验 | 消息提示 | ✅ | 页面内嵌消息提示 |
| 性能 | 数据库连接池 | ✅ | C3P0 |
| 性能 | 图片上传 | ✅ | Commons FileUpload |
| 性能 | 浏览量统计 | ✅ | 每次访问+1 |
| 代码质量 | MVC分层 | ✅ | Servlet/Service/DAO/Model |
| 代码质量 | 反射分发 | ✅ | BaseServlet统一入口 |
| 代码质量 | 事务管理 | ✅ | 订单创建/取消使用事务 |
| 代码质量 | 异常处理 | ✅ | try-catch + 日志 |

---

> **文档结束**
>
> 本文档基于 TradeHub 项目 v1.0 完整代码分析编写，涵盖了产品设计、技术架构、功能清单、交互规则、数据库设计、API文档和部署教程等全部维度。开发团队可直接依据本文档进行二次开发和功能迭代。