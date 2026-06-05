<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="header.jsp"/>

<div class="min-h-screen bg-gray-100 py-8">
  <div class="max-w-7xl mx-auto px-4">
    <div class="flex items-center justify-between mb-8">
      <h1 class="text-3xl font-bold text-gray-800">我发布的商品</h1>
      <a href="${pageContext.request.contextPath}/product?method=publish"
         class="bg-blue-600 text-white px-6 py-3 rounded-lg font-semibold hover:bg-blue-700 transition-colors">
        发布新商品
      </a>
    </div>

    <div class="flex flex-wrap gap-2 mb-6">
      <a href="${pageContext.request.contextPath}/user?method=center"
         class="px-4 py-2 rounded-lg bg-white border border-gray-300 text-gray-700 text-sm font-medium hover:bg-gray-50">个人信息</a>
      <a href="${pageContext.request.contextPath}/user?method=myProducts"
         class="px-4 py-2 rounded-lg bg-blue-600 text-white text-sm font-medium">我发布的</a>
      <a href="${pageContext.request.contextPath}/user?method=myFavorites"
         class="px-4 py-2 rounded-lg bg-white border border-gray-300 text-gray-700 text-sm font-medium hover:bg-gray-50">我收藏的</a>
      <a href="${pageContext.request.contextPath}/order?method=myOrders"
         class="px-4 py-2 rounded-lg bg-white border border-gray-300 text-gray-700 text-sm font-medium hover:bg-gray-50">我的订单</a>
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
                <div class="flex items-center mt-1 text-sm">
                  <span class="px-2 py-0.5 rounded text-xs font-medium
                    <c:choose>
                      <c:when test="${product.status == 0}">bg-green-100 text-green-700</c:when>
                      <c:when test="${product.status == 1}">bg-red-100 text-red-700</c:when>
                      <c:otherwise>bg-gray-100 text-gray-700</c:otherwise>
                    </c:choose>">
                    ${product.statusText}
                  </span>
                </div>
                <div class="flex justify-between items-center mt-3">
                  <span class="text-xl font-bold text-red-500">¥${product.price}</span>
                  <span class="text-xs text-gray-400">${product.views}次浏览</span>
                </div>
                <div class="flex gap-2 mt-3">
                  <a href="${pageContext.request.contextPath}/product?method=edit&id=${product.id}"
                     class="flex-1 text-center py-2 text-sm border border-blue-500 text-blue-600 rounded-lg hover:bg-blue-50 transition-colors">
                    编辑
                  </a>
                  <a href="${pageContext.request.contextPath}/product?method=delete&id=${product.id}"
                     onclick="return confirm('确定要删除该商品吗？')"
                     class="flex-1 text-center py-2 text-sm border border-red-500 text-red-600 rounded-lg hover:bg-red-50 transition-colors">
                    删除
                  </a>
                </div>
              </div>
            </div>
          </c:forEach>
        </div>

        <div class="flex justify-center mt-8 space-x-2">
          <c:if test="${p.pageNumber > 1}">
            <a href="${pageContext.request.contextPath}/user?method=myProducts&pageNumber=${p.pageNumber - 1}"
               class="px-4 py-2 rounded-lg bg-white border border-gray-300 text-gray-700 hover:bg-gray-50">上一页</a>
          </c:if>
          <c:forEach begin="1" end="${p.totalPage}" var="i">
            <a href="${pageContext.request.contextPath}/user?method=myProducts&pageNumber=${i}"
               class="px-4 py-2 rounded-lg ${i == p.pageNumber ? 'bg-blue-600 text-white' : 'bg-white border border-gray-300 text-gray-700 hover:bg-gray-50'}">${i}</a>
          </c:forEach>
          <c:if test="${p.pageNumber < p.totalPage}">
            <a href="${pageContext.request.contextPath}/user?method=myProducts&pageNumber=${p.pageNumber + 1}"
               class="px-4 py-2 rounded-lg bg-white border border-gray-300 text-gray-700 hover:bg-gray-50">下一页</a>
          </c:if>
        </div>
      </c:when>
      <c:otherwise>
        <div class="text-center py-16 bg-white rounded-2xl shadow-md">
          <p class="text-6xl mb-4">📦</p>
          <p class="text-xl text-gray-500">还没有发布任何商品</p>
          <a href="${pageContext.request.contextPath}/product?method=publish"
             class="inline-block mt-4 bg-blue-600 text-white px-6 py-3 rounded-lg font-semibold hover:bg-blue-700 transition-colors">
            发布第一个商品
          </a>
        </div>
      </c:otherwise>
    </c:choose>
  </div>
</div>

<jsp:include page="footer.jsp"/>