<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="header.jsp"/>

<div class="min-h-screen bg-gray-100 py-8">
  <div class="max-w-7xl mx-auto px-4">
    <div class="bg-white rounded-2xl shadow-lg p-6 mb-6">
      <form action="${pageContext.request.contextPath}/product" method="get" class="space-y-4">
        <input type="hidden" name="method" value="search">
        <div class="flex flex-col md:flex-row gap-3">
          <input type="text" name="keyword" value="${keyword}" placeholder="搜索闲置物品..."
                 class="flex-1 px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
          <select name="categoryId"
                  class="px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 bg-white">
            <option value="">全部分类</option>
            <c:forEach items="${categoryList}" var="cat">
              <option value="${cat.id}" ${categoryId == cat.id ? 'selected' : ''}>${cat.name}</option>
            </c:forEach>
          </select>
          <input type="number" name="priceMin" value="${priceMin}" placeholder="最低价"
                 class="w-28 px-3 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
          <input type="number" name="priceMax" value="${priceMax}" placeholder="最高价"
                 class="w-28 px-3 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
          <button type="submit"
                  class="bg-blue-600 text-white px-6 py-3 rounded-lg font-semibold hover:bg-blue-700 transition-colors">
            搜索
          </button>
        </div>
        <div class="flex gap-2">
          <a href="${pageContext.request.contextPath}/product?method=search&keyword=${keyword}&categoryId=${categoryId}&priceMin=${priceMin}&priceMax=${priceMax}&sort=newest"
             class="px-4 py-2 rounded-lg text-sm font-medium ${sort == 'newest' ? 'bg-blue-600 text-white' : 'bg-white border border-gray-300 text-gray-700 hover:bg-gray-50'}">
            最新
          </a>
          <a href="${pageContext.request.contextPath}/product?method=search&keyword=${keyword}&categoryId=${categoryId}&priceMin=${priceMin}&priceMax=${priceMax}&sort=hot"
             class="px-4 py-2 rounded-lg text-sm font-medium ${sort == 'hot' ? 'bg-blue-600 text-white' : 'bg-white border border-gray-300 text-gray-700 hover:bg-gray-50'}">
            最热
          </a>
          <a href="${pageContext.request.contextPath}/product?method=search&keyword=${keyword}&categoryId=${categoryId}&priceMin=${priceMin}&priceMax=${priceMax}&sort=price_asc"
             class="px-4 py-2 rounded-lg text-sm font-medium ${sort == 'price_asc' ? 'bg-blue-600 text-white' : 'bg-white border border-gray-300 text-gray-700 hover:bg-gray-50'}">
            价格↑
          </a>
          <a href="${pageContext.request.contextPath}/product?method=search&keyword=${keyword}&categoryId=${categoryId}&priceMin=${priceMin}&priceMax=${priceMax}&sort=price_desc"
             class="px-4 py-2 rounded-lg text-sm font-medium ${sort == 'price_desc' ? 'bg-blue-600 text-white' : 'bg-white border border-gray-300 text-gray-700 hover:bg-gray-50'}">
            价格↓
          </a>
        </div>
      </form>
    </div>

    <c:choose>
      <c:when test="${not empty p.list}">
        <p class="text-gray-500 mb-4">共找到 ${p.totalCount} 件商品</p>
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
              </div>
            </div>
          </c:forEach>
        </div>

        <div class="flex justify-center mt-8 space-x-2">
          <c:if test="${p.pageNumber > 1}">
            <c:set var="prevUrl" value="product?method=search&keyword=${keyword}&categoryId=${categoryId}&priceMin=${priceMin}&priceMax=${priceMax}&sort=${sort}&pageNumber=${p.pageNumber - 1}"/>
            <a href="${pageContext.request.contextPath}/${prevUrl}"
               class="px-4 py-2 rounded-lg bg-white border border-gray-300 text-gray-700 hover:bg-gray-50">上一页</a>
          </c:if>
          <c:forEach begin="1" end="${p.totalPage}" var="i">
            <c:set var="pageUrl" value="product?method=search&keyword=${keyword}&categoryId=${categoryId}&priceMin=${priceMin}&priceMax=${priceMax}&sort=${sort}&pageNumber=${i}"/>
            <a href="${pageContext.request.contextPath}/${pageUrl}"
               class="px-4 py-2 rounded-lg ${i == p.pageNumber ? 'bg-blue-600 text-white' : 'bg-white border border-gray-300 text-gray-700 hover:bg-gray-50'}">${i}</a>
          </c:forEach>
          <c:if test="${p.pageNumber < p.totalPage}">
            <c:set var="nextUrl" value="product?method=search&keyword=${keyword}&categoryId=${categoryId}&priceMin=${priceMin}&priceMax=${priceMax}&sort=${sort}&pageNumber=${p.pageNumber + 1}"/>
            <a href="${pageContext.request.contextPath}/${nextUrl}"
               class="px-4 py-2 rounded-lg bg-white border border-gray-300 text-gray-700 hover:bg-gray-50">下一页</a>
          </c:if>
        </div>
      </c:when>
      <c:otherwise>
        <div class="text-center py-16 bg-white rounded-2xl shadow-md">
          <p class="text-6xl mb-4">🔍</p>
          <p class="text-xl text-gray-500">没有找到相关商品</p>
        </div>
      </c:otherwise>
    </c:choose>
  </div>
</div>

<jsp:include page="footer.jsp"/>