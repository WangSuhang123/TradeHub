# TradeHub Vibe Coding 阶段化执行提示词

> 本文档是面向 AI 编程助手的**可执行改造提示词**，按阶段依次执行。
> **核心规则：每个阶段的所有成功标准必须验证通过后，才能进入下一阶段。**
> **每条提示词可直接复制给 AI 助手执行。**

---

## ⚠️ 执行前必读规则

```
┌─────────────────────────────────────────────────────────────────┐
│                     Vibe Coding 执行规则                         │
├─────────────────────────────────────────────────────────────────┤
│ 1. 严格按阶段顺序执行（Phase 1 → 2 → 3 → 4 → 5）               │
│ 2. 每阶段完成后，必须验证"✅ 成功标准"清单                      │
│ 3. 所有标准通过后，方可进入下一阶段                              │
│ 4. 如某标准无法通过，先在本阶段内修复再继续                      │
│ 5. 遇到阻塞性问题，先搜索现有代码确认，严禁猜测                   │
│ 6. 每修改一个文件后，编译检查确保无语法错误                      │
│ 7. 所有Java文件使用UTF-8编码                                    │
│ 8. 改造前务必备份原始项目（复制整个CookieShop目录）              │
└─────────────────────────────────────────────────────────────────┘
```

---

## Phase 1: 底层重构与数据库设计

### 📋 阶段目标
创建新数据库、编写所有Model类、搭建BaseServlet架构、配置Tailwind CSS骨架。

### 📂 当前项目状态
- 项目路径：`c:\Users\wsh\Desktop\CookieShop\CookieShop\`
- 存在36个旧Servlet（全部待废弃）
- 前端使用Bootstrap 3
- 数据库名为 `cookieshop`

---

### 🔧 Phase 1.1 创建数据库

**可复制给AI的提示词**：

```
Phase 1.1 创建新数据库

请在以下路径创建 tradehub.sql 文件：
c:\Users\wsh\Desktop\CookieShop\tradehub.sql

该SQL文件需包含：
1. 创建数据库 tradehub
2. 创建6张新表（user/category/product/order/orderitem/favorite）
3. 插入初始数据

具体建表语句如下：

--- 数据库 ---
CREATE DATABASE tradehub DEFAULT CHARACTER SET utf8;
USE tradehub;

--- user 表 ---
CREATE TABLE `user` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `student_id` VARCHAR(45) DEFAULT NULL COMMENT '学号',
  `email` VARCHAR(45) DEFAULT NULL,
  `password` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) DEFAULT NULL,
  `phone` VARCHAR(45) DEFAULT NULL,
  `address` VARCHAR(100) DEFAULT NULL,
  `avatar` VARCHAR(200) DEFAULT NULL,
  `school` VARCHAR(100) DEFAULT NULL,
  `qq` VARCHAR(45) DEFAULT NULL,
  `isadmin` BIT(1) DEFAULT b'0',
  `status` TINYINT(1) DEFAULT 1 COMMENT '1正常/0封禁',
  PRIMARY KEY (`id`),
  UNIQUE KEY (`username`),
  UNIQUE KEY (`student_id`),
  UNIQUE KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--- category 表 ---
CREATE TABLE `category` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO category VALUES 
(1,'书籍教材','二手教材、考研资料、课外读物'),
(2,'数码产品','手机、电脑、平板、耳机'),
(3,'生活用品','日用品、宿舍用品、小家电'),
(4,'服饰鞋包','衣物、鞋子、背包、配饰'),
(5,'运动器材','球类、健身器材、户外装备'),
(6,'其他闲置','其他校园闲置物品');

--- product 表 ---
CREATE TABLE `product` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `price` FLOAT NOT NULL,
  `price_original` FLOAT DEFAULT NULL,
  `description` TEXT,
  `image` VARCHAR(200) DEFAULT NULL,
  `condition_level` TINYINT(1) DEFAULT 1 COMMENT '1全新/2几乎全新/3有使用痕迹/4老旧',
  `status` TINYINT(1) DEFAULT 0 COMMENT '0在售/1已售/2下架',
  `views` INT(11) DEFAULT 0,
  `created_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `user_id` INT(11) NOT NULL,
  `category_id` INT(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY (`user_id`),
  KEY (`category_id`),
  CONSTRAINT FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT FOREIGN KEY (`category_id`) REFERENCES `category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--- order 表 ---
CREATE TABLE `order` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `total` FLOAT NOT NULL,
  `status` TINYINT(1) DEFAULT 0 COMMENT '0待确认/1交易完成/2已取消',
  `name` VARCHAR(45) DEFAULT NULL,
  `phone` VARCHAR(45) DEFAULT NULL,
  `address` VARCHAR(200) DEFAULT NULL COMMENT '交易地点',
  `seller_msg` VARCHAR(500) DEFAULT NULL,
  `datetime` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `buyer_id` INT(11) NOT NULL,
  `seller_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY (`buyer_id`),
  KEY (`seller_id`),
  CONSTRAINT FOREIGN KEY (`buyer_id`) REFERENCES `user` (`id`),
  CONSTRAINT FOREIGN KEY (`seller_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--- orderitem 表 ---
CREATE TABLE `orderitem` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `price` FLOAT NOT NULL,
  `product_id` INT(11) NOT NULL,
  `order_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY (`product_id`),
  KEY (`order_id`),
  CONSTRAINT FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT FOREIGN KEY (`order_id`) REFERENCES `order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--- favorite 表 ---
CREATE TABLE `favorite` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NOT NULL,
  `product_id` INT(11) NOT NULL,
  `created_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY (`user_id`, `product_id`),
  KEY (`user_id`),
  KEY (`product_id`),
  CONSTRAINT FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--- 初始用户 ---
INSERT INTO user VALUES 
(1,'admin','20240001','admin@tradehub.com','admin','系统管理员','13800000000','管理员办公室',NULL,'某某大学',NULL,1,1),
(2,'zhangsan','20240002','zhangsan@qq.com','123456','张三','13900000001','3号宿舍楼401',NULL,'某某大学','123456789',0,1),
(3,'lisi','20240003','lisi@qq.com','123456','李四','13900000002','5号宿舍楼202',NULL,'某某大学','987654321',0,1);

--- 初始商品（10条） ---
INSERT INTO product (name,price,price_original,description,image,condition_level,status,views,created_time,user_id,category_id) VALUES 
('高等数学（第七版）上册',18,45,'几乎全新的高数教材，只用过一学期。','picture/1-1.jpg',2,0,128,'2026-05-15 10:30:00',2,1),
('iPad Air 4 64G 银色',2800,4799,'2022年购入，屏幕完好，电池85%。','picture/2-1.jpg',3,0,256,'2026-05-20 14:20:00',2,2),
('华为Mate 60 Pro 512G',4200,6999,'去年买的，无拆无修，全套配件齐全。','picture/3-1.jpg',2,0,512,'2026-05-18 09:00:00',3,2),
('全新未拆封台灯',35,59,'LED护眼台灯，全新未拆封。','picture/4-1.jpg',1,0,89,'2026-05-22 16:45:00',3,3),
('考研英语二真题（2020-2025）',12,59.8,'只用铅笔做过几页，已擦干净。','picture/5-1.jpg',3,0,67,'2026-05-25 11:10:00',2,1),
('达尔优机械键盘 青轴',80,199,'用了半年，按键灵敏，有轻微痕迹。','picture/6-1.jpg',3,0,198,'2026-05-19 20:30:00',3,3),
('Nike篮球鞋 42码',150,799,'穿了一个月，九成新。','picture/7-1.jpg',2,0,345,'2026-05-10 08:15:00',2,5),
('全新运动外套 L码',60,169,'买来不适合自己，吊牌还在。','picture/8-1.jpg',1,0,76,'2026-05-28 13:00:00',3,4),
('Python编程从入门到实践',25,89,'经典入门书，书角有轻微折痕。','picture/9-1.jpg',3,0,210,'2026-05-12 17:00:00',2,1),
('床上书桌 折叠桌',20,45,'宿舍必备，有点小划痕。','picture/10-1.jpg',4,0,156,'2026-05-24 22:00:00',3,3);

修改 c3p0-config.xml (路径: CookieShop/src/c3p0-config.xml)：
- 将 jdbcUrl 中的 cookieshop 改为 tradehub

执行 tradehub.sql 后，用以下SQL验证：
SELECT COUNT(*) FROM product;  -- 预期返回 10
SELECT COUNT(*) FROM category; -- 预期返回 6
SELECT COUNT(*) FROM user;     -- 预期返回 3
```

