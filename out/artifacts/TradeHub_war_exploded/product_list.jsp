<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="header.jsp"/>

<div class="min-h-screen bg-gray-100 py-8">
  <div class="max-w-7xl mx-auto px-4">
    <div class="flex flex-col md:flex-row md:items-center md:justify-between mb-6 gap-4">
      <div>
        <h1 class="text-3xl font-bold text-gray-800">
          <c:choose>
            <c:when test="${categoryId > 0}">
              <c:forEach items="${categoryList}" var="cat">
                <c:if test="${cat.id == categoryId}">${cat.name}</c:if>
              </c:forEach>
            </c:when>
            <c:otherwise>全部商品</c:otherwise>
          </c:choose>
        </h1>
      </div>
      <div class="flex gap-2">
        <a href="${pageContext.request.contextPath}/product?method=list&categoryId=${categoryId}&sort=newest"
           class="px-4 py-2 rounded-lg text-sm font-medium ${sort == 'newest' ? 'bg-blue-600 text-white' : 'bg-white border border-gray-300 text-gray-700 hover:bg-gray-50'}">
          最新
        </a>
        <a href="${pageContext.request.contextPath}/product?method=list&categoryId=${categoryId}&sort=hot"
           class="px-4 py-2 rounded-lg text-sm font-medium ${sort == 'hot' ? 'bg-blue-600 text-white' : 'bg-white border border-gray-300 text-gray-700 hover:bg-gray-50'}">
          最热
        </a>
        <a href="${pageContext.request.contextPath}/product?method=list&categoryId=${categoryId}&sort=price_asc"
           class="px-4 py-2 rounded-lg text-sm font-medium ${sort == 'price_asc' ? 'bg-blue-600 text-white' : 'bg-white border border-gray-300 text-gray-700 hover:bg-gray-50'}">
          价格↑
        </a>
        <a href="${pageContext.request.contextPath}/product?method=list&categoryId=${categoryId}&sort=price_desc"
           class="px-4 py-2 rounded-lg text-sm font-medium ${sort == 'price_desc' ? 'bg-blue-600 text-white' : 'bg-white border border-gray-300 text-gray-700 hover:bg-gray-50'}">
          价格↓
        </a>
      </div>
    </div>

    <form action="${pageContext.request.contextPath}/product" method="get" class="mb-4">
      <input type="hidden" name="method" value="search">
      <div class="relative max-w-xl">
        <input type="text" name="keyword" value="${param.keyword}" placeholder="搜索商品..." 
               class="w-full pl-10 pr-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent bg-white">
        <svg class="absolute left-3 top-3.5 w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
        </svg>
      </div>
    </form>

    <div class="flex flex-wrap gap-2 mb-6">
      <a href="${pageContext.request.contextPath}/product?method=list"
         class="px-4 py-2 rounded-full text-sm font-medium ${categoryId == 0 ? 'bg-blue-600 text-white' : 'bg-white border border-gray-300 text-gray-700 hover:bg-blue-50'}">
        全部
      </a>
      <c:forEach items="${categoryList}" var="cat">
        <a href="${pageContext.request.contextPath}/product?method=list&categoryId=${cat.id}"
           class="px-4 py-2 rounded-full text-sm font-medium ${categoryId == cat.id ? 'bg-blue-600 text-white' : 'bg-white border border-gray-300 text-gray-700 hover:bg-blue-50'}">
          ${cat.name}
        </a>
      </c:forEach>
    </div>

    <c:choose>
      <c:when test="${not empty p.list}">
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
          <c:forEach items="${p.list}" var="product">
            <div class="bg-white rounded-xl shadow-md overflow-hidden hover:shadow-xl transition-shadow duration-300">
              <a href="${pageContext.request.contextPath}/product?method=detail&id=${product.id}">
                <c:choose>
                  <c:when test="${not empty product.image}">
                    <img src="${pageContext.request.contextPath}/${product.image}" alt="${product.name}" class="w-full h-48 object-cover">
                  </c:when>
                  <c:otherwise>
                    <div class="w-full h-48 bg-gray-200 flex items-center justify-center text-gray-400">暂无图片</div>
                  </c:otherwise>
                </c:choose>
              </a>
              <div class="p-4">
                <a href="${pageContext.request.contextPath}/product?method=detail&id=${product.id}" class="text-lg font-semibold text-gray-800 hover:text-blue-600 line-clamp-2">
                  ${product.name}
                </a>
                <div class="flex items-center mt-1 text-sm text-gray-500">
                  <span class="bg-blue-100 text-blue-700 px-2 py-0.5 rounded text-xs mr-2">${product.conditionText}</span>
                  <span>${product.categoryName}</span>
                </div>
                <div class="flex justify-between items-center mt-3">
                  <span class="text-xl font-bold text-red-500">¥${product.price}</span>
                  <span class="text-xs text-gray-400">${product.views}次浏览</span>
                </div>
                <div class="text-xs text-gray-400 mt-1">${product.userName}</div>
              </div>
            </div>
          </c:forEach>
        </div>

        <div class="flex justify-center mt-8 space-x-2">
          <c:if test="${p.pageNumber > 1}">
            <a href="${pageContext.request.contextPath}/product?method=list&categoryId=${categoryId}&sort=${sort}&pageNumber=${p.pageNumber - 1}"
               class="px-4 py-2 rounded-lg bg-white border border-gray-300 text-gray-700 hover:bg-gray-50">上一页</a>
          </c:if>
          <c:forEach begin="1" end="${p.totalPage}" var="i">
            <a href="${pageContext.request.contextPath}/product?method=list&categoryId=${categoryId}&sort=${sort}&pageNumber=${i}"
               class="px-4 py-2 rounded-lg ${i == p.pageNumber ? 'bg-blue-600 text-white' : 'bg-white border border-gray-300 text-gray-700 hover:bg-gray-50'}">${i}</a>
          </c:forEach>
          <c:if test="${p.pageNumber < p.totalPage}">
            <a href="${pageContext.request.contextPath}/product?method=list&categoryId=${categoryId}&sort=${sort}&pageNumber=${p.pageNumber + 1}"
               class="px-4 py-2 rounded-lg bg-white border border-gray-300 text-gray-700 hover:bg-gray-50">下一页</a>
          </c:if>
        </div>
      </c:when>
      <c:otherwise>
        <div class="text-center py-16 bg-white rounded-2xl shadow-md">
          <p class="text-6xl mb-4">📦</p>
          <p class="text-xl text-gray-500">该分类暂无商品</p>
        </div>
      </c:otherwise>
    </c:choose>
  </div>
</div>

<jsp:include page="footer.jsp"/>