<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="header.jsp"/>

<div class="p-8">
  <h1 class="text-3xl font-bold text-gray-800 mb-8">商品管理</h1>

  <div class="bg-white rounded-xl shadow-md overflow-hidden">
    <table class="w-full text-sm">
      <thead class="bg-gray-50">
        <tr>
          <th class="px-6 py-3 text-left text-gray-600 font-medium">ID</th>
          <th class="px-6 py-3 text-left text-gray-600 font-medium">商品名称</th>
          <th class="px-6 py-3 text-left text-gray-600 font-medium">价格</th>
          <th class="px-6 py-3 text-left text-gray-600 font-medium">分类</th>
          <th class="px-6 py-3 text-left text-gray-600 font-medium">发布者</th>
          <th class="px-6 py-3 text-left text-gray-600 font-medium">状态</th>
          <th class="px-6 py-3 text-left text-gray-600 font-medium">操作</th>
        </tr>
      </thead>
      <tbody class="divide-y divide-gray-100">
        <c:forEach items="${p.list}" var="product">
          <tr class="hover:bg-gray-50">
            <td class="px-6 py-4">${product.id}</td>
            <td class="px-6 py-4 max-w-xs truncate">${product.name}</td>
            <td class="px-6 py-4">¥${product.price}</td>
            <td class="px-6 py-4">${product.categoryName}</td>
            <td class="px-6 py-4">${product.userName}</td>
            <td class="px-6 py-4">
              <c:choose>
                <c:when test="${product.status == 0}">
                  <span class="px-2 py-0.5 rounded text-xs bg-green-100 text-green-700">在售</span>
                </c:when>
                <c:when test="${product.status == 1}">
                  <span class="px-2 py-0.5 rounded text-xs bg-red-100 text-red-700">已售</span>
                </c:when>
                <c:otherwise>
                  <span class="px-2 py-0.5 rounded text-xs bg-gray-100 text-gray-700">已下架</span>
                </c:otherwise>
              </c:choose>
            </td>
            <td class="px-6 py-4">
              <c:if test="${product.status != 2}">
                <a href="${pageContext.request.contextPath}/admin?method=offShelf&id=${product.id}"
                   onclick="return confirm('确定要下架该商品吗？')"
                   class="text-red-600 hover:text-red-800 text-sm">下架</a>
              </c:if>
              <c:if test="${product.status == 2}">
                <span class="text-gray-400 text-sm">已下架</span>
              </c:if>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>

  <div class="flex justify-center mt-6 space-x-2">
    <c:if test="${p.pageNumber > 1}">
      <a href="${pageContext.request.contextPath}/admin?method=productList&pageNumber=${p.pageNumber - 1}"
         class="px-4 py-2 rounded-lg bg-white border border-gray-300 text-gray-700 hover:bg-gray-50">上一页</a>
    </c:if>
    <c:forEach begin="1" end="${p.totalPage}" var="i">
      <a href="${pageContext.request.contextPath}/admin?method=productList&pageNumber=${i}"
         class="px-4 py-2 rounded-lg ${i == p.pageNumber ? 'bg-blue-600 text-white' : 'bg-white border border-gray-300 text-gray-700 hover:bg-gray-50'}">${i}</a>
    </c:forEach>
    <c:if test="${p.pageNumber < p.totalPage}">
      <a href="${pageContext.request.contextPath}/admin?method=productList&pageNumber=${p.pageNumber + 1}"
         class="px-4 py-2 rounded-lg bg-white border border-gray-300 text-gray-700 hover:bg-gray-50">下一页</a>
    </c:if>
  </div>
</div>

</body>
</html>