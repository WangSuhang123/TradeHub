<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="header.jsp"/>

<div class="p-8">
  <div class="flex items-center justify-between mb-6">
    <h1 class="text-2xl font-bold text-gray-800">轮播图管理</h1>
    <a href="${pageContext.request.contextPath}/carousel?method=add"
       class="bg-blue-600 text-white px-5 py-2.5 rounded-lg font-medium hover:bg-blue-700 transition">
      + 添加轮播图
    </a>
  </div>

  <c:choose>
    <c:when test="${not empty carouselList}">
      <div class="bg-white rounded-xl shadow-md overflow-hidden">
        <table class="w-full">
          <thead class="bg-gray-50 border-b">
            <tr>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">ID</th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">图片</th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">标题</th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">链接</th>
              <th class="px-6 py-3 text-center text-xs font-medium text-gray-500 uppercase">排序</th>
              <th class="px-6 py-3 text-center text-xs font-medium text-gray-500 uppercase">状态</th>
              <th class="px-6 py-3 text-center text-xs font-medium text-gray-500 uppercase">操作</th>
            </tr>
          </thead>
          <tbody class="divide-y divide-gray-100">
            <c:forEach items="${carouselList}" var="item">
              <tr class="hover:bg-gray-50">
                <td class="px-6 py-4 text-sm text-gray-500">${item.id}</td>
                <td class="px-6 py-4">
                  <c:choose>
                    <c:when test="${not empty item.image}">
                      <img src="${pageContext.request.contextPath}/${item.image}" alt="${item.title}" class="w-32 h-16 object-cover rounded-lg border">
                    </c:when>
                    <c:otherwise>
                      <div class="w-32 h-16 bg-gray-100 rounded-lg flex items-center justify-center text-gray-400 text-xs">无图片</div>
                    </c:otherwise>
                  </c:choose>
                </td>
                <td class="px-6 py-4 text-sm font-medium text-gray-800">${item.title}</td>
                <td class="px-6 py-4 text-sm text-gray-500 max-w-[200px] truncate">${item.link}</td>
                <td class="px-6 py-4 text-center">
                  <div class="flex items-center justify-center gap-1">
                    <a href="${pageContext.request.contextPath}/carousel?method=moveUp&id=${item.id}"
                       class="w-7 h-7 rounded bg-gray-100 hover:bg-gray-200 flex items-center justify-center text-gray-600 transition" title="上移">▲</a>
                    <span class="text-sm font-medium text-gray-700 w-8 text-center">${item.sortOrder}</span>
                    <a href="${pageContext.request.contextPath}/carousel?method=moveDown&id=${item.id}"
                       class="w-7 h-7 rounded bg-gray-100 hover:bg-gray-200 flex items-center justify-center text-gray-600 transition" title="下移">▼</a>
                  </div>
                </td>
                <td class="px-6 py-4 text-center">
                  <a href="${pageContext.request.contextPath}/carousel?method=toggleStatus&id=${item.id}"
                     class="inline-block px-3 py-1 rounded-full text-xs font-medium ${item.status == 1 ? 'bg-green-100 text-green-700' : 'bg-gray-100 text-gray-500'}">
                    ${item.statusText}
                  </a>
                </td>
                <td class="px-6 py-4 text-center">
                  <div class="flex items-center justify-center gap-2">
                    <a href="${pageContext.request.contextPath}/carousel?method=edit&id=${item.id}"
                       class="text-blue-600 hover:text-blue-800 text-sm font-medium">编辑</a>
                    <a href="${pageContext.request.contextPath}/carousel?method=delete&id=${item.id}"
                       onclick="return confirm('确定要删除该轮播图吗？')"
                       class="text-red-600 hover:text-red-800 text-sm font-medium">删除</a>
                  </div>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </c:when>
    <c:otherwise>
      <div class="text-center py-16 bg-white rounded-2xl shadow-md">
        <p class="text-6xl mb-4">🖼</p>
        <p class="text-lg text-gray-500 mb-4">暂无轮播图</p>
        <a href="${pageContext.request.contextPath}/carousel?method=add"
           class="inline-block bg-blue-600 text-white px-6 py-3 rounded-lg font-semibold hover:bg-blue-700 transition">
          添加第一张轮播图
        </a>
      </div>
    </c:otherwise>
  </c:choose>
</div>

</body>
</html>
