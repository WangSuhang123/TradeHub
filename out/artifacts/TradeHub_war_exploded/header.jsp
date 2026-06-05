<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script src="https://cdn.tailwindcss.com"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
  tailwind.config = {
    theme: {
      extend: {
        colors: {
          primary: '#FF5000',
          'primary-dark': '#E04400',
          'primary-light': '#FFF0E8',
          brand: '#FF5000',
          'brand-dark': '#E04400',
        }
      }
    }
  }
</script>

<nav class="bg-white border-b border-gray-200 sticky top-0 z-50 shadow-sm">
  <div class="max-w-7xl mx-auto px-4">
    <div class="flex items-center justify-between h-16">
      <div class="flex items-center gap-1">
        <a href="${pageContext.request.contextPath}/index" class="flex items-center gap-2 mr-4">
          <span class="text-2xl font-extrabold text-brand">TradeHub</span>
        </a>
      </div>

      <div class="flex-1 max-w-xl mx-8">
        <form action="${pageContext.request.contextPath}/product" method="get" class="relative">
          <input type="hidden" name="method" value="search">
          <input type="text" name="keyword" placeholder="搜索校园二手好物..."
                 class="w-full pl-10 pr-4 py-2.5 border-2 border-brand rounded-full focus:outline-none focus:ring-2 focus:ring-orange-200 text-sm bg-gray-50 focus:bg-white transition-all">
          <button type="submit" class="absolute right-1 top-1 bottom-1 bg-brand text-white px-5 rounded-full text-sm font-medium hover:bg-primary-dark transition">
            搜索
          </button>
          <svg class="absolute left-3 top-3 w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
          </svg>
        </form>
      </div>

      <div class="flex items-center gap-3">
        <c:choose>
          <c:when test="${empty user}">
            <a href="${pageContext.request.contextPath}/cart?method=list" class="text-gray-500 hover:text-brand transition relative p-2">
              <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 100 4 2 2 0 000-4z"/></svg>
            </a>
            <a href="${pageContext.request.contextPath}/user?method=login" class="text-gray-700 hover:text-brand text-sm font-medium transition">登录</a>
            <a href="${pageContext.request.contextPath}/user?method=register" class="bg-brand text-white px-5 py-2 rounded-full text-sm font-semibold hover:bg-primary-dark transition">免费注册</a>
          </c:when>
          <c:otherwise>
            <a href="${pageContext.request.contextPath}/product?method=publish"
               class="bg-brand text-white px-4 py-2 rounded-full text-sm font-semibold hover:bg-primary-dark transition flex items-center gap-1">
              <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/></svg>
              发布
            </a>
            <a href="${pageContext.request.contextPath}/cart?method=list" class="text-gray-500 hover:text-brand transition relative p-2" id="cartIcon">
              <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 100 4 2 2 0 000-4z"/></svg>
              <span id="cartBadge" class="absolute -top-0.5 -right-0.5 bg-red-500 text-white text-xs rounded-full min-w-[18px] h-[18px] flex items-center justify-center hidden font-medium"></span>
            </a>

            <div class="relative group">
              <button class="flex items-center gap-1 text-gray-700 hover:text-brand transition text-sm font-medium">
                <div class="w-7 h-7 bg-orange-100 rounded-full flex items-center justify-center text-brand font-bold text-xs">
                  ${user.name.substring(0,1)}
                </div>
                <span class="hidden md:inline">${user.name}</span>
                <svg class="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"/></svg>
              </button>
              <div class="absolute right-0 top-full mt-1 bg-white rounded-lg shadow-xl border border-gray-100 py-2 w-40 hidden group-hover:block transition-all">
                <a href="${pageContext.request.contextPath}/user?method=center" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-50 hover:text-brand">个人中心</a>
                <a href="${pageContext.request.contextPath}/order?method=myOrders" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-50 hover:text-brand">我的订单</a>
                <a href="${pageContext.request.contextPath}/user?method=myFavorites" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-50 hover:text-brand">我的收藏</a>
                <c:if test="${user.isadmin}">
                  <div class="border-t border-gray-100 my-1"></div>
                  <a href="${pageContext.request.contextPath}/admin" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-50 hover:text-brand">后台管理</a>
                </c:if>
                <div class="border-t border-gray-100 my-1"></div>
                <a href="${pageContext.request.contextPath}/user?method=logout" class="block px-4 py-2 text-sm text-gray-500 hover:bg-gray-50">退出登录</a>
              </div>
            </div>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </div>
</nav>
<div class="bg-gray-50 border-b border-gray-200">
  <div class="max-w-7xl mx-auto px-4">
    <div class="flex items-center gap-1 h-10 text-sm overflow-x-auto whitespace-nowrap">
      <a href="${pageContext.request.contextPath}/index" class="px-3 py-1 text-gray-600 hover:text-brand transition font-medium">首页</a>
      <a href="${pageContext.request.contextPath}/product?method=list" class="px-3 py-1 text-gray-600 hover:text-brand transition">全部商品</a>
      <c:forEach items="${categoryList}" var="cat" begin="0" end="5">
        <a href="${pageContext.request.contextPath}/product?method=list&categoryId=${cat.id}"
           class="px-3 py-1 text-gray-600 hover:text-brand transition">${cat.name}</a>
      </c:forEach>
    </div>
  </div>
</div>

<c:if test="${not empty user}">
<script>
fetch('${pageContext.request.contextPath}/cart?method=count')
  .then(function(r) { return r.json(); })
  .then(function(data) {
    var badge = document.getElementById('cartBadge');
    if (data.count > 0) {
      badge.textContent = data.count > 99 ? '99+' : data.count;
      badge.classList.remove('hidden');
    }
  });
</script>
</c:if>