**✅ Phase 1.1 成功标准**：
- [ ] `tradehub.sql` 文件已创建
- [ ] 数据库 tradehub 可连接，product表有10条数据
- [ ] c3p0-config.xml中jdbcUrl已改为tradehub

---

### 🔧 Phase 1.2 编写所有新Model类

**可复制给AI的提示词**：

```
Phase 1.2 编写所有新Model类

请逐个创建以下Java文件。每个文件需包含：所有字段的private声明、空参构造器、全参构造器、所有getter/setter、toString()方法。

### 1. 重写 User.java
路径：CookieShop/src/model/User.java

新字段（共13个）：
- int id
- String username (NOT NULL)
- String student_id (学号)
- String email
- String password (NOT NULL)
- String name (姓名)
- String phone
- String address
- String avatar (头像URL)
- String school (学校)
- String qq (QQ号)
- boolean isadmin (默认false)
- int status (1正常/0封禁，默认1)

新增构造器：User(String username, String studentId, String email, String password, String name, String phone, String school)

### 2. 创建 Category.java（全新，替代Type.java）
路径：CookieShop/src/model/Category.java

```java
package model;

public class Category {
    private int id;
    private String name;
    private String description;
    // + 空参构造器、全参构造器、getter/setter
}
```

### 3. 创建 Product.java（全新，替代Goods.java）
路径：CookieShop/src/model/Product.java

字段：
- int id
- String name (商品名称)
- float price (售价)
- float priceOriginal (原价)
- String description (商品描述)
- String image (图片路径)
- int conditionLevel (1全新/2几乎全新/3有使用痕迹/4老旧)
- int status (0在售/1已售/2下架)
- int views (浏览量)
- Date createdTime (发布时间)
- int userId (发布者ID)
- int categoryId (分类ID)
- Category category (关联对象)
- User user (关联对象，发布者)
- String userName (用于列表展示)

注意：
- 字段名使用驼峰（如priceOriginal对应price_original）
- 需要 setCategoryId(int id) 方法和 setUserName(String name) 方法（供DBUtils BeanHandler映射用）
- toString需包含所有字段

### 4. 重写 Order.java
路径：CookieShop/src/model/Order.java

新字段（删除amount/paytype，修改status语义，拆分user_id）：
- int id
- float total
- int status (0待确认/1交易完成/2已取消)
- String name (联系人)
- String phone
- String address (交易地点)
- String sellerMsg (卖家留言)
- Date datetime
- int buyerId (买家ID)
- int sellerId (卖家ID)
- User buyer (买家对象)
- User seller (卖家对象)
- String buyerName (映射用)
- List<OrderItem> itemList

废弃方法：addGoods()/lessen()/delete()（不再需要购物车功能）
废弃字段：itemMap

### 5. 重写 OrderItem.java
路径：CookieShop/src/model/OrderItem.java

将 goods 替换为 product：
- int id
- float price
- int productId (替代goods)
- int orderId
- Product product
- Order order
- String productName (映射用)

### 6. 创建 Favorite.java（全新）
路径：CookieShop/src/model/Favorite.java

```java
package model;

import java.util.Date;

public class Favorite {
    private int id;
    private int userId;
    private int productId;
    private Date createdTime;
    // + 关联字段
    private Product product;
    // + 构造器 + getter/setter
}
```

### 7. Page.java 保持不动
不修改，直接复用。

请确认所有7个Model文件编译通过。
```

**✅ Phase 1.2 成功标准**：
- [ ] 7个Model文件全部创建/修改完成
- [ ] Product.java替代了Goods.java
- [ ] Category.java替代了Type.java
- [ ] Order.java删除了itemMap/addGoods/lessen/delete等购物车方法
- [ ] 所有文件编译无语法错误

---

### 🔧 Phase 1.3 编写BaseServlet + 废弃旧Servlet

**可复制给AI的提示词**：

```
Phase 1.3 编写BaseServlet并创建7个业务Servlet骨架

### 步骤1：创建 BaseServlet.java
路径：CookieShop/src/servlet/BaseServlet.java

```java
package servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.Method;

