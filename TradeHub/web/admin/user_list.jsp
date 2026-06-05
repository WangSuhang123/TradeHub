<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="header.jsp"/>

<div class="p-8">
  <h1 class="text-3xl font-bold text-gray-800 mb-8">用户管理</h1>

  <div class="bg-white rounded-xl shadow-md overflow-hidden">
    <table class="w-full text-sm">
      <thead class="bg-gray-50">
        <tr>
          <th class="px-6 py-3 text-left text-gray-600 font-medium">ID</th>
          <th class="px-6 py-3 text-left text-gray-600 font-medium">用户名</th>
          <th class="px-6 py-3 text-left text-gray-600 font-medium">学号</th>
          <th class="px-6 py-3 text-left text-gray-600 font-medium">姓名</th>
          <th class="px-6 py-3 text-left text-gray-600 font-medium">手机号</th>
          <th class="px-6 py-3 text-left text-gray-600 font-medium">学校</th>
          <th class="px-6 py-3 text-left text-gray-600 font-medium">状态</th>
          <th class="px-6 py-3 text-left text-gray-600 font-medium">操作</th>
        </tr>
      </thead>
      <tbody class="divide-y divide-gray-100">
        <c:forEach items="${p.list}" var="user">
          <tr class="hover:bg-gray-50">
            <td class="px-6 py-4">${user.id}</td>
            <td class="px-6 py-4">${user.username}</td>
            <td class="px-6 py-4">${user.studentId}</td>
            <td class="px-6 py-4">${user.name}</td>
            <td class="px-6 py-4">${user.phone}</td>
            <td class="px-6 py-4">${user.school}</td>
            <td class="px-6 py-4">
              <c:choose>
                <c:when test="${user.status == 1}">
                  <span class="px-2 py-0.5 rounded text-xs bg-green-100 text-green-700">正常</span>
                </c:when>
                <c:otherwise>
                  <span class="px-2 py-0.5 rounded text-xs bg-red-100 text-red-700">已封禁</span>
                </c:otherwise>
              </c:choose>
            </td>
            <td class="px-6 py-4">
              <c:if test="${!user.isadmin}">
                <c:choose>
                  <c:when test="${user.status == 1}">
                    <a href="${pageContext.request.contextPath}/admin?method=banUser&id=${user.id}&status=0"
                       class="text-red-600 hover:text-red-800 text-sm">封禁</a>
                  </c:when>
                  <c:otherwise>
                    <a href="${pageContext.request.contextPath}/admin?method=banUser&id=${user.id}&status=1"
                       class="text-green-600 hover:text-green-800 text-sm">解封</a>
                  </c:otherwise>
                </c:choose>
              </c:if>
              <c:if test="${user.isadmin}">
                <span class="text-gray-400 text-sm">管理员</span>
              </c:if>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>

  <div class="flex justify-center mt-6 space-x-2">
    <c:if test="${p.pageNumber > 1}">
      <a href="${pageContext.request.contextPath}/admin?method=userList&pageNumber=${p.pageNumber - 1}"
         class="px-4 py-2 rounded-lg bg-white border border-gray-300 text-gray-700 hover:bg-gray-50">上一页</a>
    </c:if>
    <c:forEach begin="1" end="${p.totalPage}" var="i">
      <a href="${pageContext.request.contextPath}/admin?method=userList&pageNumber=${i}"
         class="px-4 py-2 rounded-lg ${i == p.pageNumber ? 'bg-blue-600 text-white' : 'bg-white border border-gray-300 text-gray-700 hover:bg-gray-50'}">${i}</a>
    </c:forEach>
    <c:if test="${p.pageNumber < p.totalPage}">
      <a href="${pageContext.request.contextPath}/admin?method=userList&pageNumber=${p.pageNumber + 1}"
         class="px-4 py-2 rounded-lg bg-white border border-gray-300 text-gray-700 hover:bg-gray-50">下一页</a>
    </c:if>
  </div>
</div>

</body>
</html>