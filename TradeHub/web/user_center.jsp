<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="header.jsp"/>

<div class="min-h-screen bg-gray-100 py-8">
  <div class="max-w-4xl mx-auto px-4">
    <h1 class="text-3xl font-bold text-gray-800 mb-8">个人中心</h1>

    <c:if test="${not empty failMsg}">
      <div class="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-lg mb-4 text-sm">${failMsg}</div>
    </c:if>
    <c:if test="${not empty msg}">
      <div class="bg-green-50 border border-green-200 text-green-700 px-4 py-3 rounded-lg mb-4 text-sm">${msg}</div>
    </c:if>

    <div class="bg-white rounded-2xl shadow-md p-6 mb-6">
      <div class="flex items-center space-x-4">
        <div class="w-16 h-16 bg-blue-100 rounded-full flex items-center justify-center text-2xl font-bold text-blue-600">
          ${user.name.substring(0,1)}
        </div>
        <div>
          <h2 class="text-xl font-bold text-gray-800">${user.name}</h2>
          <p class="text-gray-500 text-sm">学号：${user.studentId} | ${user.school}</p>
          <c:if test="${user.isadmin}">
            <span class="inline-block bg-red-100 text-red-700 text-xs px-2 py-0.5 rounded mt-1">管理员</span>
          </c:if>
        </div>
      </div>
    </div>

    <div class="flex flex-wrap gap-2 mb-6">
      <a href="${pageContext.request.contextPath}/user?method=center"
         class="px-4 py-2 rounded-lg bg-blue-600 text-white text-sm font-medium">个人信息</a>
      <a href="${pageContext.request.contextPath}/user?method=myProducts"
         class="px-4 py-2 rounded-lg bg-white border border-gray-300 text-gray-700 text-sm font-medium hover:bg-gray-50">我发布的</a>
      <a href="${pageContext.request.contextPath}/user?method=myFavorites"
         class="px-4 py-2 rounded-lg bg-white border border-gray-300 text-gray-700 text-sm font-medium hover:bg-gray-50">我收藏的</a>
      <a href="${pageContext.request.contextPath}/order?method=myOrders"
         class="px-4 py-2 rounded-lg bg-white border border-gray-300 text-gray-700 text-sm font-medium hover:bg-gray-50">我的订单</a>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
      <div class="bg-white rounded-2xl shadow-md p-6">
        <h3 class="text-lg font-bold text-gray-800 mb-4">修改个人信息</h3>
        <form action="${pageContext.request.contextPath}/user" method="post" class="space-y-4">
          <input type="hidden" name="method" value="changeAddress">
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">姓名</label>
            <input type="text" name="name" value="${user.name}" required
                   class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
          </div>
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">手机号</label>
            <input type="text" name="phone" value="${user.phone}"
                   class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
          </div>
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">地址</label>
            <input type="text" name="address" value="${user.address}"
                   class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
          </div>
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">学校</label>
            <input type="text" name="school" value="${user.school}"
                   class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
          </div>
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">QQ号</label>
            <input type="text" name="qq" value="${user.qq}"
                   class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
          </div>
          <button type="submit"
                  class="bg-blue-600 text-white px-6 py-2 rounded-lg font-semibold hover:bg-blue-700 transition-colors">
            保存修改
          </button>
        </form>
      </div>

      <div class="bg-white rounded-2xl shadow-md p-6">
        <h3 class="text-lg font-bold text-gray-800 mb-4">修改密码</h3>
        <form action="${pageContext.request.contextPath}/user" method="post" class="space-y-4">
          <input type="hidden" name="method" value="changePwd">
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">原密码</label>
            <input type="password" name="password" required
                   class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
          </div>
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">新密码</label>
            <input type="password" name="newPassword" required
                   class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
          </div>
          <button type="submit"
                  class="bg-blue-600 text-white px-6 py-2 rounded-lg font-semibold hover:bg-blue-700 transition-colors">
            修改密码
          </button>
        </form>
      </div>
    </div>
  </div>
</div>

<jsp:include page="footer.jsp"/>