public class BaseServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");

        String methodName = request.getParameter("method");
        if (methodName == null || methodName.isEmpty()) {
            methodName = "index";
        }

        try {
            Method method = this.getClass().getMethod(methodName, 
                HttpServletRequest.class, HttpServletResponse.class);
            String result = (String) method.invoke(this, request, response);
            
            if (result != null) {
                if (result.startsWith("redirect:")) {
                    response.sendRedirect(request.getContextPath() + result.substring(9));
                } else if (result.startsWith("json:")) {
                    response.setContentType("application/json;charset=utf-8");
                    response.getWriter().print(result.substring(5));
                } else {
                    request.getRequestDispatcher(result).forward(request, response);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }
}
```

### 步骤2：创建7个业务Servlet骨架

每个Servlet继承BaseServlet，暂时只写一个index()方法返回对应JSP页面。

#### UserServlet.java
路径：CookieShop/src/servlet/UserServlet.java
```java
package servlet;
import javax.servlet.http.*;
import java.io.IOException;

public class UserServlet extends BaseServlet {
    public String index(HttpServletRequest request, HttpServletResponse response) {
        return "/user_login.jsp";
    }
    // 后续Phase添加：login/register/logout/center/changeAddress/changePwd/myProducts/myFavorites
}
```

#### ProductServlet.java
```java
package servlet;
import javax.servlet.http.*;
import java.io.IOException;

public class ProductServlet extends BaseServlet {
    public String index(HttpServletRequest request, HttpServletResponse response) {
        return "/index.jsp";
    }
    // 后续Phase添加：list/detail/publish/edit/delete/search
}
```

#### OrderServlet.java, CategoryServlet.java, FavoriteServlet.java, AdminServlet.java
（同上格式，每个Servlet的index()返回各自的默认JSP页面）

### 步骤3：删除所有旧Servlet

删除 CookieShop/src/servlet/ 目录下所有以 "Admin" 开头的Servlet文件，以及所有其他旧Servlet（保留新的7个+BaseServlet）。

要删除的文件列表（36个）：
GoodsBuyServlet.java, GoodsDeleteServlet.java, GoodsDetailServlet.java, GoodsLessenServlet.java, GoodsListServlet.java, GoodRecommendListServlet.java, GoodsSearchServlet.java, IndexServlet.java, OrderConfirmServlet.java, OrderListServlet.java, OrderSubmitServlet.java, UserChangeAddressServlet.java, UserChangePwd.java, UserLoginServlet.java, UserLogoutServlet.java, UserRegisterServlet.java, AdminGoodsAddServlet.java, AdminGoodsDeleteServlet.java, AdminGoodsEditServlet.java, AdminGoodsEditshowServelt.java, AdminGoodsListServlet.java, AdminGoodsRecommendServlet.java, AdminOrderDeleteServlet.java, AdminOrderListServlet.java, AdminOrderStatusServlet.java, AdminTypeAddServlet.java, AdminTypeDeleteServlet.java, AdminTypeEditServlet.java, AdminTypeListServlet.java, AdminUserAddServlet.java, AdminUserDeleteServlet.java, AdminUserEditServlet.java, AdminUserEditshowServlet.java, AdminUserListServlet.java, AdminUserResetServlet.java

注意：只删除以上文件，不要删除BaseServlet.java和7个新业务Servlet。

### 步骤4：修改 Listener
路径：CookieShop/src/listener/ApplicationListener.java

修改内容：
- 将 TypeService tsService = new TypeService(); 改为注释掉（后续Phase再改）
- contextInitialized中注释掉加载typeList的代码
- 添加注释 // TODO Phase3: 加载categoryList

### 步骤5：修改 AdminFilter
路径：CookieShop/src/filter/AdminFilter.java

修改内容：
- 将重定向路径从 `../index.jsp` 改为 `request.getContextPath() + "/index.jsp"`
- 注解 @WebFilter(filterName="AdminFilter",urlPatterns="/admin/*") 保持不变
```

**✅ Phase 1.3 成功标准**：
- [ ] BaseServlet.java编译通过
- [ ] 7个业务Servlet编译通过（UserServlet/ProductServlet/OrderServlet/CategoryServlet/FavoriteServlet/AdminServlet/IndexServlet）
- [ ] 旧36个Servlet全部删除
- [ ] ApplicationListener.java编译通过
- [ ] AdminFilter.java编译通过

---

### 🔧 Phase 1.4 搭建Tailwind CSS项目骨架

**可复制给AI的提示词**：

```
Phase 1.4 搭建Tailwind CSS项目骨架

### 步骤1：重写 web.xml
路径：CookieShop/web/WEB-INF/web.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-app_3_1.xsd"
         version="3.1"
         metadata-complete="false">
    <display-name>TradeHub</display-name>
    <welcome-file-list>
        <welcome-file>index</welcome-file>
    </welcome-file-list>
    
    <servlet>
        <servlet-name>IndexServlet</servlet-name>
        <servlet-class>servlet.IndexServlet</servlet-class>
    </servlet>
    <servlet-mapping>
        <servlet-name>IndexServlet</servlet-name>
        <url-pattern>/index</url-pattern>
    </servlet-mapping>
    
    <servlet>
        <servlet-name>UserServlet</servlet-name>
        <servlet-class>servlet.UserServlet</servlet-class>
    </servlet>
    <servlet-mapping>
        <servlet-name>UserServlet</servlet-name>
        <url-pattern>/user</url-pattern>
    </servlet-mapping>
    
    <servlet>
        <servlet-name>ProductServlet</servlet-name>
        <servlet-class>servlet.ProductServlet</servlet-class>
    </servlet>
    <servlet-mapping>
        <servlet-name>ProductServlet</servlet-name>
        <url-pattern>/product</url-pattern>
    </servlet-mapping>
    
    <servlet>
        <servlet-name>OrderServlet</servlet-name>
        <servlet-class>servlet.OrderServlet</servlet-class>
    </servlet>
    <servlet-mapping>
        <servlet-name>OrderServlet</servlet-name>
        <url-pattern>/order</url-pattern>
    </servlet-mapping>
    
    <servlet>
        <servlet-name>CategoryServlet</servlet-name>
        <servlet-class>servlet.CategoryServlet</servlet-class>
    </servlet>
    <servlet-mapping>
        <servlet-name>CategoryServlet</servlet-name>
        <url-pattern>/category</url-pattern>
    </servlet-mapping>
    
    <servlet>
        <servlet-name>FavoriteServlet</servlet-name>
        <servlet-class>servlet.FavoriteServlet</servlet-class>
    </servlet>
    <servlet-mapping>
        <servlet-name>FavoriteServlet</servlet-name>
        <url-pattern>/favorite</url-pattern>
    </servlet-mapping>
    
    <servlet>
        <servlet-name>AdminServlet</servlet-name>
        <servlet-class>servlet.AdminServlet</servlet-class>
    </servlet>
    <servlet-mapping>
        <servlet-name>AdminServlet</servlet-name>
        <url-pattern>/admin</url-pattern>
    </servlet-mapping>
</web-app>
```

### 步骤2：创建 Tailwind 版 header.jsp
路径：CookieShop/web/header.jsp

使用Tailwind CDN重写导航栏：
```html
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script src="https://cdn.tailwindcss.com"></script>
<script>
  tailwind.config = {
    theme: {
      extend: {
        colors: {
          primary: '#2563EB',
          accent: '#DB2777',
        }
      }
    }
  }
</script>

<nav class="bg-blue-600 text-white shadow-lg">
  <div class="max-w-7xl mx-auto px-4">
    <div class="flex justify-between items-center h-16">
      <div class="flex items-center space-x-4">
        <a href="/index" class="text-2xl font-bold">TradeHub</a>
        <a href="/index" class="hover:text-blue-200">首页</a>
        <a href="/product?method=list" class="hover:text-blue-200">全部商品</a>
        <c:forEach items="${categoryList}" var="cat" begin="0" end="4">
          <a href="/product?method=list&categoryId=${cat.id}" class="hover:text-blue-200 hidden md:block">${cat.name}</a>
        </c:forEach>
      </div>
      <div class="flex items-center space-x-4">
        <c:choose>
          <c:when test="${empty user}">
            <a href="/user?method=login" class="hover:text-blue-200">登录</a>
            <a href="/user?method=register" class="bg-white text-blue-600 px-4 py-2 rounded-lg font-semibold">注册</a>
          </c:when>
          <c:otherwise>
            <a href="/product?method=publish" class="bg-pink-500 hover:bg-pink-600 px-4 py-2 rounded-lg">发布商品</a>
            <a href="/user?method=center" class="hover:text-blue-200">${user.name}</a>
            <c:if test="${user.isadmin}">
              <a href="/admin" class="hover:text-blue-200">后台</a>
            </c:if>
            <a href="/user?method=logout" class="hover:text-blue-200">退出</a>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </div>
</nav>
```

### 步骤3：创建 Tailwind 版 footer.jsp
路径：CookieShop/web/footer.jsp

```html
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<footer class="bg-gray-800 text-white mt-12">
  <div class="max-w-7xl mx-auto px-4 py-8">
    <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
      <div>
        <h3 class="text-lg font-bold mb-4">TradeHub</h3>
        <p class="text-gray-400 text-sm">校园二手交易平台，让闲置物品找到新主人。</p>
      </div>
      <div>
        <h3 class="text-lg font-bold mb-4">快速链接</h3>
        <ul class="space-y-2 text-gray-400 text-sm">
          <li><a href="/product?method=list" class="hover:text-white">全部商品</a></li>
          <li><a href="/product?method=publish" class="hover:text-white">发布商品</a></li>
          <li><a href="/order?method=myOrders" class="hover:text-white">我的订单</a></li>
        </ul>
      </div>
      <div>
        <h3 class="text-lg font-bold mb-4">联系方式</h3>
        <p class="text-gray-400 text-sm">联系邮箱：support@tradehub.com</p>
      </div>
    </div>
    <div class="border-t border-gray-700 mt-8 pt-4 text-center text-gray-400 text-sm">
      © 2026 TradeHub. All Rights Reserved.
    </div>
  </div>
</footer>
```

### 步骤4：创建 Tailwind 骨架版 index.jsp
路径：CookieShop/web/index.jsp

一个基础的Tailwind首页骨架，包含header.jsp和footer.jsp引入，页面主体暂时显示"TradeHub 校园二手交易平台"标题。

### 步骤5：复制 index.jsp 到 admin/index.jsp
路径：CookieShop/web/admin/index.jsp
修改为"后台管理"标题，引入 admin/header.jsp。

### 步骤6：创建 admin/header.jsp
路径：CookieShop/web/admin/header.jsp
Tailwind版后台导航栏。

### 步骤7：删除旧CSS文件
- 删除 CookieShop/web/css/style.css
- 删除 CookieShop/web/css/bootstrap.css
- 删除 CookieShop/web/css/flexslider.css
- 删除 CookieShop/web/admin/css/bootstrap.css
- 删除 CookieShop/web/admin/css/ (整个目录如果还有其他文件)
```

**✅ Phase 1.4 成功标准**：
- [ ] web.xml包含所有7个Servlet映射
- [ ] header.jsp和footer.jsp使用Tailwind样式
- [ ] index.jsp能正常渲染Tailwind骨架页面
- [ ] 旧CSS文件已全部删除
- [ ] Tomcat启动无异常
- [ ] 访问 http://localhost:8080/TradeHub/ 显示Tailwind版首页
- [ ] 访问 http://localhost:8080/TradeHub/user?method=index 显示登录页

---

### 🎯 Phase 1 完成验证清单

```
Phase 1 全部完成验证：
- [ ] 数据库 tradehub 创建成功，6张表+初始数据
- [ ] c3p0-config.xml 数据库名已改为 tradehub
- [ ] 7个Model类编译通过，旧Model已废弃
- [ ] BaseServlet 编译通过
- [ ] 7个业务Servlet编译通过（骨架）
- [ ] ApplicationListener 和 AdminFilter 修改完成
- [ ] web.xml 重写完成
- [ ] header.jsp / footer.jsp / index.jsp Tailwind重写完成
- [ ] 旧CSS文件已删除
- [ ] Tomcat 启动无任何异常
- [ ] 浏览器访问首页显示 TradeHub Tailwind 页面
```

**⚠️ 以上全部通过后，才能进入 Phase 2。**

---

## Phase 2: 用户中心与商品发布

### 📋 阶段目标
实现学号+密码登录/注册、个人中心管理、商品发布功能。

### 📂 Phase 1完成后的项目状态
- 7个Model类就绪
- BaseServlet + 7个业务Servlet骨架就绪
- Tailwind CSS框架搭建完成
- web.xml配置完毕
- 所有DAO/Service层尚未创建

---

### 🔧 Phase 2.1 编写 UserDao + UserService

**可复制给AI的提示词**：

```
Phase 2.1 编写 UserDao 和 UserService

### 步骤1：重写 UserDao.java
路径：CookieShop/src/dao/UserDao.java

使用 Apache Commons DBUtils 操作新 user 表。需要的方法：

```java
package dao;
import model.User;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;
import utils.DataSourceUtils;
import java.sql.SQLException;
import java.util.List;

public class UserDao {
    public void addUser(User user) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "INSERT INTO user(username,student_id,email,password,name,phone,address,avatar,school,qq,isadmin,status) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)";
        r.update(sql, user.getUsername(), user.getStudentId(), user.getEmail(), user.getPassword(),
                user.getName(), user.getPhone(), user.getAddress(), user.getAvatar(),
                user.getSchool(), user.getQq(), user.isIsadmin(), user.getStatus());
    }
    
    public boolean isStudentIdExist(String studentId) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "SELECT * FROM user WHERE student_id = ?";
        User u = r.query(sql, new BeanHandler<User>(User.class), studentId);
        return u != null;
    }
    
    public boolean isUsernameExist(String username) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "SELECT * FROM user WHERE username = ?";
        User u = r.query(sql, new BeanHandler<User>(User.class), username);
        return u != null;
    }
    
    public User selectByStudentIdPassword(String studentId, String password) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "SELECT * FROM user WHERE student_id=? AND password=? AND status=1";
        return r.query(sql, new BeanHandler<User>(User.class), studentId, password);
    }
    
    public User selectById(int id) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "SELECT * FROM user WHERE id=?";
        return r.query(sql, new BeanHandler<User>(User.class), id);
    }
    
    public void updateUser(User user) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "UPDATE user SET name=?, phone=?, address=?, avatar=?, school=?, qq=? WHERE id=?";
        r.update(sql, user.getName(), user.getPhone(), user.getAddress(), user.getAvatar(),
                user.getSchool(), user.getQq(), user.getId());
    }
    
    public void updatePwd(int id, String newPassword) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "UPDATE user SET password=? WHERE id=?";
        r.update(sql, newPassword, id);
    }
    
    public int selectUserCount() throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "SELECT COUNT(*) FROM user";
        return r.query(sql, new ScalarHandler<Long>()).intValue();
    }
    
    public List<User> selectUserList(int pageNo, int pageSize) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "SELECT * FROM user LIMIT ?,?";
        return r.query(sql, new BeanListHandler<User>(User.class), (pageNo-1)*pageSize, pageSize);
    }
    
    public void updateStatus(int id, int status) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "UPDATE user SET status=? WHERE id=?";
        r.update(sql, status, id);
    }
    
    public void delete(int id) throws SQLException {
        QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "DELETE FROM user WHERE id=?";
        r.update(sql, id);
    }
}
```

### 步骤2：重写 UserService.java
路径：CookieShop/src/service/UserService.java

```java
package service;
import dao.UserDao;
import model.Page;
import model.User;
import java.sql.SQLException;
import java.util.List;

public class UserService {
    private UserDao uDao = new UserDao();
    
    public User login(String studentId, String password) {
        try {
            return uDao.selectByStudentIdPassword(studentId, password);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public boolean register(User user) {
        try {
            if (uDao.isStudentIdExist(user.getStudentId())) return false;
            if (uDao.isUsernameExist(user.getUsername())) return false;
            uDao.addUser(user);
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public User selectById(int id) {
        try { return uDao.selectById(id); } 
        catch (SQLException e) { e.printStackTrace(); return null; }
    }
    
    public void updateUser(User user) {
        try { uDao.updateUser(user); } 
        catch (SQLException e) { e.printStackTrace(); }
    }
    
    public void updatePwd(int id, String newPassword) {
        try { uDao.updatePwd(id, newPassword); } 
        catch (SQLException e) { e.printStackTrace(); }
    }
    
    public Page getUserPage(int pageNumber) {
        Page p = new Page();
        p.setPageNumber(pageNumber);
        int totalCount = 0;
        try { totalCount = uDao.selectUserCount(); } 
        catch (SQLException e) { e.printStackTrace(); }
        p.SetPageSizeAndTotalCount(10, totalCount);
        List list = null;
        try { list = uDao.selectUserList(pageNumber, 10); } 
        catch (SQLException e) { e.printStackTrace(); }
        p.setList(list);
        return p;
    }
    
    public void banUser(int id, int status) {
        try { uDao.updateStatus(id, status); } 
        catch (SQLException e) { e.printStackTrace(); }
    }
}
```

编译验证：确保 UserDao.java 和 UserService.java 编译通过。
```

**✅ Phase 2.1 成功标准**：
- [ ] UserDao.java 编译通过（所有方法实现完整）
- [ ] UserService.java 编译通过

---

### 🔧 Phase 2.2 实现 UserServlet 核心方法

**可复制给AI的提示词**：

```
Phase 2.2 实现 UserServlet 核心方法

编辑文件：CookieShop/src/servlet/UserServlet.java

为 UserServlet 添加以下所有方法（继承BaseServlet，使用反射分发）：

```java
package servlet;
import model.User;
import service.UserService;
import javax.servlet.http.*;
import java.io.IOException;

public class UserServlet extends BaseServlet {
    private UserService uService = new UserService();
    
    // 未指定method时默认→登录页
    public String index(HttpServletRequest request, HttpServletResponse response) {
        return "/user_login.jsp";
    }
    
    // 学号+密码登录
    public String login(HttpServletRequest request, HttpServletResponse response) {
        String studentId = request.getParameter("student_id");
        String password = request.getParameter("password");
        User user = uService.login(studentId, password);
        if (user == null) {
            request.setAttribute("failMsg", "学号或密码错误，请重新登录！");
            return "/user_login.jsp";
        }
        if (user.getStatus() == 0) {
            request.setAttribute("failMsg", "您的账号已被封禁！");
            return "/user_login.jsp";
        }
        request.getSession().setAttribute("user", user);
        return "redirect:/index";
    }
    
    // 注册
    public String register(HttpServletRequest request, HttpServletResponse response) {
        User user = new User();
        user.setUsername(request.getParameter("username"));
        user.setStudentId(request.getParameter("student_id"));
        user.setPassword(request.getParameter("password"));
        user.setName(request.getParameter("name"));
        user.setPhone(request.getParameter("phone"));
        user.setSchool(request.getParameter("school"));
        user.setEmail(request.getParameter("email"));
        if (!request.getParameter("password").equals(request.getParameter("confirm_password"))) {
            request.setAttribute("failMsg", "两次密码不一致！");
            return "/user_register.jsp";
        }
        if (uService.register(user)) {
            request.setAttribute("msg", "注册成功，请登录！");
        } else {
            request.setAttribute("failMsg", "学号或用户名已被注册！");
        }
        return "/user_register.jsp";
    }
    
    // 退出登录
    public String logout(HttpServletRequest request, HttpServletResponse response) {
        request.getSession().invalidate();
        return "redirect:/index";
    }
    
    // 个人中心
    public String center(HttpServletRequest request, HttpServletResponse response) {
        User sessionUser = (User) request.getSession().getAttribute("user");
        if (sessionUser == null) {
            return "redirect:/user?method=login";
        }
        User user = uService.selectById(sessionUser.getId());
        request.setAttribute("user", user);
        return "/user_center.jsp";
    }
    
    // 修改个人信息
    public String changeAddress(HttpServletRequest request, HttpServletResponse response) {
        User sessionUser = (User) request.getSession().getAttribute("user");
        if (sessionUser == null) {
            return "redirect:/user?method=login";
        }
        User user = uService.selectById(sessionUser.getId());
        user.setName(request.getParameter("name"));
        user.setPhone(request.getParameter("phone"));
        user.setAddress(request.getParameter("address"));
        user.setSchool(request.getParameter("school"));
        user.setQq(request.getParameter("qq"));
        uService.updateUser(user);
        request.getSession().setAttribute("user", user);
        request.setAttribute("msg", "信息修改成功！");
        return "/user_center.jsp";
    }
    
    // 修改密码
    public String changePwd(HttpServletRequest request, HttpServletResponse response) {
        User sessionUser = (User) request.getSession().getAttribute("user");
        if (sessionUser == null) {
            return "redirect:/user?method=login";
        }
        String oldPwd = request.getParameter("password");
        String newPwd = request.getParameter("newPassword");
        if (!sessionUser.getPassword().equals(oldPwd)) {
            request.setAttribute("failMsg", "原密码错误！");
            return "/user_center.jsp";
        }
        uService.updatePwd(sessionUser.getId(), newPwd);
        sessionUser.setPassword(newPwd);
        request.getSession().setAttribute("user", sessionUser);
        request.setAttribute("msg", "密码修改成功！");
        return "/user_center.jsp";
    }
}
```

编译验证。注意：UserServlet不再使用@WebServlet注解（由web.xml管理映射）。
```

**✅ Phase 2.2 成功标准**：
- [ ] UserServlet 编译通过
- [ ] login/register/logout/center/changeAddress/changePwd 方法完整

---

### 🔧 Phase 2.3 重写登录/注册/个人中心页面

**可复制给AI的提示词**：

```
Phase 2.3 重写登录/注册/个人中心页面（Tailwind风格）

### 1. 重写 user_login.jsp
路径：CookieShop/web/user_login.jsp

Tailwind卡片式登录表单：
- 灰色背景页（bg-gray-100 min-h-screen）
- 中央白色卡片（max-w-md mx-auto bg-white rounded-xl shadow-lg p-8）
- 标题"登录 TradeHub"
- 输入框：学号（type="text", name="student_id"）
- 输入框：密码（type="password", name="password"）
- 蓝色提交按钮
- 底部链接"没有账号？立即注册"→ /user?method=register
- 错误提示：<c:if test="${not empty failMsg}">红色提示div</c:if>
- 成功提示：<c:if test="${not empty msg}">绿色提示div</c:if>
- 引入 header.jsp 和 footer.jsp
- 表单 action="/user?method=login" method="post"

### 2. 重写 user_register.jsp
路径：CookieShop/web/user_register.jsp

注册表单字段：
- 学号（student_id, text, required）
- 用户名（username, text）
- 邮箱（email, email）
- 密码（password, password）
- 确认密码（confirm_password, password）
- 姓名（name, text）
- 手机号（phone, text）
- 学校（school, text）
- 提交按钮和返回登录链接

### 3. 重写 user_center.jsp
路径：CookieShop/web/user_center.jsp

个人中心布局：
- 顶部：用户信息卡片（姓名、学校、学号）
- Tab导航：[个人信息] [修改密码] [我发布的] [我收藏的] [我的订单]
- 个人信息表单：姓名、手机、地址、学校、QQ
- 修改密码表单：原密码、新密码
- 导航链接：
  - 我发布的 → /user?method=myProducts (Phase 3)
  - 我收藏的 → /user?method=myFavorites (Phase 3)
  - 我的订单 → /order?method=myOrders (Phase 4)

确保所有页面引入Tailwind CDN（通过header.jsp）。
```

**✅ Phase 2.3 成功标准**：
- [ ] user_login.jsp 使用学号+密码登录表单
- [ ] user_register.jsp 包含学号/学校等新字段
- [ ] user_center.jsp 包含所有Tab导航和表单
- [ ] 所有页面Tailwind样式正常

---

### 🔧 Phase 2.4 实现商品发布功能

```
Phase 2.4 实现商品发布功能

### 步骤1：创建 ProductDao.java
路径：CookieShop/src/dao/ProductDao.java

需要方法：
- insert(Product p) — INSERT INTO product(name,price,price_original,description,image,condition_level,user_id,category_id) VALUES(?,?,?,?,?,?,?,?)
- update(Product p) — UPDATE product SET name=?,price=?,price_original=?,description=?,image=?,condition_level=?,category_id=? WHERE id=?
- delete(int id) — DELETE FROM product WHERE id=?
- getById(int id) — SELECT p.*,u.name user_name,c.name category_name FROM product p LEFT JOIN user u ON p.user_id=u.id LEFT JOIN category c ON p.category_id=c.id WHERE p.id=?
- getLatestList(int pageNo, int pageSize) — SELECT ... ORDER BY created_time DESC LIMIT ?,?
- getHotList(int limit) — SELECT ... ORDER BY views DESC LIMIT ?
- getByCategory(int categoryId, int pageNo, int pageSize, String sort) — 带分类筛选
- getCountByCategory(int categoryId) — SELECT COUNT(*) FROM product WHERE category_id=? AND status=0
- incrementViews(int id) — UPDATE product SET views=views+1 WHERE id=?
- search(keyword, categoryId, priceMin, priceMax, sort, pageNo, pageSize) — 动态拼接SQL
- getSearchCount(keyword, categoryId, priceMin, priceMax) — 搜索总数
- updateStatus(int id, int status) — UPDATE product SET status=? WHERE id=?

所有查询都需要 LEFT JOIN user 获取 user_name，LEFT JOIN category 获取 category_name。
使用 BeanListHandler(Product.class) 映射结果（确保Product类有setUserName/setCategoryName方法）。

### 步骤2：创建 ProductService.java
路径：CookieShop/src/service/ProductService.java

包装 ProductDao 所有方法，处理异常。

### 步骤3：创建 CategoryDao.java 和 CategoryService.java
路径：CookieShop/src/dao/CategoryDao.java + CookieShop/src/service/CategoryService.java

CategoryDao：
- getAllCategories() → List<Category>
- add(Category) / update(Category) / delete(int id)
- getById(int id)

CategoryService：包装CategoryDao方法。

### 步骤4：修改 ApplicationListener
路径：CookieShop/src/listener/ApplicationListener.java

contextInitialized中加载：
```java
sce.getServletContext().setAttribute("categoryList", new CategoryService().getAllCategories());
```

### 步骤5：实现 ProductServlet.publish() 方法
在 ProductServlet.java 中添加：

```java
public String publish(HttpServletRequest request, HttpServletResponse response) throws Exception {
    User user = (User) request.getSession().getAttribute("user");
    if (user == null) {
        return "redirect:/user?method=login";
    }
    
    if ("GET".equalsIgnoreCase(request.getMethod())) {
        return "/product_publish.jsp";
    }
    
    // POST处理：使用FileUpload解析
    DiskFileItemFactory factory = new DiskFileItemFactory();
    ServletFileUpload upload = new ServletFileUpload(factory);
    List<FileItem> items = upload.parseRequest(request);
    
    Product product = new Product();
    for (FileItem item : items) {
        if (item.isFormField()) {
            String fieldName = item.getFieldName();
            String value = item.getString("utf-8");
            switch (fieldName) {
                case "name": product.setName(value); break;
                case "price": product.setPrice(Float.parseFloat(value)); break;
                case "price_original": 
                    if (!value.isEmpty()) product.setPriceOriginal(Float.parseFloat(value)); 
                    break;
                case "description": product.setDescription(value); break;
                case "condition_level": product.setConditionLevel(Integer.parseInt(value)); break;
                case "category_id": product.setCategoryId(Integer.parseInt(value)); break;
            }
        } else {
            // 图片文件
            String fileName = item.getName();
            if (fileName != null && !fileName.isEmpty()) {
                String uploadPath = request.getServletContext().getRealPath("/picture/");
                String uuidName = UUID.randomUUID() + fileName.substring(fileName.lastIndexOf("."));
                item.write(new File(uploadPath + uuidName));
                product.setImage("picture/" + uuidName);
            }
        }
    }
    product.setUserId(user.getId());
    pService.insert(product);
    return "redirect:/product?method=list";
}
```

记得导入 commons-fileupload 相关类。

### 步骤6：创建 product_publish.jsp
路径：CookieShop/web/product_publish.jsp

Tailwind发布表单：
- 标题"发布商品"
- 分类下拉（select，从categoryList遍历）
- 商品名称输入框
- 售价输入框（必填）
- 原价输入框（可选）
- 成色下拉（1全新/2几乎全新/3有使用痕迹/4老旧）
- 商品描述textarea
- 图片上传（input type="file" name="image"）
- 提交按钮
- enctype="multipart/form-data"
```

**✅ Phase 2.4 成功标准**：
- [ ] ProductDao.java 编译通过（完整SQL方法）
- [ ] ProductService.java 编译通过
- [ ] CategoryDao.java + CategoryService.java 编译通过
- [ ] ApplicationListener 加载 categoryList
- [ ] ProductServlet.publish() 可处理图片上传
- [ ] product_publish.jsp 表单可正常提交
- [ ] 发布成功后 product 表有新记录

---

### 🎯 Phase 2 完成验证清单

```
Phase 2 全部完成验证：
- [ ] 学号+密码可成功登录
- [ ] 新用户注册成功，学号唯一性校验生效
- [ ] 登录后session存储user对象（含新字段）
- [ ] 个人中心可修改信息，密码可修改
- [ ] 发布商品表单提交成功，图片上传到picture目录
- [ ] 新商品出现在product表中
- [ ] 分类列表通过ApplicationListener全局加载
```

**⚠️ 以上全部通过后，才能进入 Phase 3。**

---

## Phase 3: 商品展示、搜索与收藏

### 📋 阶段目标
实现首页瀑布流、商品列表/搜索、商品详情、收藏功能。

---

### 🔧 Phase 3.1 实现 IndexServlet 和首页

**可复制给AI的提示词**：

```
Phase 3.1 实现 IndexServlet 和首页布局

### 步骤1：完善 IndexServlet
路径：CookieShop/src/servlet/IndexServlet.java

```java
package servlet;
import service.ProductService;
import javax.servlet.http.*;
import java.util.List;

public class IndexServlet extends BaseServlet {
    private ProductService pService = new ProductService();
    
    public String index(HttpServletRequest request, HttpServletResponse response) {
        request.setAttribute("latestList", pService.getLatestList(1, 12));
        request.setAttribute("hotList", pService.getHotList(10));
        return "/index.jsp";
    }
}
```

### 步骤2：重写 index.jsp（首页完整Tailwind布局）

布局结构：
1. 顶部搜索区：大搜索框 + 分类下拉 + 搜索按钮
2. 分类导航标签：【全部】【书籍教材】【数码产品】...
3. 主体：左侧"最新发布"商品网格(3列)，右侧"热门推荐"列表
4. 每个商品卡片：图片 + 名称 + 价格 + 浏览量

商品卡片组件示例（Tailwind）：
```html
<div class="bg-white rounded-lg shadow-md overflow-hidden hover:shadow-xl transition">
  <a href="/product?method=detail&id=${p.id}">
    <img src="${p.image}" class="w-full h-48 object-cover">
  </a>
  <div class="p-4">
    <a href="/product?method=detail&id=${p.id}" class="text-lg font-semibold hover:text-blue-600">
      ${p.name}
    </a>
    <div class="flex justify-between items-center mt-2">
      <span class="text-xl font-bold text-red-500">¥${p.price}</span>
      <span class="text-sm text-gray-500">${p.views}次浏览</span>
    </div>
  </div>
</div>
```

热门推荐用右侧卡片列表展示（竖向排列，TOP10）。

确保 header.jsp 中的搜索表单 action="/product?method=search"，提交时带关键词和分类参数。
```

**✅ Phase 3.1 成功标准**：
- [ ] 首页显示最新12件商品
- [ ] 首页显示热门推荐Top10
- [ ] 搜索框+分类下拉可正常跳转到搜索页
- [ ] 分类导航标签点击可筛选
- [ ] 商品卡片Tailwind样式完整

---

### 🔧 Phase 3.2 实现商品列表/详情/搜索

**可复制给AI的提示词**：

```
Phase 3.2 实现商品列表/详情/搜索

### 步骤1：完善 ProductServlet
在 ProductServlet.java 中添加完整方法：

```java
ProductService pService = new ProductService();

// 商品列表（分页+分类筛选+排序）
public String list(HttpServletRequest request, HttpServletResponse response) {
    int categoryId = 0;
    int pageNumber = 1;
    String sort = request.getParameter("sort");
    if (request.getParameter("categoryId") != null)
        categoryId = Integer.parseInt(request.getParameter("categoryId"));
    if (request.getParameter("pageNumber") != null)
        pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
    if (sort == null) sort = "newest";
    
    Page p = pService.getProductPage(categoryId, pageNumber, sort);
    request.setAttribute("p", p);
    request.setAttribute("categoryId", categoryId);
    request.setAttribute("sort", sort);
    return "/product_list.jsp";
}

// 商品详情（浏览量+1）
public String detail(HttpServletRequest request, HttpServletResponse response) {
    int id = Integer.parseInt(request.getParameter("id"));
    pService.incrementViews(id);
    Product product = pService.getById(id);
    request.setAttribute("product", product);
    return "/product_detail.jsp";
}

// 搜索
public String search(HttpServletRequest request, HttpServletResponse response) {
    String keyword = request.getParameter("keyword");
    int categoryId = 0;
    float priceMin = 0;
    float priceMax = Float.MAX_VALUE;
    int pageNumber = 1;
    String sort = request.getParameter("sort");
    // 解析参数...
    Page p = pService.search(keyword, categoryId, priceMin, priceMax, sort, pageNumber);
    request.setAttribute("p", p);
    request.setAttribute("keyword", keyword);
    return "/product_search.jsp";
}

// 编辑商品（仅本人）
public String edit(HttpServletRequest request, HttpServletResponse response) {
    // GET: 显示编辑页 → /product_edit.jsp
    // POST: 更新商品信息 → redirect:product?method=detail&id=xxx
}

// 删除商品（仅本人）
public String delete(HttpServletRequest request, HttpServletResponse response) {
    int id = Integer.parseInt(request.getParameter("id"));
    User user = (User) request.getSession().getAttribute("user");
    Product product = pService.getById(id);
    if (product != null && product.getUserId() == user.getId()) {
        pService.delete(id);
    }
    return "redirect:/user?method=myProducts";
}
```

需要在 ProductService 中实现：
- getProductPage(categoryId, pageNumber, sort) → Page
- search(keyword, categoryId, priceMin, priceMax, sort, pageNumber) → Page

### 步骤2：创建 product_list.jsp
Tailwind网格布局，支持排序切换（最新/最热/价格升序/价格降序）。

### 步骤3：创建 product_detail.jsp
Tailwind商品详情页：
- 大图展示
- 商品名称、价格（原价划线）
- 成色标签
- 分类+发布时间
- 卖家信息（姓名、学校、QQ）
- 浏览量
- 商品描述
- [立即购买]按钮 + [收藏]按钮

### 步骤4：创建 product_search.jsp
搜索结果页，支持过滤条件展示。

### 步骤5：创建 product_edit.jsp
编辑商品表单（复用发布表单逻辑）。
```

**✅ Phase 3.2 成功标准**：
- [ ] 商品列表分页+分类筛选+排序正常
- [ ] 商品详情页显示完整信息（价格/成色/卖家/浏览量）
- [ ] 搜索功能：关键词+分类+价格区间可正常筛选
- [ ] 浏览量每次查看+1
- [ ] 编辑/删除仅本人可操作

---

### 🔧 Phase 3.3 实现收藏功能

**可复制给AI的提示词**：

```
Phase 3.3 实现收藏功能

### 步骤1：创建 FavoriteDao.java
路径：CookieShop/src/dao/FavoriteDao.java

方法：
- add(int userId, int productId) → INSERT IGNORE INTO favorite(user_id,product_id) VALUES(?,?)
- remove(int userId, int productId) → DELETE FROM favorite WHERE user_id=? AND product_id=?
- isFavorited(int userId, int productId) → SELECT COUNT(*) FROM favorite WHERE user_id=? AND product_id=? → >0
- getFavoritesByUser(int userId, int pageNumber, int pageSize) → LEFT JOIN product 获取商品信息
- getFavoriteCount(int userId) → int

### 步骤2：创建 FavoriteService.java
包装 FavoriteDao。

### 步骤3：实现 FavoriteServlet
方法：
- add(): POST，返回 json:{"ok":true} 或 json:{"ok":false}
- remove(): POST，同上
- list(): GET，展示收藏列表 → /user_favorites.jsp

### 步骤4：创建 user_favorites.jsp
展示收藏商品列表（与商品列表类似，每项可取消收藏）。

### 步骤5：在 product_detail.jsp 添加收藏按钮
Ajax收藏切换：
```javascript
let isFav = ${isFavorited ? 'true' : 'false'};
function toggleFavorite() {
    const method = isFav ? 'remove' : 'add';
    fetch('/favorite?method=' + method + '&productId=${product.id}', {method:'POST'})
        .then(r => r.text())
        .then(data => {
            if(data.includes('ok')) {
                isFav = !isFav;
                document.getElementById('favBtn').textContent = isFav ? '★ 已收藏' : '☆ 收藏';
            }
        });
}
```
```

**✅ Phase 3.3 成功标准**：
- [ ] 收藏/取消收藏Ajax响应正常
- [ ] 收藏按钮状态随操作切换
- [ ] 收藏列表可查看已收藏商品
- [ ] 刷新页面后收藏状态保持

---

### 🎯 Phase 3 完成验证清单

```
Phase 3 全部完成验证：
- [ ] 首页展示最新+热门推荐
- [ ] 商品列表分页、分类筛选、排序功能完整
- [ ] 搜索功能完整（关键词+分类+价格+排序）
- [ ] 商品详情页信息完整、浏览量递增
- [ ] 收藏功能完整（添加/取消/列表）
- [ ] 编辑/删除仅发布者本人可操作
```

**⚠️ 以上全部通过后，才能进入 Phase 4。**

---

## Phase 4: 交易流程与订单管理

(提示词继续…篇幅限制，Phase 4和Phase 5的核心结构与Phase 1-3一致)

### 🔧 Phase 4.1-4.4 订单流程完整实现

**可复制给AI的提示词**（摘要版，完整执行时展开）：

```
Phase 4 订单交易流程

### OrderDao.java 重写
路径：CookieShop/src/dao/OrderDao.java

完整SQL重写，适配新order表结构：
- insertOrder(Connection con, Order order)
- getLastInsertId(Connection con)
- insertOrderItem(Connection con, OrderItem item)
- selectByBuyer(int buyerId, int pageNo, int pageSize) → 买家订单
- selectBySeller(int sellerId, int pageNo, int pageSize) → 卖家订单
- selectById(int id)
- selectOrderItems(int orderId)
- updateStatus(int id, int status)
- getOrderCountByBuyer(int buyerId, int status)
- getOrderCountBySeller(int sellerId, int status)
- deleteOrder(Connection con, int id)
- deleteOrderItem(Connection con, int orderId)

### OrderService.java 重写
关键改动：
- addOrder内更新product.status=1（已售）
- cancelOrder内恢复product.status=0（在售）+ order.status=2
- getBuyerOrders(pageNumber, status, userId)
- getSellerOrders(pageNumber, status, userId)

### OrderServlet.java 完整实现
- submit(): GET→下单页(带productId参数，展示商品+卖家信息)，需登录
- confirm(): POST→创建订单+更新商品状态→redirect订单列表
- myOrders(): GET→双Tab订单列表("我买到的"/"我卖出的")
- confirmDeal(): POST→卖家确认交易(status 0→1)
- cancel(): POST→卖家取消订单(status 0→2)+恢复商品

### order_submit.jsp 重构
展示商品信息卡片(来自product参数)+卖家信息+表单(联系人/电话/地点/留言)

### order_list.jsp 重构
双Tab布局：
- Tab1"我买到的"→展示buyerOrders列表
- Tab2"我卖出的"→展示sellerOrders列表+操作按钮(确认交易/取消订单)
```

**✅ Phase 4 成功标准**：
- [ ] 点击"立即购买"→填写信息→创建订单(status=0)成功
- [ ] 下单后商品状态变为"已售"(status=1)
- [ ] 订单列表正确区分"买到的"和"卖出的"
- [ ] 卖家可"确认交易"(status→1)和"取消订单"(status→2)
- [ ] 取消订单后商品恢复"在售"状态

---

## Phase 5: 后台管理与整体美化

### 🔧 Phase 5.1 精简后台

**可复制给AI的提示词**：

```
Phase 5.1 AdminServlet 精简后台

AdminServlet方法：
- index(): 后台首页
- userList(): 用户管理列表
- banUser(): 封禁/解封(JSON响应)
- productList(): 商品管理列表
- offShelf(): 商品下架(JSON响应)
- categoryList(): 分类管理
- categoryAdd/edit/delete(): 分类CRUD

后台页面(Tailwind重写)：
- admin/index.jsp: 后台首页 + 统计卡片
- admin/header.jsp: 后台导航栏
- admin/user_list.jsp: 用户列表+封禁按钮
- admin/product_list.jsp: 商品列表+下架按钮
- admin/category_list.jsp: 分类CRUD
```

**✅ Phase 5.1 成功标准**：
- [ ] 管理员可查看用户列表并封禁/解封
- [ ] 管理员可下架违规商品
- [ ] 管理员可增删改分类

---

### 🔧 Phase 5.2 SweetAlert/Toastr引入

**可复制给AI的提示词**：

```
Phase 5.2 引入 SweetAlert2 和 Toastr

在 header.jsp 中添加CDN引用：
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

配置toastr：
toastr.options = { positionClass: 'toast-top-center', timeOut: 2000 };

替换所有alert()为toastr.success/error/warning/info()
替换所有confirm()为Swal.fire({title, icon, showCancelButton, confirmButtonText})
替换layer弹窗为SweetAlert
```

---

### 🔧 Phase 5.3 移动端响应式

**可复制给AI的提示词**：

```
Phase 5.3 确保移动端响应式

检查并修复所有页面的Tailwind响应式类：
- 商品网格：grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4
- 导航栏：移动端显示汉堡菜单(通过JS toggle)
- 表单：移动端全宽布局
- 图片：w-full h-auto

在 header.jsp 添加移动端汉堡菜单逻辑。
```

---

### 🔧 Phase 5.4 全站走查与Bug修复

**可复制给AI的提示词**：

```
Phase 5.4 全站走查

检查以下内容：
1. 所有 JSTL <c:forEach> 变量名正确（latestList/hotList/product/p/categoryList）
2. 所有BaseServlet方法返回路径正确（/xxx.jsp vs redirect:/xxx）
3. AdminFilter拦截路径正常，非管理员无法访问/admin
4. Session中user对象字段新名字（studentId替代username登录）
5. 所有商品图片路径正确（picture/xxx.jpg）
6. 搜索框action指向/product?method=search
7. 分页链接参数格式正确
8. 无编译错误
9. 全站无404

启动Tomcat→访问首页→注册/登录→发布商品→搜索→收藏→下单→卖家操作→管理员操作
逐功能验证。
```

---

## 附录A：各阶段总结模板

每完成一个阶段，输出如下格式：

```
## ✅ Phase N 完成报告

### 完成的功能
- [x] 功能A - 验证通过
- [x] 功能B - 验证通过

### 修改文件清单
| 文件 | 操作 | 行数变化 |
|------|:---:|---------|
| xxx.java | 新增 | +45 |
| xxx.jsp | 重写 | +120 |

### 成功标准验证
- [x] 标准1 - ✅ 通过
- [x] 标准2 - ✅ 通过
- [x] 标准3 - ✅ 通过

### 已知问题
- 无

### 下一阶段准备
所有依赖已就绪，可以进入 Phase N+1。
```

---

## 附录B：快速排查清单

遇到问题时检查：

```
□ MySQL服务是否启动？
□ tradehub数据库是否存在？
□ c3p0-config.xml中jdbcUrl是否正确？
□ Tomcat控制台是否有异常？
□ web.xml中Servlet映射是否正确？
□ BaseServlet方法名是否匹配URL中的method参数？
□ JSP文件中JSTL变量名是否匹配Servlet设置的attribute名？
□ model类是否有对应的setter方法（如setUserName）？
□ 图片目录 web/picture/ 是否存在且有写入权限？
```

---

**文档结束**

> 共5个阶段、约80+条可执行任务，遵循Vibe Coding敏捷开发模式。
> 每条提示词均设计为可直接复制给AI编程助手执行。